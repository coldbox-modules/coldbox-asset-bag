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

    public numeric function getPriority() {
        return variables.priority;
    }

    public string function getType() {
        return "javascript";
    }

    public boolean function isSameAs( required any otherAsset ) {
        return false;
    }

}
