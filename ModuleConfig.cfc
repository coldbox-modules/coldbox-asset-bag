component {

    this.name = "coldbox-asset-bag";
    this.author = "";
    this.webUrl = "https://github.com/elpete/coldbox-asset-bag";

    function configure() {}

    function preProcess( event, interceptData, buffer, rc, prc ) {
        prc.assetBag = wirebox.getInstance( "AssetBag@coldbox-asset-bag" );
    }

}
