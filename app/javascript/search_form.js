'use strict';

document.addEventListener('turbo:load', () => {
  const btn = document.querySelector('#search-start');
  const form = document.querySelector('#search-form');
  const anime = document.querySelector('#loading_animation');
  const text = document.querySelector('#loading_text');

  if (anime) {
    btn.addEventListener('click', () => {
      form.style.display = 'none';
      anime.style.display = 'block';
      text.style.display = 'block';
    });
  }
});

document.addEventListener('turbo:load', () => {
  const dropdownItems = document.querySelectorAll('#dropdown-text');
  const form = document.querySelector('#text-form');

  if (form) {
    dropdownItems.forEach((item) => {
      item.addEventListener('click', () => {
        form.value = item.textContent;
      });
    });
  }
});

document.addEventListener('turbo:load', () => {
  const buttons = document.querySelectorAll('.page-link');
  const text = document.querySelector('#loading_text');

  if (buttons) {
    buttons.forEach((button) => {
      button.addEventListener('click', () => {
        text.style.display = 'block';
      });
    });
  }
});