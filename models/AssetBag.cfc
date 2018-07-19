component {

    property name="head";
    property name="footer";

    function init() {
        variables.head = [];
        variables.footer = [];
        return this;
    }

    function addAsset( asset, location ) {
        removeDuplicateAssets( asset );
        variables[ location ].append( asset );
        return asset;
    }

    function addAssetToHead( asset ) {
        return addAsset( asset, "head" );
    }

    function addJavascriptToHead( filepath ) {
        return addAssetToHead(
            new JavascriptAsset( filepath )
        );
    }

    function addCssToHead( filepath ) {
        return addAssetToHead(
            new CssAsset( filepath )
        );
    }

    function addInlineJavascriptToHead( content ) {
        return addAssetToHead(
            new InlineJavascriptAsset( content )
        );
    }

    function addAssetToFooter( asset ) {
        return addAsset( asset, "footer" );
    }

    function addJavascriptToFooter( filepath ) {
        return addAssetToFooter(
            new JavascriptAsset( filepath )
        );
    }

    function addInlineJavascriptToFooter( content ) {
        return addAssetToFooter(
            new InlineJavascriptAsset( content )
        );
    }

    function getHeadContent() {
        arraySort( variables.head, function( headA, headB ) {
            return compare( headB.getPriority(), headA.getPriority() );
        } );
        return variables.head;
    }

    function getFooterContent() {
        arraySort( variables.footer, function( footerA, footerB ) {
            return compare( footerB.getPriority(), footerA.getPriority() );
        } );
        return variables.footer;
    }

    function renderHead() {
        return getHeadContent().map( function( asset ) {
            return asset.toString();
        } ).toList( chr( 10 ) );
    }

    function renderFooter() {
        return getFooterContent().map( function( asset ) {
            return asset.toString();
        } ).toList( chr( 10 ) );
    }

    function removeDuplicateAssets( asset ) {
        variables.head = variables.head.filter( function( headAsset ) {
            return ! headAsset.isSameAs( asset );
        } );
        variables.footer = variables.footer.filter( function( footerAsset ) {
            return ! footerAsset.isSameAs( asset );
        } );
    }

}
