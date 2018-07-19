interface name="Asset" {

    public string function toString();
    public numeric function getPriority();
    public string function getType();
    public boolean function isSameAs( required any otherAsset );

}
