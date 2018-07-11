component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Interceptor Integration", function() {
            it( "can run integration specs with the module activated", function() {
                expect( getController().getModuleService().isModuleRegistered( "coldbox-asset-bag" ) ).toBeTrue();
            } );
        } );
    }

}
