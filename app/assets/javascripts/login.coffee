centerPopup = (linkUrl, width, height) ->
  sep = if linkUrl.indexOf('?') != -1 then '&' else '?'
  url = linkUrl + sep + 'popup=true'
  left = (screen.width - width) / 2 - 16
  top = (screen.height - height) / 2 - 50
  windowFeatures = 'menubar=no,toolbar=no,status=no,width=' + width + ',height=' + height + ',left=' + left + ',top=' + top
  window.open url, 'authPopup', windowFeatures

$(document).ready ->
  $('.js-popup').click ->
    centerPopup $(this).attr('href'), $(this).attr('data-width'), $(this).attr('data-height')
    false
  return
