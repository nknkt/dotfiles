function updateImageSizeHTML(editor, isRetina) {
  var offset = editor.getCaretPos(),
      rate = isRetina ? 0.5 : 1;

  // find tag from current caret position
  var info = require('editorUtils').outputInfo(editor);
  var xmlElem = require('xmlEditTree').parseFromPosition(info.content, offset, true);
  if (xmlElem && (xmlElem.name() || '').toLowerCase() == 'img') {
    getImageSizeForSource(editor, xmlElem.value('src'), function(size) {
      if (size) {
        var compoundData = xmlElem.range(true);
        xmlElem.value('width', Math.floor(size.width * rate));
        xmlElem.value('height', Math.floor(size.height * rate), xmlElem.indexOf('width') + 1);

        require('actionUtils').compoundUpdate(editor, _.extend(compoundData, {
          data: xmlElem.toString(),
          caret: offset
        }));
      }
    });
  }
}

function updateImageSizeCSS(editor, isRetina) {
  var offset = editor.getCaretPos(),
      rate = isRetina ? 0.5 : 1;

  // find tag from current caret position
  var info = require('editorUtils').outputInfo(editor);
  var cssRule = require('cssEditTree').parseFromPosition(info.content, offset, true);
  if (cssRule) {
    // check if there is property with image under caret
    var prop = cssRule.itemFromPosition(offset, true), m;
    if (prop && (m = /url\((["']?)(.+?)\1\)/i.exec(prop.value() || ''))) {
      getImageSizeForSource(editor, m[2], function(size) {
        if (size) {
          var compoundData = cssRule.range(true);
          cssRule.value('width', Math.floor(size.width * rate) + 'px');
          cssRule.value('height', Math.floor(size.height * rate) + 'px', cssRule.indexOf('width') + 1);

          require('actionUtils').compoundUpdate(editor, _.extend(compoundData, {
            data: cssRule.toString(),
            caret: offset
          }));
        }
      });
    }
  }
}

require('actions').add('update_image_size', function(editor) {
  // this action will definitely won’t work in SASS dialect,
  // but may work in SCSS or LESS
  if (_.include(['css', 'less', 'scss'], String(editor.getSyntax()))) {
    updateImageSizeCSS(editor, false);
  } else {
    updateImageSizeHTML(editor, false);
  }

  return true;
});
// for Retina ★下記追記
require('actions').add('update_image_size_for_retina', function(editor) {
  // this action will definitely won’t work in SASS dialect,
  // but may work in SCSS or LESS
  if (_.include(['css', 'less', 'scss'], String(editor.getSyntax()))) {
    updateImageSizeCSS(editor, true);
  } else {
    updateImageSizeHTML(editor, true);
  }

  return true;
});