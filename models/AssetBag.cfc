/**
 * An object to collect css and javascript dependencies to render all at once.
 */
component {

    /**
     * Initialize the head and footer collections.
     *
     * @returns The newly initialized asset bag.
     */
    public AssetBag function init() {
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

    /**
     * Add an asset to the asset bag.
     * It is more common to use the more specific `add` methods.
     * This method automatically removes duplicate assets.
     * Duplicate assets are determined by type and path. Inline assets can't be deduped.
     *
     * @asset    The asset component to add. Although it does not need to implement the Asset interface, it must follow it in practice.
     * @location Two values are accepted, `head` or `footer`.
     *
     * @returns  The newly added asset.
     */
    public any function addAsset( required asset, required string location ) {
        removeDuplicateAssets( asset );
        variables[ location ][ asset.getType() ].append( asset );
        return asset;
    }

    /**
    * Add an asset to the head of the asset bag.
    * It is more common to use the more specific `add` methods for css or javascript.
    *
    * @asset    The asset component to add.
    *
    * @returns  The newly added asset.
    */
    public any function addAssetToHead( required asset ) {
        return addAsset( asset, "head" );
    }

    /**
    * Add a javascript asset to the head of the asset bag.
    *
    * @filepath The path to the javascript file.
    *
    * @returns  The newly added asset.
    */
    public any function addJavascriptToHead( required string filepath ) {
        return addAssetToHead(
            new JavascriptAsset( filepath )
        );
    }

    /**
    * Add a css asset to the head of the asset bag.
    *
    * @filepath The path to the css file.
    *
    * @returns  The newly added asset.
    */
    public any function addCssToHead( required string filepath ) {
        return addAssetToHead(
            new CssAsset( filepath )
        );
    }

    /**
    * Add inline javascript to the head of the asset bag.
    *
    * @content The javascript content.
    *
    * @returns The newly added asset.
    */
    public any function addInlineJavascriptToHead( required string content ) {
        return addAssetToHead(
            new InlineJavascriptAsset( content )
        );
    }

    /**
    * Add inline css to the head of the asset bag.
    *
    * @content The css content.
    *
    * @returns The newly added asset.
    */
    public any function addInlineCssToHead( required string content ) {
        return addAssetToHead(
            new InlineCssAsset( content )
        );
    }

    /**
    * Add an asset to the footer of the asset bag.
    * It is more common to use the more specific `add` methods for css or javascript.
    *
    * @asset    The asset component to add.
    *
    * @returns  The newly added asset.
    */
    public any function addAssetToFooter( required asset ) {
        return addAsset( asset, "footer" );
    }

    /**
    * Add a javascript asset to the footer of the asset bag.
    *
    * @filepath The path to the javascript file.
    *
    * @returns  The newly added asset.
    */
    public any function addJavascriptToFooter( required string filepath ) {
        return addAssetToFooter(
            new JavascriptAsset( filepath )
        );
    }

    /**
    * Add a css asset to the footer of the asset bag.
    *
    * @filepath The path to the css file.
    *
    * @returns  The newly added asset.
    */
    public any function addCssToFooter( required string filepath ) {
        return addAssetToFooter(
            new CssAsset( filepath )
        );
    }

    /**
    * Add inline javascript to the footer of the asset bag.
    *
    * @content The javascript content.
    *
    * @returns The newly added asset.
    */
    public any function addInlineJavascriptToFooter( required string content ) {
        return addAssetToFooter(
            new InlineJavascriptAsset( content )
        );
    }

    /**
    * Add inline css to the footer of the asset bag.
    *
    * @content The css content.
    *
    * @returns The newly added asset.
    */
    public any function addInlineCssToFooter( required string content ) {
        return addAssetToFooter(
            new InlineCssAsset( content )
        );
    }

    /**
     * Get the current array of assets in the head of the asset bag.
     * The assets are sorted first by type (css then javascript), then by priority.
     *
     * @returns A sorted array of assets in the asset bag's head.
     */
    public array function getHeadContent() {
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

    /**
    * Get the current array of assets in the footer of the asset bag.
    * The assets are sorted first by type (css then javascript), then by priority.
    *
    * @returns A sorted array of assets in the asset bag's footer.
    */
    public array function getFooterContent() {
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

    /**
     * Renders the contents of the asset bag's head to a string.
     *
     * @returns The rendered contents of the asset bag's head.
     */
    public string function renderHead() {
        return getHeadContent().map( function( asset ) {
            return asset.toString();
        } ).toList( chr( 10 ) );
    }

    /**
    * Renders the contents of the asset bag's footer to a string.
    *
    * @returns The rendered contents of the asset bag's footer.
    */
    public string function renderFooter() {
        return getFooterContent().map( function( asset ) {
            return asset.toString();
        } ).toList( chr( 10 ) );
    }

    /**
     * Removes any assets from the asset bag that is the same as the incoming asset.
     *
     * @asset The incoming asset to match against.
     */
    private void function removeDuplicateAssets( asset ) {
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
