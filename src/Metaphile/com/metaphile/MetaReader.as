package com.metaphile
{
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	//import com.metaphile.MetaEvent;
	import com.metaphile.IMetaData;
	import com.metaphile.IMetaReader;
	//import flash.filesystem.*;
	
	//[Event("complete", MetaStreamEvent.META_DATA_COMPLETE)]
	public class MetaReader extends EventDispatcher implements IMetaReader
	{
		
		private var _parser:IMetaReader;
		public function get parser():IMetaReader { return _parser; }
		public function set parser( value:IMetaReader ):void {
			_parser = value;
		}
		
		/*
		public var _fileTypes:Array = [];
		public function get fileTypes():Array { return _fileTypes; }
		*/
		
		private var _autoClose:Boolean;
		public function get autoClose():Boolean { return _autoClose; }
		public function set autoClose( value:Boolean ):void {
			_autoClose = value;
			parser.autoClose = _autoClose;
		}
		
		private var _autoLimit:int = -1;
		public function get autoLimit():int { return _autoLimit; }
		public function set autoLimit( value:int ):void {
			_autoLimit = value;
			parser.autoLimit = _autoLimit;
		}
		
		private var _onComplete:Function;
		public function get onComplete():Function { return _onComplete; }
		public function set onComplete(value:Function):void {
			_onComplete = value;
			parser.onComplete = _onComplete;
		}
		
		public function read(stream:IDataInput):void {
			parser.read(stream);
		}
		/*
		private function onComplete(meta:IMetaData):void {
			var mse:MetaEvent = new MetaEvent(MetaEvent.META_DATA_COMPLETE);
			mse.meta = meta;
			dispatchEvent(mse);
		}
		*/
		public function MetaReader( parser:IMetaReader, onComplete:Function ):void {
			_parser = parser;
			this.onComplete = onComplete;
		}
		
	}
}