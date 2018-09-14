/**
 * Represents an assset type
 */
interface displayname="Asset" {

    /**
     * Renders the asset's contents to a string.
     *
     * @returns The rendered asset.
     */
    public string function toString();

    /**
     * Returns the priority of the asset.
     *
     * @returns The asset's priority.
     */
    public numeric function getPriority();

    /**
     * Sets the priority of the asset.
     *
     * @priority The priority value to set.
     *
     * @returns  The asset instance.
     */
    public Asset function setPriority( required numeric priority );

    /**
     * Returns the type of the asset.
     *
     * @returns The asset type.
     */
    public string function getType();

    /**
     * Returns true if this asset is considered the same as the otherAsset.
     *
     * @otherAsset The other asset to test against this one for sameness.
     *
     * @returns    True, if this asset is considered the same as the otherAsset.
     */
    public boolean function isSameAs( required any otherAsset );

}
