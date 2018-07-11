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
        } );
    }

}
