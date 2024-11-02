package;

import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.mappings.FlxGamepadMapping;
import flixel.input.keyboard.FlxKey;

#if mobile
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import mobile.flixel.FlxButton as FlxNewButton;
#end

class Controls
{
	//Keeping same use cases on stuff for it to be easier to understand/use
	//I'd have removed it but this makes it a lot less annoying to use in my opinion

	//You do NOT have to create these variables/getters for adding new keys,
	//but you will instead have to use:
	//   controls.justPressed("ui_up")   instead of   controls.UI_UP
	
	/*
	android control make by NF|beihu ,logic is very shit but its easy to understand
    */
	//Dumb but easily usable code, or Smart but complicated? Your choice.
	//Also idk how to use macros they're weird as fuck lol

	// Pressed buttons (directions)
	public var UI_UP_P(get, never):Bool;
	public var UI_DOWN_P(get, never):Bool;
	public var UI_LEFT_P(get, never):Bool;
	public var UI_RIGHT_P(get, never):Bool;
	public var NOTE_UP_P(get, never):Bool;
	public var NOTE_DOWN_P(get, never):Bool;
	public var NOTE_LEFT_P(get, never):Bool;
	public var NOTE_RIGHT_P(get, never):Bool;
	public var SPACE_P(get, never):Bool;
	private function get_UI_UP_P() return justPressed('ui_up');
	private function get_UI_DOWN_P() return justPressed('ui_down');
	private function get_UI_LEFT_P() return justPressed('ui_left');
	private function get_UI_RIGHT_P() return justPressed('ui_right');
	private function get_NOTE_UP_P() return justPressed('note_up');
	private function get_NOTE_DOWN_P() return justPressed('note_down');
	private function get_NOTE_LEFT_P() return justPressed('note_left');
	private function get_NOTE_RIGHT_P() return justPressed('note_right');
    private function get_SPACE_P() return justPressed('space');
    
	// Held buttons (directions)
	public var UI_UP(get, never):Bool;
	public var UI_DOWN(get, never):Bool;
	public var UI_LEFT(get, never):Bool;
	public var UI_RIGHT(get, never):Bool;
	public var NOTE_UP(get, never):Bool;
	public var NOTE_DOWN(get, never):Bool;
	public var NOTE_LEFT(get, never):Bool;
	public var NOTE_RIGHT(get, never):Bool;
	public var SPACE(get, never):Bool;
	private function get_UI_UP() return pressed('ui_up');
	private function get_UI_DOWN() return pressed('ui_down');
	private function get_UI_LEFT() return pressed('ui_left');
	private function get_UI_RIGHT() return pressed('ui_right');
	private function get_NOTE_UP() return pressed('note_up');
	private function get_NOTE_DOWN() return pressed('note_down');
	private function get_NOTE_LEFT() return pressed('note_left');
	private function get_NOTE_RIGHT() return pressed('note_right');
    private function get_SPACE() return pressed('space');
    
	// Released buttons (directions)
	public var UI_UP_R(get, never):Bool;
	public var UI_DOWN_R(get, never):Bool;
	public var UI_LEFT_R(get, never):Bool;
	public var UI_RIGHT_R(get, never):Bool;
	public var NOTE_UP_R(get, never):Bool;
	public var NOTE_DOWN_R(get, never):Bool;
	public var NOTE_LEFT_R(get, never):Bool;
	public var NOTE_RIGHT_R(get, never):Bool;
	public var SPACE_R(get, never):Bool;
	private function get_UI_UP_R() return justReleased('ui_up');
	private function get_UI_DOWN_R() return justReleased('ui_down');
	private function get_UI_LEFT_R() return justReleased('ui_left');
	private function get_UI_RIGHT_R() return justReleased('ui_right');
	private function get_NOTE_UP_R() return justReleased('note_up');
	private function get_NOTE_DOWN_R() return justReleased('note_down');
	private function get_NOTE_LEFT_R() return justReleased('note_left');
	private function get_NOTE_RIGHT_R() return justReleased('note_right');
	private function get_SPACE_R() return justReleased('space');


