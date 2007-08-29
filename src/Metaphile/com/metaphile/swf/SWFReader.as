package com.metaphile.swf
{
	import flash.utils.IDataInput;
	import com.metaphile.IMetaReader;
	import com.metaphile.swf.utilities.BitReader;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class SWFReader implements IMetaReader
	{
		public function get autoClose():Boolean
		{
			return false;
		}
		
		public function set autoClose(value:Boolean):void
		{
		}
		
		public function get autoLimit():int
		{
			return -1;
		}
		
		public function set autoLimit(value:int):void
		{
		}
		
		public function get onComplete():Function
		{
			return null;
		}
		
		public function set onComplete(value:Function):void
		{
		}
		
		public function read(stream:IDataInput):void
		{
			if( stream.bytesAvailable >= 100) {
				//track("#","##","#");
				stream.endian = Endian.LITTLE_ENDIAN;
				var id:String = stream.readUTFBytes(3);
				if (id=="FWS" || id=="CWS") {
					
					var version:int = stream.readByte(); // tag version
					var size:uint = stream.readUnsignedInt(); // tag size in bytes (uncompressed)
					
					if(id=="CWS") {
						stream = readBytes(stream);
						(stream as ByteArray).uncompress();
						(stream as ByteArray).position = 0;
					}
					
					var bitReader:BitReader = new BitReader();
					var nbits:uint = bitReader.readUnsignedInt(stream, 5);
					var xmin:uint = bitReader.readUnsignedInt(stream, nbits);
					var xmax:uint = bitReader.readUnsignedInt(stream, nbits)/20;
					var ymin:uint = bitReader.readUnsignedInt(stream, nbits);
					var ymax:uint = bitReader.readUnsignedInt(stream, nbits)/20;
					bitReader.flush();
					
					var fps_f:uint = stream.readUnsignedByte();
					var fps_i:uint = stream.readUnsignedByte();
					var fps:Number = fps_i + fps_f/256;
					var frames:uint = stream.readUnsignedShort();
				}
			}
		}
		
		private function readBytes(stream:IDataInput):ByteArray {
			var endian:String = stream.endian;
			stream.endian = Endian.BIG_ENDIAN;
			var bytes:ByteArray = new ByteArray();
			while (stream.bytesAvailable > 3) {
				bytes.writeUnsignedInt(stream.readUnsignedInt());
			}
			while(stream.bytesAvailable > 0) {
				bytes.writeByte(stream.readUnsignedByte());
			}
			bytes.endian = endian;
			return bytes;
		}
		
	}
}