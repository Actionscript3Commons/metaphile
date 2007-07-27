package com.metaphile
{
	//import flash.display.DisplayObject;
	//import mx.collections.ArrayCollection;
	import flash.utils.ByteArray;
	
	/**
	 * The IMetaData interface represents metadata information that should be available for most file types.
	 * If a metadata property is not available, it should be represented as null.
	 */
	public interface IMetaData
	{
		function get title():String;
		function get subtitle():String;
		function get author():String;
		function get image():ByteArray;
		function get url():String;
		//function get items():ArrayCollection;
	}
}