
var activelay = app.activeDocument.activeLayer;

function copyTextToClipboard(text){
    const keyTextData = app.charIDToTypeID('TxtD');
    const keyTextToClipboardStr = app.stringIDToTypeID( "textToClipboard" );
    var textStrDesc = new ActionDescriptor();
    textStrDesc.putString( keyTextData, text );
    executeAction( keyTextToClipboardStr, textStrDesc, DialogModes.NO );
}

if( activelay.kind == LayerKind.TEXT ) {
    var selectContents = activelay.textItem.contents;
    copyTextToClipboard(selectContents);
} else {
    alert('選択したレイヤーはテキストレイヤーではないようです');
}
