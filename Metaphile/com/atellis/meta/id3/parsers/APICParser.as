package com.atellis.meta.id3.parsers
{
	import com.atellis.meta.id3.frames.*;
	import com.atellis.meta.id3.*;
	import com.atellis.meta.id3.utilities.*;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import com.metaphile.logging.*;
	
	public class APICParser extends FrameParser
	{
		
		public function APICParser( successor:FrameParser  ) {
			super(successor);
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number = 2.3):Frame {
			if(id=="APIC" || id=="PIC") {
				return readAPICFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readAPICFrame( bytes:ByteArray, version:Number ):Frame {
			var frame:APICFrame = new APICFrame();
			var size:int = bytes.readUnsignedInt();
			ParseLog.parsed(this, "size: {0} (+10)", size, bytes.position);
			var data:ByteArray = new ByteArray();
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.info(this, "uncompressed size: {0} (+10)", size);
			}
			var start:uint = bytes.position;
			frame.encoding = bytes.readUnsignedByte();
			ParseLog.parsed(this, "encoding: {0}", frame.encoding, bytes.position);
			frame.mime = ID3.readString(bytes, frame.encoding);
			ParseLog.parsed(this, "mime: {0}", frame.mime, bytes.position);
			frame.format = bytes.readUnsignedByte();
			ParseLog.parsed(this, "type: {0}", frame.format, bytes.position);
			frame.description = ID3.readString(bytes, frame.encoding);
			ParseLog.parsed(this, "description: {0}", frame.description, bytes.position);
			var imageSize:uint = size-(bytes.position-start);
			ParseLog.debug(this, "( image size = {0} )", imageSize);
			if(imageSize > 0) { bytes.readBytes(data,0,imageSize); }
			ParseLog.parsed(this, "read image", "", bytes.position);
			frame.image = data;
			return frame;
		}
		
	}
}