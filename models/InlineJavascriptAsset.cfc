component accessors="true" {

    property name="content";

    function init( content ) {
        variables.content = arguments.content;
        return this;
    }

    function toString() {
        return '<script type="text/javascript">#content#</script>';
    }

    function isSameAs( otherAsset ) {
        return false;
    }

}
