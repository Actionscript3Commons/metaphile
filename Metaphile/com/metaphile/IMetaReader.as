package com.metaphile
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import com.metaphile.IMetaData;
	
	/**
	 * The IMetaStreamClient interface should be implemented by any class that
	 * intends to receive binary metadata from an IMetaStream.
	 */
	public interface IMetaReader
	{
		
		function get autoClose():Boolean;
		function set autoClose(value:Boolean):void;
		
		function get autoLimit():int;
		function set autoLimit(value:int):void
		
		function get onComplete():Function;
		function set onComplete(value:Function):void;
		
		function read( stream:IDataInput ):void;
		
		// old
		
		/**
		 * An array of file types that this object may be able to parse
		 */
		//function get fileTypes():Array;
		
		/**
		 * Size of the metadata header
		 */
		//function get headerSize():uint;
		
		/**
		 * Parses the metadata header and returns the size of the complete metadata in bytes
		 */
		//function parseHeader( bytes:IDataInput ):uint;
		
		/**
		 * Parses the complete metadata after the header and returns an IFileMetaData object
		 */
		//function parseBody( bytes:ByteArray ):IMetaData;
	}
}