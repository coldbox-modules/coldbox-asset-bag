component accessors="true" implements="Asset" {

    property name="filepath";
    property name="priority" type="numeric" default="0";

    function init( filepath ) {
        variables.filepath = arguments.filepath;
        return this;
    }

    public string function toString() {
        return '<link type="text/css" href="#filepath#">';
    }

    public string function getType() {
        return "css";
    }

    public boolean function isSameAs( required any otherAsset ) {
        return isInstanceOf( otherAsset, "CssAsset" ) &&
            ( getFilepath() == otherAsset.getFilepath() );
    }

}
