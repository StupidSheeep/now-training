document.addEventListener("DOMContentLoaded", function () {
  const introductionText = document.getElementById("introduction-text");
  const introductionCount = document.getElementById("introduction-count");

  // 初期文字数を設定
  const initialCharCount = introductionText.value.length;
  introductionCount.textContent = initialCharCount + "文字";

  introductionText.addEventListener("input", function () {
    const inputText = introductionText.value;
    const charCount = inputText.length;

    introductionCount.textContent = charCount + "文字";

    if (charCount > 100) {
      introductionCount.style.color = "red"; // 文字色を赤に変更
    } else {
      introductionCount.style.color = "grey"; // 文字色を元に戻す
    }
  });
});
