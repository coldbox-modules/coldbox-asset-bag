component {

    property name="filepath";

    function init( filepath ) {
        variables.filepath = arguments.filepath;
        return this;
    }

    function toString() {
        return '<script type="text/javascript" src="#filepath#"></script>';
    }

}