	// Pressed buttons (others)
	public var ACCEPT(get, never):Bool;
	public var BACK(get, never):Bool;
	public var PAUSE(get, never):Bool;
	public var RESET(get, never):Bool;
	private function get_ACCEPT() return justPressed('accept');
	private function get_BACK() return justPressed('back');
	private function get_PAUSE() return justPressed('pause');
	private function get_RESET() return justPressed('reset');
	
	public static var checkState:Bool = true;
	public static var CheckPress:Bool = true;
    public static var CheckControl:Bool = true;
    public static var CheckKeyboard:Bool = false;
	//Gamepad & Keyboard stuff
	public var keyboardBinds:Map<String, Array<FlxKey>>;
	public var gamepadBinds:Map<String, Array<FlxGamepadInputID>>;
	public function justPressed(key:String)
	{
		
		var result:Bool = false;		
		
		if (FlxG.keys.anyJustPressed(keyboardBinds[key])){
		result = true;
		controllerMode = false;
		}				

		return result || _myGamepadJustPressed(gamepadBinds[key]) == true #if mobile || checkMobileControl_justPressed(key) == true #end;
	}

	public function pressed(key:String)
	{		
		
		var result:Bool = false;
		
		
		
		if (FlxG.keys.anyPressed(keyboardBinds[key])){
		result = true;
		controllerMode = false;
		}

		return result || _myGamepadPressed(gamepadBinds[key]) == true #if mobile || checkMobileControl_pressed(key) == true #end;
	}

	public function justReleased(key:String)
	{
		
		var result:Bool = false;
		
		
		
		if (FlxG.keys.anyJustReleased(keyboardBinds[key])){
		result = true;
		controllerMode = false;
		}

		return result || _myGamepadJustReleased(gamepadBinds[key]) == true #if mobile || checkMobileControl_justReleased(key) == true #end;
	}

