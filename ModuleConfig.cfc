component {

    this.name = "coldbox-asset-bag";
    this.author = "";
    this.webUrl = "https://github.com/elpete/coldbox-asset-bag";
    this.autoMapModels = false;

    /**
     * Configure the coldbox-asset-bag module
     */
    function configure() {
        binder.map( "AssetBag@coldbox-asset-bag" )
            .to( "#moduleMapping#.models.AssetBag" );
    }

    /**
     * Ensure an asset bag is available on every request.
     *
     * @event         The ColdBox Request Context.
     * @interceptData Any data associated with this interception call.
     * @buffer        StringBuilder object who's contents are appended after the interception point.
     * @rc            The request collection.
     * @prc           The private request collection.
     */
    function preProcess( event, interceptData, buffer, rc, prc ) {
        prc.assetBag = wirebox.getInstance( "AssetBag@coldbox-asset-bag" );
    }

}
