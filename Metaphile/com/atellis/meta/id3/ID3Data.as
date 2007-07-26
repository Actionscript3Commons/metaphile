package com.atellis.meta.id3
{
	import com.atellis.meta.id3.frames.APICFrame;
	import com.metaphile.IMetaData;
	import flash.utils.ByteArray;
	import com.atellis.meta.id3.frames.Frame;
	import mx.collections.ArrayCollection;
	import com.atellis.meta.id3.frames.TFrame;
	import com.atellis.meta.id3.frames.FrameTypes;
	import flash.events.EventDispatcher;
	
	public class ID3Data extends EventDispatcher implements IMetaData
	{
		
		private var frames:ArrayCollection = new ArrayCollection();
		
		public function ID3Data() {
			privateFrames = new Array();
		}
		
		/**
		 * ID3 version number.
		 */
		private var _version:Number; [Bindable]
		public function get version():Number { return _version; }
		public function set version( value:Number ):void {
			_version = value;
		}
		
		public var unsynchronisation:Boolean;
		public var extended:Boolean;
		public var experimental:Boolean;
		
		private var _size:int;
		public function get size():int { return _size; }
		public function set size(value:int):void {
			_size = value;
		}
		
		// IFileMetaData
		public function get title():String {
			if(songTitle) { return String(songTitle); }
			return null;
		}
		
		public function get subtitle():String {
			if(songDescription) { return String(songDescription); }
			if(albumTitle) { return String(albumTitle); }
			if(groupDescription) { return String(groupDescription); }
			return null;
		}
		
		public function get url():String { return ""; }
		public function get author():String { return ""; }
		public function get image():ByteArray {
			if(albumArt) { return albumArt.image; }
			return null;
		}
		
		public function get imageDescription():String {
			if(albumArt) { return albumArt.description; }
			return null;
		}
		
		//////////////////////////////////////////////////////////
		
		private var _albumArt:APICFrame; [Bindable]
		public function get albumArt():APICFrame { return _albumArt; }
		public function set albumArt( value:APICFrame ):void {
			_albumArt = value;
		}
		
		/**
		 * The 'Album/Movie/Show title' frame is intended for the title of the recording(/source of sound) which the audio in the file is taken from.
		 */
		private var _albumTitle:TFrame; [Bindable]
		public function get albumTitle():TFrame { return _albumTitle; }
		public function set albumTitle( value:TFrame ):void {
			_albumTitle = value;
		}
		
		private var _bpm:uint;
		
		private var _composers:TFrame; [Bindable]
		public function get composers():TFrame { return _composers; }
		public function set composers( value:TFrame ):void {
			_composers = value;
		}
		
		
		private var _contentType:TFrame; [Bindable]
		public function get contentType():TFrame { return _contentType; }
		public function set contentType( value:TFrame ):void {
			_contentType = value;
		}
		
		private var _copyright:String;
		private var _date:Date;
		private var _playlistDelay:Number;
		private var _encodedBy:String;
		private var _lyricists:Array;
		private var _fileType:String;
		private var _time:Date;
		
		/**
		 * The 'Content group description' frame is used if the sound belongs to a larger category of sounds/music. For example, classical music is often sorted in different musical sections (e.g. "Piano Concerto", "Weather - Hurricane").
		 */
		private var _groupDescription:TFrame; [Bindable]
		public function get groupDescription():TFrame { return _groupDescription; }
		public function set groupDescription( value:TFrame ):void {
			_groupDescription = value;
		}
		
		/**
		 * The 'Title/Songname/Content description' frame is the actual name of the piece (e.g. "Adagio", "Hurricane Donna").
		 */
		private var _songTitle:TFrame; [Bindable]
		public function get songTitle():TFrame { return _songTitle; }
		public function set songTitle( value:TFrame ):void {
			_songTitle = value;
		}
		
		/**
		 * The 'Subtitle/Description refinement' frame is used for information directly related to the contents title (e.g. "Op. 16" or "Performed live at Wembley").
		 */
		private var _songDescription:TFrame; [Bindable]
		public function get songDescription():TFrame { return _songDescription; }
		public function set songDescription( value:TFrame ):void {
			_songDescription = value;
		}
		
		private var _key:String;
		private var _languages:Array;
		private var _length:Number;
		private var _mediaType:Array;
		private var _originalAlbum:String;
		private var _originalFilename:String;
		private var _originalLyricists:Array;
		private var _originalPerformers:Array;
		private var _originalReleaseYear:int;
		private var _fileOwner:String;
		private var _performers:Array;
		
		private var _band:TFrame; [Bindable]
		public function get band():TFrame { return _band; }
		public function set band( value:TFrame ):void {
			_band = value;
		}
		
		
		private var _conductor:String;
		private var _modifiedBy:String;
		private var _partOfSet:String;
		
		private var _publisher:TFrame; [Bindable]
		public function get publisher():TFrame { return _publisher; }
		public function set publisher( value:TFrame ):void {
			_publisher = value;
		}
		
		/**
		 * The 'Track number/Position in set' frame is a numeric string containing the order number of the audio-file on its original recording. This may be extended with a "/" character and a numeric string containing the total numer of tracks/elements on the original recording. E.g. "4/9".
		 */
		private var _track:TFrame; [Bindable]
		public function get track():TFrame { return _track; }
		public function set track( value:TFrame ):void {
			_track = value;
		}
		
		private var _recordingDates:String;
		private var _internetRadioStationName:String;
		private var _internetRadioStationOwner:String;
		//private var _size:int;
		private var _isrc:String;
		private var _encodingSoftware:String;
		
		/**
		 * The 'Year' frame is a numeric string with a year of the recording. This frames is always four characters long (until the year 10000).
		 */
		private var _year:TFrame; [Bindable]
		public function get year():TFrame { return _year; }
		public function set year( value:TFrame ):void {
			_year = value;
		}
		
		private var _userDefined:Array;
		
		private var _commercialURI:Array;
		private var _copyrightURI:String;
		private var _officialAudioFileWebpage:String;
		private var _officialArtistWebpages:Array;
		private var _officialAudioSourceWebpage:String;
		private var _officialInternetRadioStationWebpage:String;
		private var _officialPaymentWebpage:String;
		private var _officialPublishersWebpage:String;
		private var _userDefinedURI:Array;
		
		private var _privateFrames:Array;
		public function get privateFrames():Array { return _privateFrames; }
		public function set privateFrames( value:Array ):void {
			_privateFrames = value;
		}
		
		public function addFrame( frame:Frame ):void {
			switch(frame.type) {
				case FrameTypes.ALBUM_TITLE:
					albumTitle = TFrame(frame);
					break;
				case FrameTypes.CONTENT_GROUP_DESCRIPTION:
					groupDescription = TFrame(frame);
				case FrameTypes.TITLE:
					songTitle = TFrame(frame);
					break;
				case FrameTypes.SUBTITLE:
					songDescription = TFrame(frame);
					break;
				case FrameTypes.ATTACHED_PICTURE:
					albumArt = APICFrame(frame);
					break;
				case FrameTypes.TRACK_NUMBER:
					track = TFrame(frame);
					break;
				case FrameTypes.YEAR:
					year = TFrame(frame);
					break;
				case FrameTypes.PUBLISHER:
					publisher = TFrame(frame);
					break;
				case FrameTypes.PRIVATE_FRAME:
					privateFrames.push(frame);
					break;
				case FrameTypes.BAND:
					band = TFrame(frame);
					break;
				case FrameTypes.COMPOSER:
					composers = TFrame(frame);
					break;
				case FrameTypes.CONTENT_TYPE:
					contentType = TFrame(frame);
					break;
			}
		}
		
	}
}