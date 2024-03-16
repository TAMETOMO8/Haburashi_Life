'use strict';

document.addEventListener('turbo:load', () => {
  const environmentImage = document.querySelector('.environment-wrapper');
  const improvementCount = document.querySelector('.improvement-count');
  const count = improvementCount.textContent.replace(/[^0-9]/g, '');

  if (environmentImage) {
    const grayscale = (100 - count);
    environmentImage.style.filter = "grayscale(" + grayscale + "%)";
  }
});