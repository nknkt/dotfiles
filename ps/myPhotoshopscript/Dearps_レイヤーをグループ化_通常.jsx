// =======================================================
var idMk = charIDToTypeID( "Mk  " );
    var desc33 = new ActionDescriptor();
    var idnull = charIDToTypeID( "null" );
        var ref8 = new ActionReference();
        var idlayerSection = stringIDToTypeID( "layerSection" );
        ref8.putClass( idlayerSection );
    desc33.putReference( idnull, ref8 );
    var idFrom = charIDToTypeID( "From" );
        var ref9 = new ActionReference();
        var idLyr = charIDToTypeID( "Lyr " );
        var idOrdn = charIDToTypeID( "Ordn" );
        var idTrgt = charIDToTypeID( "Trgt" );
        ref9.putEnumerated( idLyr, idOrdn, idTrgt );
    desc33.putReference( idFrom, ref9 );
    var idUsng = charIDToTypeID( "Usng" );
        var desc34 = new ActionDescriptor();
        var idMd = charIDToTypeID( "Md  " );
        var idBlnM = charIDToTypeID( "BlnM" );
        var idNrml = charIDToTypeID( "Nrml" );
        desc34.putEnumerated( idMd, idBlnM, idNrml );
    var idlayerSection = stringIDToTypeID( "layerSection" );
    desc33.putObject( idUsng, idlayerSection, desc34 );
executeAction( idMk, desc33, DialogModes.NO );

