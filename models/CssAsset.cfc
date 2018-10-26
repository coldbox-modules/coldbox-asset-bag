/**
 * Represents a css asset.
 */
component implements="Asset" accessors="true" {

    /**
     * The filepath to the css asset.
     */
    property name="filepath";

    /**
     * The priority of the css asset. Defaults to 0.
     */
    property name="priority" type="numeric" default="0";

    /**
     * Constructs a new css asset pointing to the given filepath.
     *
     * @filepath The filepath to the css asset.
     *
     * @returns  The newly created css asset.
     */
    public Asset function init( required string filepath ) {
        variables.filepath = arguments.filepath;
        return this;
    }

    /**
     * Renders the asset's contents to a string.
     *
     * @returns The rendered asset.
     */
    public string function toString() {
        return '<link type="text/css" rel="stylesheet" href="#variables.filepath#">';
    }

    /**
    * Returns the priority of the asset.
    *
    * @returns The asset's priority.
    */
    public numeric function getPriority() {
        return variables.priority;
    }

    /**
    * Sets the priority of the asset.
    *
    * @priority The priority value to set.
    *
    * @returns  The asset instance.
    */
    public Asset function setPriority( required numeric priority ) {
        variables.priority = arguments.priority;
        return this;
    }

    /**
    * Returns the type of the asset.
    *
    * @returns The asset type.
    */
    public string function getType() {
        return "css";
    }

    /**
    * Returns true if this asset is considered the same as the otherAsset.
    *
    * @otherAsset The other asset to test against this one for sameness.
    *
    * @returns    True, if this asset is considered the same as the otherAsset.
    */
    public boolean function isSameAs( required any otherAsset ) {
        return isInstanceOf( otherAsset, "CssAsset" ) &&
            ( variables.filepath == otherAsset.getFilepath() );
    }

}
