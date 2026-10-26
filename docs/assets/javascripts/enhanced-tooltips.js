/**
 * Enhanced glossary tooltips — self-contained implementation.
 *
 * Shows a styled floating tooltip with:
 *   - Bold term name (header, black)
 *   - Thin separator line
 *   - Regular-weight definition (body)
 *
 * Works with both plain pages AND encryptcontent-decrypted pages
 * by observing the DOM for new <abbr> elements at any time.
 */
;(function () {
  "use strict"

  /* ── Tooltip DOM element (singleton, reused) ─────────── */
  var tip = null

  function ensureTip() {
    if (tip) return tip
    tip = document.createElement("div")
    tip.className = "gl-tooltip"
    tip.setAttribute("role", "tooltip")
    tip.style.cssText =
      "position:fixed;z-index:999;pointer-events:none;" +
      "opacity:0;transition:opacity .18s ease,transform .18s ease;" +
      "transform:translateY(4px);"
    document.body.appendChild(tip)
    return tip
  }

  /* ── Show / hide ─────────────────────────────────────── */
  var hideTimer = null

  function show(abbr) {
    clearTimeout(hideTimer)
    var t = ensureTip()
    var term = abbr.textContent.trim()

    /* Read definition: prefer stored original, fall back to attribute */
    var def = abbr._glDef || abbr.getAttribute("title") || ""
    if (!def) return

    /* Store definition permanently and strip title to prevent native tooltip */
    if (!abbr._glDef) {
      abbr._glDef = def
      abbr.removeAttribute("title")
    }

    t.innerHTML =
      '<div class="gl-tooltip__term">' + esc(term) + "</div>" +
      '<div class="gl-tooltip__body">' + esc(def) + "</div>"

    /* Position near the element */
    var r = abbr.getBoundingClientRect()
    var tw = Math.min(460, window.innerWidth - 32)
    t.style.maxWidth = tw + "px"
    t.style.visibility = "hidden"
    t.style.opacity = "0"
    t.style.display = "block"

    /* Measure then position */
    requestAnimationFrame(function () {
      var th = t.offsetHeight
      var ttw = t.offsetWidth
      var left = r.left + r.width / 2 - ttw / 2
      var top = r.top - th - 10

      /* Clamp horizontally */
      if (left < 12) left = 12
      if (left + ttw > window.innerWidth - 12)
        left = window.innerWidth - 12 - ttw

      /* Flip below if no room above */
      if (top < 12) top = r.bottom + 10

      t.style.left = left + "px"
      t.style.top = top + "px"
      t.style.visibility = "visible"
      t.style.opacity = "1"
      t.style.transform = "translateY(0)"
    })
  }

  function hide() {
    hideTimer = setTimeout(function () {
      if (tip) {
        tip.style.opacity = "0"
        tip.style.transform = "translateY(4px)"
      }
    }, 100)
  }

  /* ── Bind events to <abbr> elements ──────────────────── */
  function bindAbbr(el) {
    if (el._glBound) return
    el._glBound = true

    /* Skip abbreviations inside quiz elements — tooltips spoil answers */
    if (el.closest(".quiz")) {
      var title = el.getAttribute("title")
      if (title) el.removeAttribute("title")   // strip native tooltip too
      return
    }

    /* Store definition immediately so it survives title removal */
    var title = el.getAttribute("title")
    if (title) {
      el._glDef = title
      el.removeAttribute("title")
    }

    el.addEventListener("pointerenter", function () { show(el) })
    el.addEventListener("pointerleave", function () { hide() })
    el.addEventListener("focusin", function () { show(el) })
    el.addEventListener("focusout", function () { hide() })
  }

  function scanAndBind(root) {
    var els = (root || document).querySelectorAll("abbr[title]")
    for (var i = 0; i < els.length; i++) bindAbbr(els[i])
  }

  /* ── Initial scan + MutationObserver for encrypted pages ── */
  scanAndBind()
  document.addEventListener("DOMContentLoaded", function () { scanAndBind() })

  var observer = new MutationObserver(function (mutations) {
    for (var i = 0; i < mutations.length; i++) {
      var added = mutations[i].addedNodes
      for (var j = 0; j < added.length; j++) {
        if (added[j].nodeType === 1) scanAndBind(added[j])
      }
    }
  })
  observer.observe(document.documentElement, { childList: true, subtree: true })

  /* ── Utility ─────────────────────────────────────────── */
  function esc(s) {
    var d = document.createElement("div")
    d.textContent = s
    return d.innerHTML
  }
})()
