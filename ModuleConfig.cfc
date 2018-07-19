component {

    this.name = "coldbox-asset-bag";
    this.author = "";
    this.webUrl = "https://github.com/elpete/coldbox-asset-bag";

    function configure() {}

    function preProcess( event, interceptData, buffer, rc, prc ) {
        prc.assetBag = wirebox.getInstance( "AssetBag@coldbox-asset-bag" );

        /*
        var handler = listLast( event.getCurrentHandler(), ":" );
        var action = event.getCurrentAction();
        var module = event.getCurrentModule();

        var basePath = "";
        if ( len( module ) ) {
            basePath &= "modules_app/#module#/";
        }
        basePath &= "includes/";
        var cssBasePath = basePath & "css/";
        var jsBasePath = basePath & "js/";

        var pathsToCheck = [];

        // CSS Path Checks
        arrayAppend( pathsToCheck, correctedElixirPath( cssBasePath & "app.css", false, true ) );
        arrayAppend( pathsToCheck, correctedElixirPath( cssBasePath & "#handler#.css", false, true ) );
        arrayAppend( pathsToCheck, correctedElixirPath( cssBasePath & "#handler#-#action#.css", false, true ) );

        // JS Path Checks
        arrayAppend( pathsToCheck, correctedElixirPath( jsBasePath & "app.js", false, true ) );
        arrayAppend( pathsToCheck, correctedElixirPath( jsBasePath & "#handler#.js", false, true ) );
        arrayAppend( pathsToCheck, correctedElixirPath( jsBasePath & "#handler#-#action#.js", false, true ) );


        for ( var path in pathsToCheck ) {
            if ( fileExists( expandPath( path ) ) ) {
                addToAssetBag( prc, path );
            }
        }
        */
    }

}
