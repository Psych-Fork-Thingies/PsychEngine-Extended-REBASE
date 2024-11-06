package mobile.flixel;

import flixel.FlxG;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.utils.Assets;

// Lua VirtualPad
import haxe.ds.StringMap;

class FlxVirtualPad extends FlxSpriteGroup {
	//Actions
	public var buttonA:FlxButton;
	public var buttonB:FlxButton;
	public var buttonC:FlxButton;
	public var buttonD:FlxButton;
	public var buttonE:FlxButton;
	public var buttonM:FlxButton;
	public var buttonP:FlxButton;
	public var buttonV:FlxButton;
	public var buttonX:FlxButton;
	public var buttonY:FlxButton;
	public var buttonZ:FlxButton;
	public var buttonF:FlxButton;
	public var buttonG:FlxButton;
	
	//Extra
    public var buttonExtra1:FlxButton;
	public var buttonExtra2:FlxButton;
	public var buttonExtra3:FlxButton;
	public var buttonExtra4:FlxButton;
    
	//DPad
	public var buttonLeft:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonDown:FlxButton;

	//PAD DUO MODE
	public var buttonLeft2:FlxButton;
	public var buttonUp2:FlxButton;
	public var buttonRight2:FlxButton;
	public var buttonDown2:FlxButton;
    
    public var buttonCELeft:FlxButton;
	public var buttonCEUp:FlxButton;
	public var buttonCERight:FlxButton;
	public var buttonCEDown:FlxButton;
	public var buttonCEG:FlxButton;
	
	public var buttonCEUp_M:FlxButton;
	public var buttonCEDown_M:FlxButton;
	
	public var dPad:FlxSpriteGroup;
	public var actions:FlxSpriteGroup;

	public var orgAlpha:Float = 0.75;
	public var orgAntialiasing:Bool = true;
	
	/**
	 * Create a gamepad.
	 *
	 * @param   DPadMode     The D-Pad mode. `LEFT_FULL` for example.
	 * @param   ActionMode   The action buttons mode. `A_B_C` for example.
	 */

