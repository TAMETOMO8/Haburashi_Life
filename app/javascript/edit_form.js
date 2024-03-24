'use strict';

document.addEventListener('turbo:load', () => {
  const brushSelect = document.querySelector('.brush-select');
  const endUse = document.querySelector('.end-use-at-label');
  const startButton = document.querySelector('.start-button');

  if (startButton) {
    brushSelect.addEventListener('change', () => {
      if (brushSelect.value == 'electric') {
        endUse.textContent = '電動歯ブラシの交換予定日';
      } else {
        endUse.textContent = '使用終了日(目安として一ヶ月後の日付を表示しています)';
      }
    });
  }
});