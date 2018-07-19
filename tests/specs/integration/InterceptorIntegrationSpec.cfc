component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Interceptor Integration", function() {
            it( "can run integration specs with the module activated", function() {
                expect( getController().getModuleService().isModuleRegistered( "coldbox-asset-bag" ) ).toBeTrue();
            } );

            it( "adds an asset bag to the prc in preProcess", function() {
                var event = execute( "Main.index" );
                expect( event.privateValueExists( "assetBag" ) ).toBeTrue( "An asset bag should exist in the prc scope" );
            } );
        } );
    }

}
