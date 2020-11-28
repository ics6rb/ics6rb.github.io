// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// Так подключаются JS-аспекты Bootstrap.
require('bootstrap')

// Нужно, чтобы при нажатии кнопки копировать в буфер обмена.
const copy = require('copy-to-clipboard')

// В Rails используются turbolinks, чтобы при переходе по ссылкам перерисовывалось только body с помощью AJAX.
// Поэтому навешивание на события типа DOMContentLoaded вообще не пойдет, нужно turbolinks:load
$(document).on('turbolinks:load', function () {
  // По клику на ссылку с надписью "Скопировать в буфер обмена" будет происходить копирование.
  $('.btn-copy-to-clipboard').on('click', function (evt) {
    // Это нужно потому, что при клике на ссылку браузер переходит по href, а нам нужно только копирование.
    evt.preventDefault()

    // Копирование с помощью установленной либы.
    copy($(this).attr('data-copy-content'))

    // Показ всплывашки с надписью "Скопировано".
    $(this).tooltip('enable')
    $(this).tooltip('show')

    setTimeout(() => {
      $(this).tooltip('hide')
      $(this).tooltip('disable')
    }, 1700)
  })
})

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
