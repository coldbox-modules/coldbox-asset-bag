interface name="Asset" {

    public string function toString();
    public numeric function getPriority();
    public boolean function isSameAs( required any otherAsset );

}
