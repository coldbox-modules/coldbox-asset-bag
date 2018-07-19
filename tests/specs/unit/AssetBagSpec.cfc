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

                assetBag.addCSSToHead( "/includes/js/app.js" );

                expect( assetBag.renderHead() ).toBe(
                    '<link type="text/css" href="/includes/js/app.js">'
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

            it( "does not add the same javascript file path twice", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToFooter( "/includes/js/app.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app.js" );

                expect( assetBag.renderHead() ).toBe( "" );
                expect( assetBag.renderFooter() ).toBe(
                    '<script type="text/javascript" src="/includes/js/app.js"></script>'
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

            it( "renders priority assets before non-priority assets", function() {
                var assetBag = new root.models.AssetBag();

                assetBag.addJavascriptToFooter( "/includes/js/app1.js" );
                assetBag.addJavascriptToFooter( "/includes/js/app2.js" ).setPriority( 1 );

                expect( assetBag.renderHead() ).toBe( "" );
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