	public function new(DPad:FlxDPadMode, Action:FlxActionMode, ?alphaAlt:Float = 0.75, ?antialiasingAlt:Bool = true) {
		super();

		orgAntialiasing = antialiasingAlt;
		orgAlpha = ClientPrefs.data.VirtualPadAlpha;

		dPad = new FlxSpriteGroup();
		dPad.scrollFactor.set();

		actions = new FlxSpriteGroup();
		actions.scrollFactor.set();

		buttonA = new FlxButton(0, 0);
		buttonB = new FlxButton(0, 0);
		buttonC = new FlxButton(0, 0);
		buttonD = new FlxButton(0, 0);
		buttonE = new FlxButton(0, 0);
		buttonM = new FlxButton(0, 0);
		buttonP = new FlxButton(0, 0);
		buttonV = new FlxButton(0, 0);
		buttonX = new FlxButton(0, 0);
		buttonY = new FlxButton(0, 0);
		buttonZ = new FlxButton(0, 0);

		buttonLeft = new FlxButton(0, 0);
		buttonUp = new FlxButton(0, 0);
		buttonRight = new FlxButton(0, 0);
		buttonDown = new FlxButton(0, 0);

		buttonLeft2 = new FlxButton(0, 0);
		buttonUp2 = new FlxButton(0, 0);
		buttonRight2 = new FlxButton(0, 0);
		buttonDown2 = new FlxButton(0, 0);
        
        buttonCELeft = new FlxButton(0, 0);
		buttonCEUp = new FlxButton(0, 0);
		buttonCERight = new FlxButton(0, 0);
		buttonCEDown = new FlxButton(0, 0);
		buttonCEG = new FlxButton(0, 0);
		
		buttonCEUp_M = new FlxButton(0, 0);
		buttonCEDown_M = new FlxButton(0, 0);
		
		switch (DPad){
			case UP_DOWN:
				dPad.add(add(buttonUp = createButton(0, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonDown = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
			case LEFT_RIGHT:
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(42 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "right", 0xFF0000)));
			case UP_LEFT_RIGHT:
				dPad.add(add(buttonUp = createButton(35 * 3, FlxG.height - 81 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(69 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "right", 0xFF0000)));
			case FULL:
				dPad.add(add(buttonUp = createButton(35 * 3, FlxG.height - 116 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 81 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(69 * 3, FlxG.height - 81 * 3, 44 * 3, 127, "right", 0xFF0000)));
				dPad.add(add(buttonDown = createButton(35 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
			case ALL:
				dPad.add(add(buttonUp = createButton(0, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonDown = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
				dPad.add(add(buttonLeft = createButton(42 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(42 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "right", 0xFF0000)));
			case OptionsC:
			    add(buttonUp = createButton(0, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00));
				add(buttonDown = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF));	
			case RIGHT_FULL:
				dPad.add(add(buttonUp = createButton(FlxG.width - 86 * 3, FlxG.height - 66 - 116 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonLeft = createButton(FlxG.width - 128 * 3, FlxG.height - 66 - 81 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(FlxG.width - 44 * 3, FlxG.height - 66 - 81 * 3, 44 * 3, 127, "right", 0xFF0000)));
				dPad.add(add(buttonDown = createButton(FlxG.width - 86 * 3, FlxG.height - 66 - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
			case DUO:
				dPad.add(add(buttonUp = createButton(35 * 3, FlxG.height - 116 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 81 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(69 * 3, FlxG.height - 81 * 3, 44 * 3, 127, "right", 0xFF0000)));
				dPad.add(add(buttonDown = createButton(35 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
				dPad.add(add(buttonUp2 = createButton(FlxG.width - 86 * 3, FlxG.height - 66 - 116 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonLeft2 = createButton(FlxG.width - 128 * 3, FlxG.height - 66 - 81 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight2 = createButton(FlxG.width - 44 * 3, FlxG.height - 66 - 81 * 3, 44 * 3, 127, "right", 0xFF0000)));
				dPad.add(add(buttonDown2 = createButton(FlxG.width - 86 * 3, FlxG.height - 66 - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
			case PAUSE:	
				dPad.add(add(buttonUp = createButton(0, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonDown = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
				dPad.add(add(buttonLeft = createButton(42 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(84 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "right", 0xFF0000)));
			case CHART_EDITOR:
				dPad.add(add(buttonUp = createButton(0, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonDown = createButton(0, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));
				dPad.add(add(buttonLeft = createButton(42 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "left", 0xFF00FF)));
				dPad.add(add(buttonRight = createButton(42 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "right", 0xFF0000)));
				
				//dPad.add(add(buttonCEUp_M = createButton(0, FlxG.height - 127 * 3, 44 * 3, 127, "up", 0xFF00FF)));
				//dPad.add(add(buttonCEDown_M = createButton(42 * 3, FlxG.height - 127 * 3, 44 * 3, 127, "down", 0xFF0000)));
			case NONE:
		}

		switch (Action){
		    case E:
		        #if mobile
		        orgAlpha = 1;
		        #end
				actions.add(add(buttonE = createButton(FlxG.width - 44 * 3, FlxG.height - 125 * 3, 44 * 3, 127, "modding", 0xFF7D00, false)));
			case A:
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));
			case B:
				actions.add(add(buttonB = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));
			case D:
				actions.add(add(buttonD = createButton(FlxG.width - 44 * 3, FlxG.height - 127 * 3, 44 * 3, 127, "d", 0x0078FF)));						
			case P:
				actions.add(add(buttonP = createButton(FlxG.width - 44 * 3, FlxG.height - 127 * 3, 44 * 3, 127, "d", 0x0078FF)));						
		    case X_Y:
				actions.add(add(buttonY = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonX = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "x", 0x99062D)));
			case A_B:
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));
			case A_C:
				actions.add(add(buttonC = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));				
			case A_B_C:
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));				
			case A_B_E:
				actions.add(add(buttonE = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "e", 0xFF7D00)));   
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));
			case A_B_E_C_M:
			    actions.add(add(buttonM = createButton(FlxG.width - 86 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "m", 0xFFCB00)));
				actions.add(add(buttonE = createButton(FlxG.width - 44 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "e", 0xFF7D00)));   
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));
			    actions.add(add(buttonC = createButton(FlxG.width - 44 * 3, FlxG.height - 125 * 3, 44 * 3, 127, "c", 0x44FF00)));
 			case A_B_X_Y:
				actions.add(add(buttonY = createButton(FlxG.width - 170 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonX = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));	 			               
		    case A_X_Y:
				actions.add(add(buttonY = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonX = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));								
			case B_X_Y:
				actions.add(add(buttonY = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonX = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonB = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
			case A_B_C_X_Y:		
				actions.add(add(buttonY = createButton(FlxG.width - 86 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonX = createButton(FlxG.width - 44 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));				
			case A_B_C_X_Y_Z:
				actions.add(add(buttonX = createButton(FlxG.width - 128 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonY = createButton(FlxG.width - 86 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonZ = createButton(FlxG.width - 44 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "z", 0xCCB98E)));
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));	
			case FULL:
				actions.add(add(buttonV = createButton(FlxG.width - 170 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "v", 0x49A9B2)));            
				actions.add(add(buttonX = createButton(FlxG.width - 128 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonY = createButton(FlxG.width - 86 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonZ = createButton(FlxG.width - 44 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "z", 0xCCB98E)));
				actions.add(add(buttonD = createButton(FlxG.width - 170 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "d", 0x0078FF)));
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));
		    case OptionsC:
			    add(buttonLeft = createButton(FlxG.width - 258, FlxG.height - 85 * 3, 44 * 3, 127, "left", 0xFF00FF));
				add(buttonRight = createButton(FlxG.width - 132, FlxG.height - 85 * 3, 44 * 3, 127, "right", 0xFF0000));
			    add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
			    add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case ALL:
				actions.add(add(buttonV = createButton(FlxG.width - 170 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "v", 0x49A9B2)));            
				actions.add(add(buttonX = createButton(FlxG.width - 128 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonY = createButton(FlxG.width - 86 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonZ = createButton(FlxG.width - 44 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "z", 0xCCB98E)));
				actions.add(add(buttonD = createButton(FlxG.width - 170 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "d", 0x0078FF)));
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));				
				
				dPad.add(add(buttonCEUp = createButton(FlxG.width - (44 + 42 * 4) * 3, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonCEDown = createButton(FlxG.width - (44 + 42 * 4) * 3, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));		
				dPad.add(add(buttonCEG = createButton(FlxG.width - (44 + 42 * 1) * 3, 25, 44 * 3, 127, "g", 0x00FF00)));
				
			case controlExtend:
			    if (Type.getClass(FlxG.state) != PlayState || Type.getClass(FlxG.state) == PlayState && ClientPrefs.data.extraKeys >= 1) actions.add(add(buttonExtra1 = createButton(FlxG.width * 0.5 - 44 * 3, FlxG.height * 0.5 - 127 * 0.5, 44 * 3, 127, "f", 0xFF0000)));
				if (Type.getClass(FlxG.state) != PlayState || Type.getClass(FlxG.state) == PlayState && ClientPrefs.data.extraKeys >= 2) actions.add(add(buttonExtra2 = createButton(FlxG.width * 0.5, FlxG.height * 0.5 - 127 * 0.5, 44 * 3, 127, "g", 0xFFFF00)));	
				if (Type.getClass(FlxG.state) != PlayState || Type.getClass(FlxG.state) == PlayState && ClientPrefs.data.extraKeys >= 3) actions.add(add(buttonExtra3 = createButton(FlxG.width * 0.5, FlxG.height * 0.5 - 127 * 0.5, 44 * 3, 127, "x", 0x99062D)));	
				if (Type.getClass(FlxG.state) != PlayState || Type.getClass(FlxG.state) == PlayState && ClientPrefs.data.extraKeys >= 4) actions.add(add(buttonExtra4 = createButton(FlxG.width * 0.5, FlxG.height * 0.5 - 127 * 0.5, 44 * 3, 127, "y", 0x4A35B9)));	
				
			case CHART_EDITOR:
				actions.add(add(buttonV = createButton(FlxG.width - 170 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "v", 0x49A9B2)));            
				actions.add(add(buttonX = createButton(FlxG.width - 128 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "x", 0x99062D)));
				actions.add(add(buttonY = createButton(FlxG.width - 86 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "y", 0x4A35B9)));
				actions.add(add(buttonZ = createButton(FlxG.width - 44 * 3, FlxG.height - 85 * 3, 44 * 3, 127, "z", 0xCCB98E)));
				actions.add(add(buttonD = createButton(FlxG.width - 170 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "d", 0x0078FF)));
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "c", 0x44FF00)));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "a", 0xFF0000)));				
				
				dPad.add(add(buttonCEUp = createButton(FlxG.width - (44 + 42 * 4) * 3, FlxG.height - 85 * 3, 44 * 3, 127, "up", 0x00FF00)));
				dPad.add(add(buttonCEDown = createButton(FlxG.width - (44 + 42 * 4) * 3, FlxG.height - 45 * 3, 44 * 3, 127, "down", 0x00FFFF)));		
				dPad.add(add(buttonCEG = createButton(FlxG.width - (44 + 42 * 1) * 3, 25, 44 * 3, 127, "g", 0x00FF00)));
			case B_E:
				actions.add(add(buttonE = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "e", 0xFF7D00)));  
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 127, "b", 0xFFCB00)));					
			case NONE:
		}
	}

	public function createButton(x:Float, y:Float, width:Int, height:Int, Frames:String, ColorS:Int, ?colored:Bool = true):FlxButton {
	if (ClientPrefs.data.virtualpadType == 'New') {
	    var frames:FlxGraphic;

		final path:String = 'shared:assets/shared/images/virtualpad/' + ClientPrefs.data.VirtualPadSkin + '/$Frames.png';
		#if MODS_ALLOWED
		final modsPath:String = Paths.modsImages('virtualpad/' + ClientPrefs.data.VirtualPadSkin + '/$Frames');
		if(sys.FileSystem.exists(modsPath))
			frames = FlxGraphic.fromBitmapData(BitmapData.fromFile(modsPath));
		else #end if(Assets.exists(path))
			frames = FlxGraphic.fromBitmapData(Assets.getBitmapData(path));
		else
			frames = FlxGraphic.fromBitmapData(Assets.getBitmapData('shared:assets/shared/images/virtualpad/original/default.png'));

		var button:FlxButton = new FlxButton(x, y);
		button.frames = FlxTileFrames.fromGraphic(frames, FlxPoint.get(Std.int(frames.width / 2), frames.height));
		button.solid = false;
		button.immovable = true;
		button.moves = false;
		button.scrollFactor.set();
		if (colored && ClientPrefs.data.coloredvpad) button.color = ColorS;
		button.antialiasing = ClientPrefs.data.antialiasing;
		button.alpha = orgAlpha;
		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end
		return button;
	}
	else // you can still use the old controls if you want
	{
		var button = new FlxButton(x, y);
		button.frames = FlxTileFrames.fromFrame(getFrames().getByName(Frames), FlxPoint.get(width, height));
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
		button.scrollFactor.set();
		button.alpha = orgAlpha;
		if (colored && ClientPrefs.data.coloredvpad) button.color = ColorS;
		button.antialiasing = orgAntialiasing;
		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end
		return button;
	}
	}

	public static function getFrames():FlxAtlasFrames {
	    try
	    {
		    return Paths.getPackerAtlas('mobilecontrols/virtualpad/' + ClientPrefs.data.VirtualPadSkin);
		}
		catch(e:Dynamic)
		{
		    return Paths.getPackerAtlas('mobilecontrols/virtualpad/original');
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
		for (field in Reflect.fields(this))
			if (Std.isOfType(Reflect.field(this, field), FlxButton))
				Reflect.setField(this, field, FlxDestroyUtil.destroy(Reflect.field(this, field)));
	}
}