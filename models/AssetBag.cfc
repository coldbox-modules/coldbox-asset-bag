component {

    property name="head";
    property name="footer";

    function init() {
        variables.head = [];
        variables.footer = [];
        return this;
    }

    function addJavascriptToHead( filepath ) {
        variables.head.append( new JavascriptAsset( filepath ) );
        return this;
    }

    function getHeadContent() {
        return variables.head;
    }

    function getFooterContent() {
        return variables.footer;
    }

    function renderHead() {
        return getHeadContent().map( function( asset ) {
            return asset.toString();
        } ).toList( chr( 10 ) );
    }

    function renderFooter() {
        return "";
    }

}
