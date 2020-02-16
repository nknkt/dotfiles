var selectItem = app.activeDocument.selection;

(function () {
  var selectImage = [];
  for (var i = 0; i < selectItem.length; i++){
    if (selectItem[i].constructor.name == 'PlacedItem') {
      selectImage.push(selectItem[i]);
    }
  }
  if (selectImage.length == 0) {
    alert('［埋め込み］ができる画像が選択されていません');
    return false;
  }
  for (var i = 0; i < selectImage.length; i++){
    selectImage[i].embed();
  }
  return false;
}());