	public var controllerMode:Bool = false;
	private function _myGamepadJustPressed(keys:Array<FlxGamepadInputID>):Bool
	{
		if(keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyJustPressed(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
	private function _myGamepadPressed(keys:Array<FlxGamepadInputID>):Bool
	{
		if(keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyPressed(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
	private function _myGamepadJustReleased(keys:Array<FlxGamepadInputID>):Bool
	{
		if(keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyJustReleased(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
	
	#if mobile
	
	private function checkMobileControl_justPressed(key:String):Bool
	{
	
	    var result:Bool = false;
	    
	    
	    //------------------ui
	    if (CheckPress){
		    if (checkState){
    		    if (key == 'accept'){
    		    result = (MusicBeatState._virtualpad.buttonA.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'back'){
    		    result = (MusicBeatState._virtualpad.buttonB.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
		
        		if (key == 'ui_up'){
        		result = (MusicBeatState._virtualpad.buttonUp.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_down'){
        		result = (MusicBeatState._virtualpad.buttonDown.justPressed == true);
           		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_left'){
        		result = (MusicBeatState._virtualpad.buttonLeft.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_right'){
        		result = (MusicBeatState._virtualpad.buttonRight.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		        }
		        }//checkState
		    else{
    		    if (key == 'accept'){
    		    result = (MusicBeatSubstate._virtualpad.buttonA.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'back'){
    		    result = (MusicBeatSubstate._virtualpad.buttonB.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
		
    		    if (key == 'ui_up'){
    		    result = (MusicBeatSubstate._virtualpad.buttonUp.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_down'){
    		    result = (MusicBeatSubstate._virtualpad.buttonDown.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_left'){
    		    result = (MusicBeatSubstate._virtualpad.buttonLeft.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_right'){
    		    result = (MusicBeatSubstate._virtualpad.buttonRight.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }						
		    }//!checkState
		}//CheckPress
		
		//------------------note
		if (!CheckKeyboard){
		if (CheckControl){
    		if (MusicBeatState.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatState.mobilec.newhbox.buttonUp.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobilec.newhbox.buttonDown.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobilec.newhbox.buttonLeft.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobilec.newhbox.buttonRight.justPressed == true);
        		if(result) {controllerMode = true; return true;}
    		    }
    		}//MusicBeatState.checkHitbox
    		else{
    		    if (MusicBeatState.checkDUO){
        		    if (key == 'note_up'){
            		result = ((MusicBeatState.mobilec.vpad.buttonUp.justPressed || MusicBeatState.mobilec.vpad.buttonUp2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = ((MusicBeatState.mobilec.vpad.buttonDown.justPressed || MusicBeatState.mobilec.vpad.buttonDown2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = ((MusicBeatState.mobilec.vpad.buttonLeft.justPressed || MusicBeatState.mobilec.vpad.buttonLeft2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = ((MusicBeatState.mobilec.vpad.buttonRight.justPressed || MusicBeatState.mobilec.vpad.buttonRight2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		    }		    
        		    }//MusicBeatState.checkDUO
    		    else{
            		if (key == 'note_up'){
            		result = (MusicBeatState.mobilec.vpad.buttonUp.justPressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = (MusicBeatState.mobilec.vpad.buttonDown.justPressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = (MusicBeatState.mobilec.vpad.buttonLeft.justPressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = (MusicBeatState.mobilec.vpad.buttonRight.justPressed == true);
            		if(result) {controllerMode = true; return true;}
        		    }
    		    }//!MusicBeatState.checkDUO
    	    }//!MusicBeatState.checkHitbox
	    }//CheckControl
	    else{
	    if (MusicBeatSubstate.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonUp.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonDown.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonLeft.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonRight.justPressed == true);
        		if(result) {controllerMode = true; return true;}
    		    }
    		}//MusicBeatSubstate.checkHitbox
    		else{
    		    if (MusicBeatSubstate.checkDUO){
        		    if (key == 'note_up'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonUp.justPressed || MusicBeatSubstate.mobilec.vpad.buttonUp2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonDown.justPressed || MusicBeatSubstate.mobilec.vpad.buttonDown2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonLeft.justPressed || MusicBeatSubstate.mobilec.vpad.buttonLeft2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonRight.justPressed || MusicBeatSubstate.mobilec.vpad.buttonRight2.justPressed) == true);
            		if(result) {controllerMode = true; return true;}
            		    }		    
        		    }//MusicBeatSubstate.checkDUO
    		    else{
            		if (key == 'note_up'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonUp.justPressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonDown.justPressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonLeft.justPressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonRight.justPressed == true);
            		if(result) {controllerMode = true; return true;}
        		    }
    		    }//!MusicBeatSubstate.checkDUO
    	    }//!MusicBeatSubstate.checkHitbox
	    }//!CheckControl
	    }//!CheckKeyboard
	    return false;
    }
    
    
    
    private function checkMobileControl_pressed(key:String):Bool
    {
    
    var result:Bool = false;
    
        //------------------ui
	    if (CheckPress){
		    if (checkState){
    		    if (key == 'accept'){
    		    result = (MusicBeatState._virtualpad.buttonA.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'back'){
    		    result = (MusicBeatState._virtualpad.buttonB.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
		
        		if (key == 'ui_up'){
        		result = (MusicBeatState._virtualpad.buttonUp.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_down'){
        		result = (MusicBeatState._virtualpad.buttonDown.pressed == true);
           		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_left'){
        		result = (MusicBeatState._virtualpad.buttonLeft.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_right'){
        		result = (MusicBeatState._virtualpad.buttonRight.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		        }
		        }//checkState
		    else{
    		    if (key == 'accept'){
    		    result = (MusicBeatSubstate._virtualpad.buttonA.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'back'){
    		    result = (MusicBeatSubstate._virtualpad.buttonB.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
		
    		    if (key == 'ui_up'){
    		    result = (MusicBeatSubstate._virtualpad.buttonUp.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_down'){
    		    result = (MusicBeatSubstate._virtualpad.buttonDown.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_left'){
    		    result = (MusicBeatSubstate._virtualpad.buttonLeft.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_right'){
    		    result = (MusicBeatSubstate._virtualpad.buttonRight.pressed == true);
    		    if(result) {controllerMode = true; return true;}
    		    }						
		    }//!checkState
		}//CheckPress
		
		//------------------note
		if(!CheckKeyboard){
		if (CheckControl){
    		if (MusicBeatState.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatState.mobilec.newhbox.buttonUp.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobilec.newhbox.buttonDown.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobilec.newhbox.buttonLeft.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobilec.newhbox.buttonRight.pressed == true);
        		if(result) {controllerMode = true; return true;}
    		    }
    		}//MusicBeatState.checkHitbox
    		else{
    		    if (MusicBeatState.checkDUO){
        		    if (key == 'note_up'){
            		result = ((MusicBeatState.mobilec.vpad.buttonUp.pressed || MusicBeatState.mobilec.vpad.buttonUp2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = ((MusicBeatState.mobilec.vpad.buttonDown.pressed || MusicBeatState.mobilec.vpad.buttonDown2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = ((MusicBeatState.mobilec.vpad.buttonLeft.pressed || MusicBeatState.mobilec.vpad.buttonLeft2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = ((MusicBeatState.mobilec.vpad.buttonRight.pressed || MusicBeatState.mobilec.vpad.buttonRight2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		    }		    
        		    }//MusicBeatState.checkDUO
    		    else{
            		if (key == 'note_up'){
            		result = (MusicBeatState.mobilec.vpad.buttonUp.pressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = (MusicBeatState.mobilec.vpad.buttonDown.pressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = (MusicBeatState.mobilec.vpad.buttonLeft.pressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = (MusicBeatState.mobilec.vpad.buttonRight.pressed == true);
            		if(result) {controllerMode = true; return true;}
        		    }
    		    }//!MusicBeatState.checkDUO
    	    }//!MusicBeatState.checkHitbox
	    }//CheckControl
	    else{
	    if (MusicBeatSubstate.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonUp.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonDown.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonLeft.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonRight.pressed == true);
        		if(result) {controllerMode = true; return true;}
    		    }
    		}//MusicBeatSubstate.checkHitbox
    		else{
    		    if (MusicBeatSubstate.checkDUO){
        		    if (key == 'note_up'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonUp.pressed || MusicBeatSubstate.mobilec.vpad.buttonUp2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonDown.pressed || MusicBeatSubstate.mobilec.vpad.buttonDown2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonLeft.pressed || MusicBeatSubstate.mobilec.vpad.buttonLeft2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonRight.pressed || MusicBeatSubstate.mobilec.vpad.buttonRight2.pressed) == true);
            		if(result) {controllerMode = true; return true;}
            		    }		    
        		    }//MusicBeatSubstate.checkDUO
    		    else{
            		if (key == 'note_up'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonUp.pressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonDown.pressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonLeft.pressed == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonRight.pressed == true);
            		if(result) {controllerMode = true; return true;}
        		    }
    		    }//!MusicBeatSubstate.checkDUO
    	    }//!MusicBeatSubstate.checkHitbox
	    }//!CheckControl
	    }//!CheckKeyboard
        return false;
	   // if (result) return true;
    
    }
    
    private function checkMobileControl_justReleased(key:String):Bool
    {
    
    var result:Bool = false;
    
        //------------------ui
	    if (CheckPress){
		    if (checkState){
    		    if (key == 'accept'){
    		    result = (MusicBeatState._virtualpad.buttonA.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'back'){
    		    result = (MusicBeatState._virtualpad.buttonB.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
		
        		if (key == 'ui_up'){
        		result = (MusicBeatState._virtualpad.buttonUp.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_down'){
        		result = (MusicBeatState._virtualpad.buttonDown.justReleased == true);
           		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_left'){
        		result = (MusicBeatState._virtualpad.buttonLeft.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'ui_right'){
        		result = (MusicBeatState._virtualpad.buttonRight.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		        }
		        }//checkState
		    else{
    		    if (key == 'accept'){
    		    result = (MusicBeatSubstate._virtualpad.buttonA.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'back'){
    		    result = (MusicBeatSubstate._virtualpad.buttonB.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
		
    		    if (key == 'ui_up'){
    		    result = (MusicBeatSubstate._virtualpad.buttonUp.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_down'){
    		    result = (MusicBeatSubstate._virtualpad.buttonDown.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_left'){
    		    result = (MusicBeatSubstate._virtualpad.buttonLeft.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }
    		    if (key == 'ui_right'){
    		    result = (MusicBeatSubstate._virtualpad.buttonRight.justReleased == true);
    		    if(result) {controllerMode = true; return true;}
    		    }						
		    }//!checkState
		}//CheckPress
		
		//------------------note
		if (!CheckKeyboard){
		if (CheckControl){
    		if (MusicBeatState.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatState.mobilec.newhbox.buttonUp.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobilec.newhbox.buttonDown.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobilec.newhbox.buttonLeft.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobilec.newhbox.buttonRight.justReleased == true);
        		if(result) {controllerMode = true; return true;}
    		    }
    		}//MusicBeatState.checkHitbox
    		else{
    		    if (MusicBeatState.checkDUO){
        		    if (key == 'note_up'){
            		result = ((MusicBeatState.mobilec.vpad.buttonUp.justReleased || MusicBeatState.mobilec.vpad.buttonUp2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = ((MusicBeatState.mobilec.vpad.buttonDown.justReleased || MusicBeatState.mobilec.vpad.buttonDown2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = ((MusicBeatState.mobilec.vpad.buttonLeft.justReleased || MusicBeatState.mobilec.vpad.buttonLeft2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = ((MusicBeatState.mobilec.vpad.buttonRight.justReleased || MusicBeatState.mobilec.vpad.buttonRight2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		    }		    
        		    }//MusicBeatState.checkDUO
    		    else{
            		if (key == 'note_up'){
            		result = (MusicBeatState.mobilec.vpad.buttonUp.justReleased == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = (MusicBeatState.mobilec.vpad.buttonDown.justReleased == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = (MusicBeatState.mobilec.vpad.buttonLeft.justReleased == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = (MusicBeatState.mobilec.vpad.buttonRight.justReleased == true);
            		if(result) {controllerMode = true; return true;}
        		    }
    		    }//!MusicBeatState.checkDUO
    	    }//!MusicBeatState.checkHitbox
	    }//CheckControl
	    else{
	    if (MusicBeatSubstate.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonUp.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonDown.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonLeft.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatSubstate.mobilec.newhbox.buttonRight.justReleased == true);
        		if(result) {controllerMode = true; return true;}
    		    }
    		}//MusicBeatSubstate.checkHitbox
    		else{
    		    if (MusicBeatSubstate.checkDUO){
        		    if (key == 'note_up'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonUp.justReleased || MusicBeatSubstate.mobilec.vpad.buttonUp2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonDown.justReleased || MusicBeatSubstate.mobilec.vpad.buttonDown2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonLeft.justReleased || MusicBeatSubstate.mobilec.vpad.buttonLeft2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = ((MusicBeatSubstate.mobilec.vpad.buttonRight.justReleased || MusicBeatSubstate.mobilec.vpad.buttonRight2.justReleased) == true);
            		if(result) {controllerMode = true; return true;}
            		    }		    
        		    }//MusicBeatSubstate.checkDUO
    		    else{
            		if (key == 'note_up'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonUp.justReleased == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_down'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonDown.justReleased == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_left'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonLeft.justReleased == true);
            		if(result) {controllerMode = true; return true;}
            		}
            		if (key == 'note_right'){
            		result = (MusicBeatSubstate.mobilec.vpad.buttonRight.justReleased == true);
            		if(result) {controllerMode = true; return true;}
        		    }
    		    }//!MusicBeatSubstate.checkDUO
    	    }//!MusicBeatSubstate.checkHitbox
	    }//!CheckControl
	    }//!CheckKeyboard
	    return false;
	  //  if (result) return true;
    
    }
    
    #end
    
	// IGNORE THESE
	public static var instance:Controls;
	public function new()
	{
		keyboardBinds = ClientPrefs.keyBinds;
		gamepadBinds = ClientPrefs.gamepadBinds;
	}
}