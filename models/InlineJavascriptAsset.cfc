component accessors="true" implements="Asset" {

    property name="content";
    property name="priority" type="numeric" default="0";

    function init( content ) {
        variables.content = arguments.content;
        return this;
    }

    public string function toString() {
        return '<script type="text/javascript">#content#</script>';
    }

    public boolean function isSameAs( required any otherAsset ) {
        return false;
    }

}
