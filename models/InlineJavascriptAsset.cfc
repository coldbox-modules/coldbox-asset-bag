/**
 * Represents an inline javascript asset.
 */
component implements="Asset" accessors="true" {

    /**
    * The javascript content of the asset.
    */
    property name="content";

    /**
    * The priority of the inline javascript asset. Defaults to 0.
    */
    property name="priority" type="numeric" default="0";

    /**
    * Constructs a new inline javascript asset with the given content.
    *
    * @content The javascript content.
    *
    * @returns The newly created inline javascript asset.
    */
    public Asset function init( required string content ) {
        variables.content = arguments.content;
        return this;
    }

    /**
    * Renders the asset's contents to a string.
    *
    * @returns The rendered asset.
    */
    public string function toString() {
        return '<script type="text/javascript">#variables.content#</script>';
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
        return "javascript";
    }

    /**
    * Returns true if this asset is considered the same as the otherAsset.
    *
    * @otherAsset The other asset to test against this one for sameness.
    *
    * @returns    True, if this asset is considered the same as the otherAsset.
    */
    public boolean function isSameAs( required any otherAsset ) {
        return false;
    }

}
