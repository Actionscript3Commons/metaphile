package com.atellis.meta.id3.parsers
{
	import com.atellis.meta.id3.frames.*;
	import com.atellis.meta.id3.utilities.*;
	import com.atellis.meta.id3.*;
	import flash.utils.ByteArray;
	import com.metaphile.logging.ParseLog;
	
	public class POPMParser extends FrameParser
	{
		
		public function POPMParser( successor:FrameParser = null ) {
			super( successor );
		}
		
		override public function readFrame(id:String, bytes:ByteArray, version:Number = 2.3):Frame {
			if(id=="POPM" || id=="POP") {
				return readPOPMFrame(bytes, version);
			} else { return successor.readFrame(id, bytes, version); }
		}
		
		private function readPOPMFrame(bytes:ByteArray, version:Number):Frame {
			var frame:POPMFrame = new POPMFrame();
			var size:uint = bytes.readUnsignedInt();
			ParseLog.debug(this, "size: {0} (+10)", size, bytes.position);
			readFlags( frame, bytes, version );
			if(frame.compression){
				size = uncompressFrame(size, bytes);
				ParseLog.parsed(this, "uncompressed size: {0} (+10)", size, bytes.position);
			}
			frame.user = ID3.readString(bytes);
			ParseLog.parsed(this, "user: {0}", frame.user, bytes.position);
			frame.rating = bytes.readUnsignedByte();
			ParseLog.parsed(this, "rating: {0}", frame.rating, bytes.position);
			frame.counter = bytes.readUnsignedInt();
			ParseLog.parsed(this, "counter: {0}", frame.counter, bytes.position);
			return frame;
		}
	}
}