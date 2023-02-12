package funkin.options;

import flixel.FlxG;
import funkin.system.Controls;
import openfl.Lib;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;

@:build(funkin.macros.OptionsMacro.build())
class Options
{
	@:dox(hide) public static var __save:FlxSave;
	@:dox(hide) private static var __eventAdded = false;
	
	/**
	 * SETTINGS
	 */
	public static var naughtyness:Bool = true;
	public static var downscroll:Bool = false;
	public static var ghostTapping:Bool = false;
	public static var flashingMenu:Bool = true;
	public static var camZoomOnBeat:Bool = true;
	public static var fpsCounter:Bool = true;
	public static var autoPause:Bool = true;
	public static var antialiasing:Bool = true;
	public static var volume:Float = 1;
	public static var week6PixelPerfect:Bool = true;
	public static var betaUpdates:Bool = false;
	public static var hitWindow:Float = 250;

	public static var lastLoadedMod:String = null;

	/**
	 * PLAYER 1 CONTROLS
	 */
	public static var P1_NOTE_LEFT:Array<FlxKey> = [A];
	public static var P1_NOTE_DOWN:Array<FlxKey> = [S];
	public static var P1_NOTE_UP:Array<FlxKey> = [W];
	public static var P1_NOTE_RIGHT:Array<FlxKey> = [D];
	public static var P1_LEFT:Array<FlxKey> = [A];
	public static var P1_DOWN:Array<FlxKey> = [S];
	public static var P1_UP:Array<FlxKey> = [W];
	public static var P1_RIGHT:Array<FlxKey> = [D];
	public static var P1_ACCEPT:Array<FlxKey> = [ENTER];
	public static var P1_BACK:Array<FlxKey> = [BACKSPACE];
	public static var P1_PAUSE:Array<FlxKey> = [ENTER];
	public static var P1_RESET:Array<FlxKey> = [R];
	public static var P1_SWITCHMOD:Array<FlxKey> = [TAB];

	/**
	 * PLAYER 2 CONTROLS (ALT)
	 */
	public static var P2_NOTE_LEFT:Array<FlxKey> = [LEFT];
	public static var P2_NOTE_DOWN:Array<FlxKey> = [DOWN];
	public static var P2_NOTE_UP:Array<FlxKey> = [UP];
	public static var P2_NOTE_RIGHT:Array<FlxKey> = [RIGHT];
	public static var P2_LEFT:Array<FlxKey> = [LEFT];
	public static var P2_DOWN:Array<FlxKey> = [DOWN];
	public static var P2_UP:Array<FlxKey> = [UP];
	public static var P2_RIGHT:Array<FlxKey> = [RIGHT];
	public static var P2_ACCEPT:Array<FlxKey> = [SPACE];
	public static var P2_BACK:Array<FlxKey> = [ESCAPE];
	public static var P2_PAUSE:Array<FlxKey> = [ESCAPE];
	public static var P2_RESET:Array<FlxKey> = [];
	public static var P2_SWITCHMOD:Array<FlxKey> = [];

	/**
	 * SOLO GETTERS
	 */
	public static var SOLO_NOTE_LEFT(get, null):Array<FlxKey>;
	public static var SOLO_NOTE_DOWN(get, null):Array<FlxKey>;
	public static var SOLO_NOTE_UP(get, null):Array<FlxKey>;
	public static var SOLO_NOTE_RIGHT(get, null):Array<FlxKey>;
	public static var SOLO_LEFT(get, null):Array<FlxKey>;
	public static var SOLO_DOWN(get, null):Array<FlxKey>;
	public static var SOLO_UP(get, null):Array<FlxKey>;
	public static var SOLO_RIGHT(get, null):Array<FlxKey>;
	public static var SOLO_ACCEPT(get, null):Array<FlxKey>;
	public static var SOLO_BACK(get, null):Array<FlxKey>;
	public static var SOLO_PAUSE(get, null):Array<FlxKey>;
	public static var SOLO_RESET(get, null):Array<FlxKey>;
	public static var SOLO_SWITCHMOD(get, null):Array<FlxKey>;

	public static function load() {
		if (__save == null) __save = new FlxSave();
		__save.bind("options");
		for(field in Reflect.fields(__save.data)) {
			var obj = Reflect.field(__save.data, field);
			Reflect.setProperty(Options, field, obj);
		}

		if (!__eventAdded) {
			Lib.application.onExit.add(function(i:Int) {
				trace("Saving settings...");
				save();
			});
			__eventAdded = true;
		}
		FlxG.sound.volume = volume;
		applySettings();
	}

	public static function applySettings() {
		applyKeybinds();
		FlxG.game.stage.quality = (FlxG.forceNoAntialiasing = !antialiasing) ? LOW : BEST;
		FlxG.autoPause = autoPause;
	}

	public static function applyKeybinds() {
		PlayerSettings.solo.setKeyboardScheme(Solo);
		PlayerSettings.player1.setKeyboardScheme(Duo(true));
		PlayerSettings.player2.setKeyboardScheme(Duo(false));
	}

	public static function save() {
		volume = FlxG.sound.volume;
		for(field in Type.getClassFields(Options)) {
			var obj = Reflect.field(Options, field);
			if (Reflect.isFunction(obj) || obj is FlxSave) continue;
			Reflect.setField(__save.data, field, obj);
		}
		__save.flush();
	}
}
