component {

    function init() {
        variables.head = {
            css = [],
            javascript = []
        };
        variables.footer = {
            css = [],
            javascript = []
        };
        return this;
    }

    function addAsset( asset, location ) {
        removeDuplicateAssets( asset );
        variables[ location ][ asset.getType() ].append( asset );
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

    function addInlineCssToHead( content ) {
        return addAssetToHead(
            new InlineCssAsset( content )
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

    function addCssToFooter( filepath ) {
        return addAssetToFooter(
            new CssAsset( filepath )
        );
    }

    function addInlineJavascriptToFooter( content ) {
        return addAssetToFooter(
            new InlineJavascriptAsset( content )
        );
    }

    function addInlineCssToFooter( content ) {
        return addAssetToFooter(
            new InlineCssAsset( content )
        );
    }

    function getHeadContent() {
        arraySort( variables.head.css, function( headA, headB ) {
            return compare( headB.getPriority(), headA.getPriority() );
        } );
        arraySort( variables.head.javascript, function( headA, headB ) {
            return compare( headB.getPriority(), headA.getPriority() );
        } );
        var totalHeadContent = [];
        totalHeadContent.append( variables.head.css, true );
        totalHeadContent.append( variables.head.javascript, true );
        return totalHeadContent;
    }

    function getFooterContent() {
        arraySort( variables.footer.css, function( footerA, footerB ) {
            return compare( footerB.getPriority(), footerA.getPriority() );
        } );
        arraySort( variables.footer.javascript, function( footerA, footerB ) {
            return compare( footerB.getPriority(), footerA.getPriority() );
        } );
        var totalFooterContent = [];
        totalFooterContent.append( variables.footer.css, true );
        totalFooterContent.append( variables.footer.javascript, true );
        return totalFooterContent;
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
        variables.head.css = variables.head.css
            .filter( function( headAsset ) {
                return ! headAsset.isSameAs( asset );
            } );
        variables.head.javascript = variables.head.javascript
            .filter( function( headAsset ) {
                return ! headAsset.isSameAs( asset );
            } );
        variables.footer.css = variables.footer.css
            .filter( function( footerAsset ) {
                return ! footerAsset.isSameAs( asset );
            } );
        variables.footer.javascript = variables.footer.javascript
            .filter( function( footerAsset ) {
                return ! footerAsset.isSameAs( asset );
            } );
    }

}
