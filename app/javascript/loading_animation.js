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