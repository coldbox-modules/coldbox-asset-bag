component accessors="true" {

    property name="content";

    function init( content, inline = false ) {
        variables.content = arguments.content;
        variables.inline = arguments.inline;
        return this;
    }

    function toString() {
        return variables.inline ? renderInline() : renderSrc();
    }

    function renderInline() {
        return '<script type="text/javascript">#content#</script>';
    }

    function renderSrc() {
        return '<script type="text/javascript" src="#content#"></script>';
    }

    function isSameAs( otherAsset ) {
        return isInstanceOf( otherAsset, "JavascriptAsset" ) &&
            ( getContent() == otherAsset.getContent() );
    }

}
