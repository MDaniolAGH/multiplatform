/**
 * Only reveal the quiz content section (after ---) when the answer is correct.
 *
 * The mkdocs_quiz plugin always shows the content section after any submission.
 * This override re-hides it when the answer is incorrect, creating a "reward"
 * that only appears for correct answers.
 */
(function () {
  /**
   * Hide content sections for any quiz whose feedback indicates "incorrect".
   * Covers both fresh submissions and state restored from localStorage.
   */
  function hideIncorrectContent() {
    document.querySelectorAll(".quiz").forEach(function (quiz) {
      var feedback = quiz.querySelector(".quiz-feedback");
      var section = quiz.querySelector("section.content");
      if (!feedback || !section) return;

      if (feedback.classList.contains("incorrect")) {
        section.classList.add("hidden");
      }
    });
  }

  /**
   * Attach submit listeners so content is re-hidden after incorrect answers.
   */
  function patchQuizReveal() {
    document.querySelectorAll(".quiz form").forEach(function (form) {
      if (form.dataset.correctOnlyPatched) return;
      form.dataset.correctOnlyPatched = "true";

      form.addEventListener("submit", function () {
        // Run after the quiz.js handler completes
        setTimeout(function () {
          var quiz = form.closest(".quiz");
          if (!quiz) return;

          var feedback = form.querySelector(".quiz-feedback");
          var section = quiz.querySelector("section.content");
          if (!feedback || !section) return;

          if (feedback.classList.contains("incorrect")) {
            section.classList.add("hidden");
          }
        }, 0);
      });
    });

    // Also fix any already-restored incorrect states (localStorage)
    hideIncorrectContent();
  }

  // Patch on initial load — use a short delay to run after quiz.js
  // restores saved state from localStorage
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", function () {
      setTimeout(patchQuizReveal, 50);
    });
  } else {
    setTimeout(patchQuizReveal, 50);
  }

  // Re-patch after encryptcontent decryption (quiz DOM is recreated)
  window.addEventListener("encryptcontent_event", function () {
    setTimeout(patchQuizReveal, 200);
  });
})();
