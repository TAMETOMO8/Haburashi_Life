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


document.addEventListener('turbo:load', () => {
  const editBtn = document.querySelector('.edit-button');
  const beforeBtn = document.querySelector('.time-before-button');
  const timeSelect = document.querySelector('.time-select');
  const timeNow = new Date();
  timeNow.setHours(0, 0, 0, 0);

  if (editBtn) {
    timeSelect.addEventListener('change', () => {
      const [year, month, day] = timeSelect.value.split('-');
      const selectDay = new Date(year, month - 1, day);
      selectDay.setHours(0, 0, 0, 0);

      if (timeNow > selectDay) {
        beforeBtn.style.display = 'block';
        editBtn.style.display = 'none';
      } else {
        beforeBtn.style.display = 'none';
        editBtn.style.display = 'block';
      }
    });
  }
});