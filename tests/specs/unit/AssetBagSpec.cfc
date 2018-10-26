component extends="testbox.system.BaseSpec" {

    function run() {
        describe( "Asset Bag", function() {
            it( "starts with no content", function() {
                var assetBag = new root.models.AssetBag();

                expect( assetBag.getHeadContent() ).toBeEmpty();
                expect( assetBag.getFooterContent() ).toBeEmpty();
                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe( "" );
            } );

            it( "can add javascript files to the head", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToHead( "/includes/js/app.js" );

                expect( assetBag.renderHead() ).toBe(
                    '<script type="text/javascript" src="/includes/js/app.js"></script>'
                );
                expect( assetBag.renderFooter() ).toBe( "" );
            } );

            it( "can add css files to the head", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addCssToHead( "/includes/css/app.css" );

                expect( assetBag.renderHead() ).toBe(
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app.css">'
                );
                expect( assetBag.renderFooter() ).toBe( "" );
            } );

            it( "can add javascript files to the footer", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToFooter( "/includes/js/app.js" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe(
                    '<script type="text/javascript" src="/includes/js/app.js"></script>'
                );
            } );

            it( "can add css files to the footer", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addCssToFooter( "/includes/css/app.css" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe(
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app.css">'
                );
            } );

            it( "can add multiple javascript files", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToHead( "/includes/js/app1.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app3.js" );

                expect( assetBag.renderHead() ).toBe( arrayToList( [
                    '<script type="text/javascript" src="/includes/js/app1.js"></script>'
                ], chr( 10 ) ) );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<script type="text/javascript" src="/includes/js/app2.js"></script>',
                    '<script type="text/javascript" src="/includes/js/app3.js"></script>'
                ], chr( 10 ) ) );
            } );

            it( "can add multiple css files", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addCssToHead( "/includes/css/app1.css" );
                assetBag.addCssToFooter( "/includes/css/app2.css" );
                assetBag.addCssToFooter( "/includes/css/app3.css" );

                expect( assetBag.renderHead() ).toBe( arrayToList( [
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app1.css">'
                ], chr( 10 ) ) );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app2.css">',
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app3.css">'
                ], chr( 10 ) ) );
            } );

            it( "renders css files before js files", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToHead( "/includes/js/app1.js" );
                assetBag.addCssToHead( "/includes/css/app1.css" );

                assetBag.addJavascriptToFooter( "/includes/js/app2.js" );
                assetBag.addCssToFooter( "/includes/css/app2.css" );

                expect( assetBag.renderHead() ).toBe( arrayToList( [
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app1.css">',
                    '<script type="text/javascript" src="/includes/js/app1.js"></script>'
                ], chr( 10 ) ) );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app2.css">',
                    '<script type="text/javascript" src="/includes/js/app2.js"></script>'
                ], chr( 10 ) ) );
            } );

            it( "can add inline javascript as well as files", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addInlineJavascriptToHead( "console.log('Hi from header!');" );
                assetBag.addInlineJavascriptToFooter( "console.log('Hi from footer!');" );

                expect( assetBag.renderHead() ).toBe(
                    '<script type="text/javascript">console.log(''Hi from header!'');</script>'
                );
                expect( assetBag.renderFooter() ).toBe(
                    '<script type="text/javascript">console.log(''Hi from footer!'');</script>'
                );
            } );

            it( "can add inline css as well as files", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addInlineCssToHead( "body { background-color: ##ff0000; }" );
                assetBag.addInlineCssToFooter( "* { outline: none; }" );

                expect( assetBag.renderHead() ).toBe(
                    '<style>body { background-color: ##ff0000; }</style>'
                );
                expect( assetBag.renderFooter() ).toBe(
                    '<style>* { outline: none; }</style>'
                );
            } );

            it( "does not add the same javascript file path twice", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToFooter( "/includes/js/app.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app.js" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe(
                    '<script type="text/javascript" src="/includes/js/app.js"></script>'
                );
            } );

            it( "does not add the same css file path twice", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addCssToFooter( "/includes/css/app.css" );
                assetBag.addCssToFooter( "/includes/css/app.css" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe(
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app.css">'
                );
            } );

            it( "always adds inline javascript even when the content is identical", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addInlineJavascriptToFooter( "console.log('Hi!');" );
                assetBag.addInlineJavascriptToFooter( "console.log('Hi!');" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<script type="text/javascript">console.log(''Hi!'');</script>',
                    '<script type="text/javascript">console.log(''Hi!'');</script>'
                ], chr( 10 ) ) );
            } );

            it( "always adds inline css even when the content is identical", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addInlineCssToFooter( "* { outline: none; }" );
                assetBag.addInlineCssToFooter( "* { outline: none; }" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<style>* { outline: none; }</style>',
                    '<style>* { outline: none; }</style>'
                ], chr( 10 ) ) );
            } );

            it( "renders priority assets before non-priority assets", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addCssToHead( "/includes/css/app1.css" );
                assetBag.addCssToHead( "/includes/css/app2.css" ).setPriority( 1 );

                assetBag.addJavascriptToFooter( "/includes/js/app1.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" ).setPriority( 1 );

                expect( assetBag.renderHead() ).toBe( arrayToList( [
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app2.css">',
                    '<link type="text/css" rel="stylesheet" href="/includes/css/app1.css">'
                ], chr( 10 ) ) );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<script type="text/javascript" src="/includes/js/app2.js"></script>',
                    '<script type="text/javascript" src="/includes/js/app1.js"></script>'
                ], chr( 10 ) ) );
            } );

            it( "renders priority assets in descending order", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToFooter( "/includes/js/app1.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" ).setPriority( 10 );
                assetBag.addJavascriptToFooter( "/includes/js/app3.js" ).setPriority( 1 );
                assetBag.addJavascriptToFooter( "/includes/js/app4.js" ).setPriority( 100 );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<script type="text/javascript" src="/includes/js/app4.js"></script>',
                    '<script type="text/javascript" src="/includes/js/app2.js"></script>',
                    '<script type="text/javascript" src="/includes/js/app3.js"></script>',
                    '<script type="text/javascript" src="/includes/js/app1.js"></script>'
                ], chr( 10 ) ) );
            } );

            it( "overwrites duplicate assets keeping the last priority", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToFooter( "/includes/js/app1.js" ).setPriority( 20 );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" ).setPriority( 10 );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" ).setPriority( 30 );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<script type="text/javascript" src="/includes/js/app2.js"></script>',
                    '<script type="text/javascript" src="/includes/js/app1.js"></script>'
                ], chr( 10 ) ) );
            } );

            it( "can add a mixture of filepath and inline javascript assets", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addInlineJavascriptToHead( "console.log('Hello, from head');" );
                assetBag.addJavascriptToHead( "/includes/js/app1.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" );
                assetBag.addInlineJavascriptToFooter( "console.log('Hello, from footer');" );
                assetBag.addJavascriptToFooter( "/includes/js/app3.js" );

                expect( assetBag.renderHead() ).toBe( arrayToList( [
                    '<script type="text/javascript">console.log(''Hello, from head'');</script>',
                    '<script type="text/javascript" src="/includes/js/app1.js"></script>'
                    ], chr( 10 ) ) );
                expect( assetBag.renderFooter() ).toBe( arrayToList( [
                    '<script type="text/javascript" src="/includes/js/app2.js"></script>',
                    '<script type="text/javascript">console.log(''Hello, from footer'');</script>',
                    '<script type="text/javascript" src="/includes/js/app3.js"></script>'
                ], chr( 10 ) ) );
            } );
        } );
    }

}
