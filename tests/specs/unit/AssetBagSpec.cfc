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
        } );
    }

}
