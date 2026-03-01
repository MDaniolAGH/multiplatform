/**
 * Re-execute inline <script> tags after encryptcontent decryption.
 *
 * The mkdocs-encryptcontent-plugin encrypts the full page content, including
 * any <script> and <style> tags appended by other plugins (e.g. mkdocs-quiz).
 * When decrypted, the content is injected via innerHTML, but browsers do NOT
 * execute <script> tags inserted this way. This loader listens for the
 * decryption event and re-creates each script element so the browser runs it.
 */
(function () {
  function reloadDecryptedScripts() {
    var decrypted = document.getElementById('mkdocs-decrypted-content');
    if (!decrypted) return;

    var scripts = decrypted.querySelectorAll('script');
    scripts.forEach(function (oldScript) {
      var newScript = document.createElement('script');

      // Copy attributes
      Array.from(oldScript.attributes).forEach(function (attr) {
        newScript.setAttribute(attr.name, attr.value);
      });

      // Copy inline content
      if (oldScript.textContent) {
        newScript.textContent = oldScript.textContent;
      }

      oldScript.parentNode.replaceChild(newScript, oldScript);
    });
  }

  // Listen for the encryptcontent decryption event
  window.addEventListener('encryptcontent_event', reloadDecryptedScripts);

  // Safety: if decryption already completed before this script loaded,
  // run immediately. The encryptcontent plugin sets this global flag.
  if (window.encryptcontent_done) {
    reloadDecryptedScripts();
  }
})();
