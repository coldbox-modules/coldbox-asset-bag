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
        } );
    }

}
