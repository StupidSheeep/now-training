// ページが読み込まれたときと、テキストが入力されたときの両方で初期文字数と文字色を設定
function updateCharCount() {
  const introductionText = document.getElementById("introduction-text");
  const introductionCount = document.getElementById("introduction-count");

  const charCount = introductionText.value.length;
  introductionCount.textContent = charCount + "文字";

  if (charCount > 100) {
    introductionCount.style.color = "red"; // 文字色を赤に変更
  } else {
    introductionCount.style.color = "black"; // 文字色を元に戻す
  }
}

document.addEventListener("DOMContentLoaded", updateCharCount);

// テキストが入力されたときにも呼び出す
const introductionText = document.getElementById("introduction-text");
introductionText.addEventListener("input", updateCharCount);
