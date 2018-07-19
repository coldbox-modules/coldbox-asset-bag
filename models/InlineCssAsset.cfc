component accessors="true" implements="Asset" {

    property name="content";
    property name="priority" type="numeric" default="0";

    function init( content ) {
        variables.content = arguments.content;
        return this;
    }

    public string function toString() {
        return '<style>#content#</style>';
    }

    public string function getType() {
        return "css";
    }

    public boolean function isSameAs( required any otherAsset ) {
        return false;
    }

}
