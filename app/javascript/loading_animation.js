'use strict';

const btn = document.querySelector('#only-click');
const form = document.querySelector('#search-form');
const anime = document.querySelector('#loading_animation');

btn.addEventListener('click', () => {
  if (anime.style.display == 'none' && form.style.display == 'block') {
    form.style.display = 'none';
    anime.style.display = 'block';
  } else {
    form.style.display = 'none';
    anime.style.display = 'block';
  };
});
