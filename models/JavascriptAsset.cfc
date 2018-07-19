component accessors="true" implements="Asset" {

    property name="filepath";
    property name="priority" type="numeric" default="0";

    function init( filepath ) {
        variables.filepath = arguments.filepath;
        return this;
    }

    public string function toString() {
        return '<script type="text/javascript" src="#filepath#"></script>';
    }

    public string function getType() {
        return "javascript";
    }

    public boolean function isSameAs( required any otherAsset ) {
        return isInstanceOf( otherAsset, "JavascriptAsset" ) &&
            ( getFilepath() == otherAsset.getFilepath() );
    }

}
