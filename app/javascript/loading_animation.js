'use strict';

const btn = document.querySelector('#only-click');
const form = document.querySelector('#search-form');
const anime = document.querySelector('#loading_animation');
const text = document.querySelector('#loading_text');

btn.addEventListener('click', () => {
  form.style.display = 'none';
  anime.style.display = 'block';
  text.style.display = 'block';
});
