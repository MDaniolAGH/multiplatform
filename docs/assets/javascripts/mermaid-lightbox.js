/* Click-to-enlarge lightbox for Mermaid diagrams rendered by Material for MkDocs.
   Material renders mermaid SVGs inside a closed shadow DOM, so we patch
   attachShadow to force open mode on .mermaid containers. This must load
   before Material's bundle. Works with the encryptcontent plugin. */
(function () {
  // --- Patch attachShadow so .mermaid containers get an open shadow root ---
  var origAttachShadow = Element.prototype.attachShadow;
  Element.prototype.attachShadow = function (opts) {
    if (this.classList && this.classList.contains('mermaid')) {
      opts = Object.assign({}, opts, { mode: 'open' });
    }
    return origAttachShadow.call(this, opts);
  };

  // --- Lightbox ---
  function openLightbox(svg) {
    if (document.querySelector('.mermaid-lightbox')) return;

    var overlay = document.createElement('div');
    overlay.className = 'mermaid-lightbox';

    var clone = svg.cloneNode(true);
    clone.removeAttribute('style');
    clone.removeAttribute('width');
    clone.setAttribute('width', '100%');
    clone.setAttribute('height', 'auto');

    var close = document.createElement('button');
    close.className = 'mermaid-lightbox-close';
    close.innerHTML = '&times;';

    overlay.appendChild(clone);
    overlay.appendChild(close);
    document.body.appendChild(overlay);
    requestAnimationFrame(function () { overlay.classList.add('active'); });

    // --- zoom & pan ---
    var scale = 1, px = 0, py = 0, dragging = false, sx = 0, sy = 0;
    function apply() {
      clone.style.transform = 'translate(' + px + 'px,' + py + 'px) scale(' + scale + ')';
    }

    clone.addEventListener('mousedown', function (e) {
      e.stopPropagation(); dragging = true;
      sx = e.clientX - px; sy = e.clientY - py;
      clone.style.cursor = 'grabbing';
    });
    var moveFn = function (e) {
      if (!dragging) return;
      px = e.clientX - sx; py = e.clientY - sy; apply();
    };
    var upFn = function () {
      dragging = false; clone.style.cursor = 'grab';
    };
    window.addEventListener('mousemove', moveFn);
    window.addEventListener('mouseup', upFn);
    overlay.addEventListener('wheel', function (e) {
      e.preventDefault();
      scale = Math.max(0.3, Math.min(8, scale + (e.deltaY < 0 ? 0.15 : -0.15)));
      apply();
    }, { passive: false });

    // --- close ---
    function remove() {
      overlay.classList.remove('active');
      setTimeout(function () {
        if (overlay.parentNode) overlay.parentNode.removeChild(overlay);
      }, 200);
      document.removeEventListener('keydown', esc);
      window.removeEventListener('mousemove', moveFn);
      window.removeEventListener('mouseup', upFn);
    }
    function esc(e) { if (e.key === 'Escape') remove(); }
    overlay.addEventListener('click', remove);
    close.addEventListener('click', remove);
    clone.addEventListener('click', function (e) { e.stopPropagation(); });
    document.addEventListener('keydown', esc);
  }

  // --- Enhance mermaid containers with click-to-enlarge ---
  function enhance(container) {
    if (container.dataset.lbReady) return;
    container.dataset.lbReady = '1';
    container.style.cursor = 'zoom-in';
    container.addEventListener('click', function () {
      // With the patched open shadow root, we can reach the SVG
      var svg = container.shadowRoot
        ? container.shadowRoot.querySelector('svg')
        : container.querySelector('svg');
      if (svg) openLightbox(svg);
    });
  }

  function scan() {
    document.querySelectorAll('.mermaid').forEach(function (el) {
      var hasSvg = el.shadowRoot
        ? el.shadowRoot.querySelector('svg')
        : el.querySelector('svg');
      if (hasSvg) enhance(el);
    });
  }

  // Initial scan + periodic retry (handles encryptcontent decryption delay)
  function init() {
    scan();
    var tries = 0;
    var interval = setInterval(function () {
      scan();
      if (++tries > 30) clearInterval(interval);
    }, 500);
  }

  // Observe DOM for dynamically added mermaid diagrams
  var observer = new MutationObserver(function () { scan(); });
  observer.observe(document.body || document.documentElement, { childList: true, subtree: true });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
