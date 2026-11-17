/*
 * Agentic SDLC guide: the interactive pipeline map and the audit walk.
 *
 * Map:
 *  - draws the arrows between stages, the feedback loops and the knowledge flows;
 *  - "Walk through" moves a work item along the pipeline with a narration;
 *  - layers: feedback loops, knowledge flows, audit trail (records + trace back);
 *  - clicking a document in the project knowledge shows which stages read it;
 *  - actor buttons highlight one actor's stages; arrow keys step the walk.
 * Audit walk: steps back from a line of code to the goal; links can be broken.
 *
 * Without JavaScript, stages and documents are plain links to their sections
 * and the audit walk shows every step.
 */
(function () {
  "use strict";

  var SVG = "http://www.w3.org/2000/svg";

  function el(name, attrs, parent) {
    var node = document.createElementNS(SVG, name);
    Object.keys(attrs || {}).forEach(function (k) { node.setAttribute(k, attrs[k]); });
    if (parent) parent.appendChild(node);
    return node;
  }

  function marker(defs, id, cls) {
    var m = el("marker", { id: id, "class": cls, viewBox: "0 0 10 10", refX: "9", refY: "5",
      markerWidth: "7", markerHeight: "7", orient: "auto-start-reverse" }, defs);
    el("path", { d: "M0,0 L10,5 L0,10 z" }, m);
  }

  function curveDown(x1, y1, x2, y2) {
    var m = (y1 + y2) / 2;
    return "M" + x1 + "," + y1 + " C" + x1 + "," + m + " " + x2 + "," + m + " " + x2 + "," + y2;
  }

  /* ------------------------------------------------------------------ */
  /* Pipeline map                                                        */
  /* ------------------------------------------------------------------ */

  function initMap(root) {
    var map = root.querySelector(".sdlc-map");
    if (!map || map.dataset.ready) return;
    map.dataset.ready = "1";
    root.classList.add("is-js");

    var panel = root.querySelector(".sdlc-panel");
    var kbBox = map.querySelector(".sdlc-kb");
    var rail = map.querySelector(".sdlc-rail");
    var railFill = map.querySelector(".sdlc-rail__fill");
    var status = root.querySelector(".sdlc-toolbar__status");
    var playBtn = root.querySelector('[data-action="play"]');
    var prevBtn = root.querySelector('[data-action="prev"]');
    var nextBtn = root.querySelector('[data-action="next"]');

    var stages = {};
    var ordered = [];
    map.querySelectorAll("a.sdlc-stage").forEach(function (s) {
      stages[s.dataset.stage] = s;
      ordered.push(s);
    });
    ordered.sort(function (a, b) { return (+a.dataset.order) - (+b.dataset.order); });

    var steps = Array.prototype.map.call(root.querySelectorAll("ol.sdlc-walk > li"), function (li) {
      return { stage: li.dataset.stage, result: li.dataset.result || "", html: li.innerHTML };
    });

    var wires = el("svg", { "class": "sdlc-wires", "aria-hidden": "true" });
    var tokens = el("svg", { "class": "sdlc-wires sdlc-tokens", "aria-hidden": "true" });
    map.appendChild(wires);
    map.appendChild(tokens);
    var token = el("circle", { r: "7", "class": "sdlc-token", visibility: "hidden" }, tokens);

    var state = { step: -1, doc: null, audit: false, selected: null, timer: null, raf: null, tokenAt: null };
    var paths = {};
    var dynLayer = null;

    function html(container, attr, key) {
      var n = root.querySelector(container + " [data-" + attr + '="' + key + '"]');
      return n ? n.innerHTML : "";
    }

    function box(node) {
      var b = map.getBoundingClientRect();
      var r = node.getBoundingClientRect();
      var x = r.left - b.left;
      var y = r.top - b.top;
      return { x: x, y: y, w: r.width, h: r.height, r: x + r.width, b: y + r.height,
        cx: x + r.width / 2, cy: y + r.height / 2 };
    }

    function nodeOf(key) { return key === "kb" ? kbBox : stages[key]; }
    function chipOf(node) { return node ? getComputedStyle(node).getPropertyValue("--chip") : ""; }

    /* ----- drawing ----- */

    function draw() {
      while (wires.firstChild) wires.removeChild(wires.firstChild);
      paths = {};
      var defs = el("defs", {}, wires);
      marker(defs, "sdlc-m-grey", "m-grey");
      marker(defs, "sdlc-m-loop", "m-loop");
      marker(defs, "sdlc-m-fail", "m-fail");
      marker(defs, "sdlc-m-kb", "m-kb");
      var base = el("g", {}, wires);
      var loops = el("g", { "class": "layer-loops" }, wires);
      var know = el("g", { "class": "layer-knowledge" }, wires);
      dynLayer = el("g", {}, wires);

      function add(g, key, d, cls, mk) {
        paths[key] = el("path", { d: d, "class": cls || "", "marker-end": "url(#" + mk + ")" }, g);
      }
      function label(g, text, x, y, cls, opts) {
        opts = opts || {};
        var t = el("text", { x: String(x), y: String(y), "class": cls, "text-anchor": opts.anchor || "start" }, g);
        if (opts.rotate) t.setAttribute("transform", "rotate(-90 " + x + " " + y + ")");
        t.textContent = text;
      }

      // Forward flow between consecutive stages.
      for (var i = 0; i < ordered.length - 1; i++) {
        var a = box(ordered[i]);
        var b = box(ordered[i + 1]);
        add(base, ordered[i].dataset.stage + ">" + ordered[i + 1].dataset.stage,
          curveDown(a.cx, a.b, b.cx, b.y - 1), "", "sdlc-m-grey");
      }

      var lanesRight = box(map.querySelector(".sdlc-lane--tool")).r;
      var room = map.clientWidth - lanesRight;
      var wide = room >= 30;
      var impl = box(stages.implementation);
      var gate = box(stages.gate);
      var tests = box(stages.tests);
      var review = box(stages.review);
      var plan = box(stages.plan);
      var reqs = box(stages.requirements);
      var docs = box(stages.docs);
      var idea = box(stages.idea);
      var kb = box(kbBox);
      var mx = impl.r + 2;

      // Quality gate fails -> back to implementation (always shown).
      var b1 = lanesRight + room * 0.28;
      add(base, "gate>implementation",
        "M" + gate.r + "," + gate.cy + " C" + b1 + "," + gate.cy + " " + b1 + "," + (impl.cy - 6) + " " + mx + "," + (impl.cy - 6),
        "is-gate-loop", "sdlc-m-fail");
      label(base, "fail → fix", impl.r + 8, impl.cy - 11, "t-fail");

      // More feedback loops (layer).
      var b2 = lanesRight + room * 0.58;
      add(loops, "tests>implementation",
        "M" + tests.r + "," + tests.cy + " C" + b2 + "," + tests.cy + " " + b2 + "," + (impl.cy + 3) + " " + mx + "," + (impl.cy + 3),
        "is-loop", "sdlc-m-loop");
      if (wide) label(loops, "tests fail", b2 - 3, (tests.cy + impl.cy) / 2 + 22, "t-loop", { rotate: true });

      var b3 = lanesRight + room * 0.88;
      var y3 = impl.cy + 12;
      add(loops, "review>implementation",
        "M" + review.r + "," + review.cy + " L" + (b3 - 8) + "," + review.cy +
        " Q" + b3 + "," + review.cy + " " + b3 + "," + (review.cy - 8) +
        " L" + b3 + "," + (y3 + 8) + " Q" + b3 + "," + y3 + " " + (b3 - 8) + "," + y3 +
        " L" + mx + "," + y3,
        "is-loop", "sdlc-m-loop");
      label(loops, "changes requested", review.r + 8, review.cy - 5, "t-loop");

      var b4 = plan.r + 18;
      add(loops, "plan>requirements",
        "M" + plan.r + "," + plan.cy + " C" + b4 + "," + plan.cy + " " + b4 + "," + reqs.cy + " " + (reqs.r + 2) + "," + reqs.cy,
        "is-loop", "sdlc-m-loop");
      label(loops, "unclear → rewrite", b4 + 4, (plan.cy + reqs.cy) / 2 + 3, "t-loop");

      // Knowledge feeds the plan; documentation feeds the knowledge (always shown).
      add(base, "kb>plan", "M" + kb.r + "," + plan.cy + " L" + (plan.x - 1) + "," + plan.cy, "is-kb", "sdlc-m-kb");
      add(base, "docs>kb", "M" + docs.x + "," + docs.cy + " L" + (kb.r + 1) + "," + docs.cy, "is-kb", "sdlc-m-kb");

      // More knowledge flows (layer).
      add(know, "kb>requirements", "M" + kb.r + "," + reqs.cy + " L" + (reqs.x - 1) + "," + reqs.cy, "is-kb-extra", "sdlc-m-kb");
      add(know, "kb>implementation", "M" + kb.r + "," + impl.cy + " L" + (impl.x - 1) + "," + impl.cy, "is-kb-extra", "sdlc-m-kb");
      add(know, "review>kb",
        "M" + review.x + "," + review.cy + " C" + kb.cx + "," + review.cy + " " + kb.cx + "," + review.cy + " " + kb.cx + "," + (kb.b + 1),
        "is-kb-extra", "sdlc-m-kb");
      label(know, "merged", kb.cx + 5, kb.b + 13, "t-kb");
      add(know, "kb>idea",
        "M" + kb.cx + "," + kb.y + " C" + kb.cx + "," + idea.cy + " " + kb.cx + "," + idea.cy + " " + (idea.x - 1) + "," + idea.cy,
        "is-kb-extra", "sdlc-m-kb");
      label(know, "next iteration", kb.x, idea.y - 4, "t-kb");

      if (state.doc) drawDoc(state.doc);
      if (state.tokenAt) placeToken(rest(state.tokenAt));
      if (state.audit && state.selected) trace(state.selected);
    }

    /* ----- the moving work item ----- */

    function rest(key) {
      var b = box(nodeOf(key));
      return { x: b.r - 12, y: b.y + 12 };
    }

    function placeToken(p) {
      token.setAttribute("cx", String(p.x));
      token.setAttribute("cy", String(p.y));
      token.setAttribute("visibility", "visible");
    }

    function moveToken(from, to, animate) {
      if (state.raf) cancelAnimationFrame(state.raf);
      state.tokenAt = to;
      var end = rest(to);
      if (!animate || !from || from === to) { placeToken(end); return; }
      var stored = paths[from + ">" + to];
      var d;
      if (stored) {
        d = stored.getAttribute("d");
      } else {
        var a = box(nodeOf(from));
        var b = box(nodeOf(to));
        d = "M" + a.cx + "," + a.cy + " C" + a.cx + "," + b.cy + " " + b.cx + "," + a.cy + " " + b.cx + "," + b.cy;
      }
      var probe = el("path", { d: d, fill: "none", stroke: "none" }, tokens);
      var len = probe.getTotalLength();
      var start = null;
      var dur = 700;
      function frame(ts) {
        if (start === null) start = ts;
        var f = Math.min(1, (ts - start) / dur);
        var e = f < 0.5 ? 2 * f * f : 1 - Math.pow(-2 * f + 2, 2) / 2;
        placeToken(probe.getPointAtLength(e * len));
        if (f < 1) {
          state.raf = requestAnimationFrame(frame);
        } else {
          probe.remove();
          placeToken(end);
        }
      }
      state.raf = requestAnimationFrame(frame);
    }

    /* ----- selection helpers ----- */

    function clearMarks() {
      ordered.forEach(function (s) { s.classList.remove("is-active", "is-fail", "is-pass"); });
    }

    function clearFilter() {
      map.classList.remove("has-filter");
      ordered.forEach(function (s) { s.classList.remove("is-match"); });
      root.querySelectorAll("button.sdlc-chip[data-actor]").forEach(function (c) { c.setAttribute("aria-pressed", "false"); });
      kbBox.querySelectorAll("a.sdlc-kb__doc").forEach(function (d) { d.classList.remove("is-active"); });
      state.doc = null;
      if (dynLayer) while (dynLayer.firstChild) dynLayer.removeChild(dynLayer.firstChild);
    }

    function setPanel(inner, colour) {
      panel.style.setProperty("--chip", colour || "");
      panel.innerHTML = inner;
    }

    function sectionLink(node) {
      return '<p><a href="' + node.getAttribute("href") + '">Read the full section →</a></p>';
    }

    function trace(key) {
      var upTo = +stages[key].dataset.order;
      ordered.forEach(function (s) { s.classList.toggle("is-traced", +s.dataset.order <= upTo); });
      var rb = box(rail);
      var sb = box(stages[key]);
      railFill.style.height = Math.max(0, sb.cy - rb.y) + "px";
    }

    function untrace() {
      ordered.forEach(function (s) { s.classList.remove("is-traced"); });
      railFill.style.height = "0";
    }

    function selectStage(key) {
      stop();
      clearMarks();
      var s = stages[key];
      s.classList.add("is-active");
      state.selected = key;
      for (var i = 0; i < steps.length; i++) {
        if (steps[i].stage === key) { state.step = i; break; }
      }
      moveToken(state.tokenAt, key, true);
      updateStatus();
      if (state.audit) {
        trace(key);
        setPanel(html(".sdlc-audits", "audit", key) +
          "<p>Highlighted: every stage this record can be traced back through, up to the idea.</p>" + sectionLink(s),
          getComputedStyle(map).getPropertyValue("--sdlc-audit"));
      } else {
        setPanel(html(".sdlc-details", "detail", key) + sectionLink(s), chipOf(s));
      }
    }

    function drawDoc(key) {
      while (dynLayer.firstChild) dynLayer.removeChild(dynLayer.firstChild);
      var doc = kbBox.querySelector('a.sdlc-kb__doc[data-doc="' + key + '"]');
      if (!doc) return;
      var d = box(doc);
      (doc.dataset.feeds || "").split(" ").forEach(function (k) {
        if (!stages[k]) return;
        var s = box(stages[k]);
        var x2 = s.x - 1;
        var y2 = s.cy;
        var mid = (d.r + x2) / 2;
        el("path", { d: "M" + d.r + "," + d.cy + " C" + mid + "," + d.cy + " " + mid + "," + y2 + " " + x2 + "," + y2,
          "class": "is-dyn", "marker-end": "url(#sdlc-m-kb)" }, dynLayer);
      });
    }

    function selectDoc(key, link) {
      stop();
      var again = state.doc === key;
      clearFilter();
      clearMarks();
      if (again) {
        setPanel(html(".sdlc-details", "detail", "kb"), chipOf(kbBox));
        return;
      }
      state.doc = key;
      link.classList.add("is-active");
      map.classList.add("has-filter");
      (link.dataset.feeds || "").split(" ").forEach(function (k) {
        if (stages[k]) stages[k].classList.add("is-match");
      });
      drawDoc(key);
      setPanel(html(".sdlc-kb-details", "kb", key) +
        '<p><a href="' + link.getAttribute("href") + '">Read about project knowledge →</a></p>', chipOf(kbBox));
    }

    /* ----- walk-through ----- */

    function updateStatus() {
      status.textContent = state.step >= 0 ? "Step " + (state.step + 1) + " of " + steps.length : "";
      prevBtn.disabled = state.step <= 0;
      nextBtn.disabled = state.step >= steps.length - 1;
    }

    function go(i, animate) {
      if (i < 0 || i >= steps.length) return;
      var prev = state.step >= 0 ? steps[state.step].stage : state.tokenAt;
      state.step = i;
      var st = steps[i];
      clearMarks();
      clearFilter();
      var node = nodeOf(st.stage);
      if (st.stage === "kb") {
        kbBox.classList.remove("is-pulse");
        void kbBox.offsetWidth; // restart the animation
        kbBox.classList.add("is-pulse");
      } else {
        node.classList.add("is-active");
        if (st.result === "fail") node.classList.add("is-fail");
        if (st.result === "pass") node.classList.add("is-pass");
        state.selected = st.stage;
        if (state.audit) trace(st.stage);
      }
      var detail = html(".sdlc-details", "detail", st.stage);
      setPanel('<span class="sdlc-panel__step">Step ' + (i + 1) + " of " + steps.length + "</span>" +
        '<p class="sdlc-panel__narr">' + st.html + "</p>" + detail, chipOf(node));
      moveToken(prev, st.stage, animate);
      updateStatus();
    }

    function stop() {
      if (state.timer) clearInterval(state.timer);
      state.timer = null;
      playBtn.textContent = "▶ Walk through";
    }

    function play() {
      if (state.timer) { stop(); return; }
      if (state.step >= steps.length - 1) state.step = -1;
      playBtn.textContent = "❚❚ Pause";
      go(state.step + 1, true);
      state.timer = setInterval(function () {
        if (state.step >= steps.length - 1) { stop(); return; }
        go(state.step + 1, true);
      }, 3800);
    }

    playBtn.addEventListener("click", play);
    nextBtn.addEventListener("click", function () { stop(); go(state.step + 1, true); });
    prevBtn.addEventListener("click", function () { stop(); go(state.step - 1, false); });

    root.addEventListener("keydown", function (e) {
      if (e.target.closest("input, textarea, select")) return;
      if (e.key === "ArrowRight") { e.preventDefault(); stop(); go(state.step + 1, true); }
      else if (e.key === "ArrowLeft") { e.preventDefault(); stop(); go(state.step - 1, false); }
      else if (e.key === "Escape") { stop(); clearFilter(); clearMarks(); }
    });

    /* ----- clicks on the map ----- */

    map.addEventListener("click", function (event) {
      var doc = event.target.closest("a.sdlc-kb__doc");
      if (doc) { event.preventDefault(); selectDoc(doc.dataset.doc, doc); return; }
      if (event.target.closest("a.sdlc-kb__title")) {
        event.preventDefault();
        stop();
        clearFilter();
        setPanel(html(".sdlc-details", "detail", "kb") +
          '<p><a href="#knowledge">Read about project knowledge →</a></p>', chipOf(kbBox));
        return;
      }
      var stage = event.target.closest("a.sdlc-stage");
      if (stage) { event.preventDefault(); clearFilter(); selectStage(stage.dataset.stage); }
    });

    /* ----- actor filter ----- */

    var actorChips = root.querySelectorAll("button.sdlc-chip[data-actor]");
    actorChips.forEach(function (chip) {
      chip.addEventListener("click", function () {
        var on = chip.getAttribute("aria-pressed") !== "true";
        clearFilter();
        if (!on) return;
        chip.setAttribute("aria-pressed", "true");
        map.classList.add("has-filter");
        ordered.forEach(function (s) {
          if ((s.dataset.actors || "").split(" ").indexOf(chip.dataset.actor) >= 0) s.classList.add("is-match");
        });
      });
    });

    /* ----- layers ----- */

    root.querySelectorAll("button.sdlc-chip[data-layer]").forEach(function (chip) {
      chip.addEventListener("click", function () {
        var layer = chip.dataset.layer;
        var on = chip.getAttribute("aria-pressed") !== "true";
        chip.setAttribute("aria-pressed", on ? "true" : "false");
        map.classList.toggle("show-" + layer, on);
        if (layer === "audit") {
          state.audit = on;
          if (on) {
            if (state.selected) selectStage(state.selected);
            else setPanel("<h4>Audit trail</h4><p>Every stage now shows the record it leaves behind. " +
              "Click a stage to see its record and to trace it back along the rail.</p>",
              getComputedStyle(map).getPropertyValue("--sdlc-audit"));
          } else {
            untrace();
            if (state.selected) selectStage(state.selected);
          }
        }
        if (layer === "loops" && on) {
          setPanel("<h4>Feedback loops</h4><dl>" +
            "<dt>Gate fails</dt><dd>The exact error goes back to the agent, which fixes the code.</dd>" +
            "<dt>Tests fail</dt><dd>Back to implementation, or to the plan if the approach was wrong.</dd>" +
            "<dt>Changes requested</dt><dd>The reviewer sends the pull request back.</dd>" +
            "<dt>Plan unclear</dt><dd>A plan that cannot be approved often means the criteria are unclear: rewrite them.</dd>" +
            "</dl><p>The pipeline is drawn top to bottom, but real work loops. Each loop is cheaper the earlier it starts.</p>",
            getComputedStyle(map).getPropertyValue("--sdlc-loop"));
        }
        if (layer === "knowledge" && on) {
          setPanel("<h4>Knowledge flows</h4><p>The project knowledge feeds requirements, the <b>plan</b> and " +
            "implementation. Documentation updates it in the same pull request; after the merge, the next " +
            "iteration starts from the updated knowledge. Click a document to see exactly which stages read it.</p>",
            chipOf(kbBox));
        }
      });
    });

    /* ----- layout ----- */

    draw();
    updateStatus();
    if (window.ResizeObserver) new ResizeObserver(function () { draw(); }).observe(map);
    else window.addEventListener("resize", draw);
  }

  /* ------------------------------------------------------------------ */
  /* Audit walk                                                          */
  /* ------------------------------------------------------------------ */

  function initWalk(w) {
    if (w.dataset.ready) return;
    w.dataset.ready = "1";
    w.classList.add("is-js");

    var steps = Array.prototype.slice.call(w.querySelectorAll("li.audit-walk__step"));
    var end = w.querySelector("li.audit-walk__end");
    var breaks = {};
    w.querySelectorAll("li.audit-walk__break").forEach(function (b) { breaks[b.dataset.break] = b; });
    var back = w.querySelector('[data-walk="back"]');
    var reset = w.querySelector('[data-walk="reset"]');
    var count = w.querySelector(".audit-walk__count");
    var pos = 0;

    function broken(name) {
      var cb = w.querySelector('input[data-break="' + name + '"]');
      return !!(cb && cb.checked);
    }

    function show(li) {
      w.querySelectorAll("li.is-current").forEach(function (c) { c.classList.remove("is-current"); });
      li.classList.add("is-shown", "is-current");
      li.scrollIntoView({ block: "nearest", behavior: "smooth" });
    }

    function start() {
      w.querySelectorAll("ol.audit-walk__steps > li").forEach(function (li) { li.classList.remove("is-shown", "is-current"); });
      pos = 0;
      steps[0].classList.add("is-shown", "is-current");
      back.disabled = false;
      count.textContent = "Step 1 of " + steps.length;
    }

    function step() {
      var next = pos + 1;
      if (next >= steps.length) {
        show(end);
        back.disabled = true;
        count.textContent = "Trail complete";
        return;
      }
      var need = steps[next].dataset.needs;
      if (need && broken(need) && breaks[need]) {
        show(breaks[need]);
        back.disabled = true;
        count.textContent = "Trail lost after " + (pos + 1) + " of " + steps.length + " steps";
        return;
      }
      pos = next;
      show(steps[pos]);
      count.textContent = "Step " + (pos + 1) + " of " + steps.length;
    }

    back.addEventListener("click", step);
    reset.addEventListener("click", start);
    w.querySelectorAll("input[data-break]").forEach(function (cb) { cb.addEventListener("change", start); });
    start();
  }

  function init() {
    document.querySelectorAll(".sdlc").forEach(initMap);
    document.querySelectorAll(".audit-walk").forEach(initWalk);
  }

  if (window.document$ && typeof window.document$.subscribe === "function") {
    window.document$.subscribe(init);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
