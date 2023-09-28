/*global $*/
$(document).on("turbolinks:load", function () {
  const Introduction = document.getElementById('introduction-text');
  const countIntroduction = document.getElementById('introduction-count');

  // ページが読み込まれた際に前回の文字数を復元する
  const savedLength = localStorage.getItem('introductionLength');
  if (savedLength !== null) {
    Introduction.value = savedLength;
    countIntroduction.innerHTML = `${savedLength}文字`;
  }

  Introduction.addEventListener("input", () => {
    let introductionLength = Introduction.value.length;
    if (introductionLength > 100) {
      introductionLength = 100;
      countIntroduction.style.color = 'red'; // 赤色に設定
    } else {
      countIntroduction.style.color = ''; // 色をリセット
    }
    countIntroduction.innerHTML = `${introductionLength}文字`;

    // 文字数をローカルストレージに保存
    /*  global localStorage */
    localStorage.setItem('introductionLength', introductionLength);
  });
});
