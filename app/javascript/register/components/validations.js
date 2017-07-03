var phone = require('phone');

export const required = value =>
  value ? undefined : 'Это нужно заполнить'

export const requiredPhotos = value =>
  (value && value.length > 0) ? undefined : 'Пожалуйста, загрузите хотя бы одну фотографию'

export const smallAbout = value =>
  value && value.length < 10 ? 'Ну совсем короткий рассказ :(' : undefined

export const warnSmallAbout = value =>
  value && value.length < 50 ? 'Может, напишите что нибудь еще?' : undefined

export const phoneRus = value =>
  phone(value, 'RUS').length > 0 ? undefined : 'Это точно номер телефона?'
