# diwako_cbrn

Mission script to add an arcadey CBRN mechanic into an Arma mission. This script is not meant to be realistic, as breathing in 2 seconds of some bad smell air causing death is not fun on a gameplay level. However, you can tune down the max CBRN damage to get this effect if you really wish!\
CBRN threats are abstracted into 4 threat levels which are color coded by green, yellow, orange and red.

Threat level diagram, all threats level requirements stack:

1. Green: No CBRN gear need
2. Yellow: Gas mask needed
3. Orange: Supply of fresh air needed
4. Red: Full CBRN suit needed

This script comes with a custom gasmask overlay, breathing sounds and custom low oxygen warning sounds.

## Custom CBRN damage

This script features custom CBRN damage values, it is just a flat number and when you go over this number, you die. As CBRN damage takes quite some time to decrease hence why it is not simulated and CBRN damage stays until respawn.\
If a unit reaches 50% of the maximum CBRN damage it will be informed that from now on the CBRN damage will go up passively even if full CBRN protection is present. The unit needs to decontaminate at a small decon shower. Walk up to the shower, activate it via ACE interactions and stand in it until you receive a new message!\
Warning: Water is finite, make sure to turn off the shower again!

## Functions for mission makers

There is only one function that is public to use for mission makers. It is the function to create zones, recommended to do so via `initServer.sqf`.

```sqf
/*
 * Arguments:
 * 0: Center of zone, position array
 * 1: Threatlevel between 1 and 4.9, float
 * 2: Radius of full effect, float
 * 3: Radius of partial effect, float
 */
[getMarkerPos "marker_0", 1.5, 25, 25] call cbrn_fnc_createZone;
```

## Requirements

CBA_A3 and ACE3

## Variables

There are several variables preset for Vanilla and ACE3 gear, those can be overwritten either directly in the files or in your own `postinit` function or `init.sqf` file

### cbrn_maxDamage

Integer how much damage can be absorbed before death.\
If 50% of damage is reached passive contamination starts that needs to be stopped via decontamination showers!\
default: 100

### cbrn_masks

Array of strings, warning: CaSeSeNsItiVe!\
Array of facewear/goggles which are to be considered gasmasks.\
Default: Array of all vanilla Gasmasks and some select mod ones

### cbrn_backpacks

Array of strings, warning: CaSeSeNsItiVe!\
Array of backpacks which are to be considered oxygen tanks.\
Default: Array containing only the self-contained oxygen tank

### cbrn_suits

Array of strings, warning: CaSeSeNsItiVe!\
Array of uniforms which are to be considered cbrn suits.\
Default: Array of all Vanilla CBRN suits

### cbrn_threatMeterItem

String of item name that should be considered as threat meter item.\
Default: "ACE_microDAGR"

### cbrn_maxOxygenTime

Float, value in seconds of how long one oxygen container should last.\
Default: 30 Minutes

## Links

BI Thread: https://forums.bohemia.net/forums/topic/225668-cbrn-script/

## initServer.sqf
/*
Adding zones must be done by server. If you add them via any other machine, it will simply not work!

Zones work as follows:
They are always circular!
You need to specify their center,their threat level (ranging between 0 and 5), their radius and fall off area!

The fall off area will add to the radius, but the threadlevel will not be in full effect. As example:
You want a threat area spanning 500 meters in radius, but you only want the full effect of threatlevel 3.5 withing 100 meters of the center, this would look like this:

[_pos, 3.5, 100, 400] call cbrn_fnc_createZone;

This will create a threat level 3.5 (Orange) zone around position _pos with total radius of 500 meters and full effect is 100 meter radius around the center!
*/

// setting up examples on map
[getMarkerPos "marker_0", 1.5, 25, 25] call cbrn_fnc_createZone;
[getMarkerPos "marker_1", 2.5, 25, 25] call cbrn_fnc_createZone;
[getMarkerPos "marker_2", 3.5, 25, 25] call cbrn_fnc_createZone;

## Descritpion.ext
class CfgFunctions {
    #include "node_modules\cbrn\funcs.hpp"
};

class CfgSounds {
    sounds[] = {};
    #include "node_modules\cbrn\sounds\sounds.hpp"
};

class RscTitles {
    #include "node_modules\cbrn\rsctitles.hpp"
}

class Extended_PreInit_EventHandlers {
    class cbrn_preInit {
        init = "[] call compile preProcessFileLineNumbers 'node_modules\cbrn\XEH_PreInit.sqf'";
    };
};

class Extended_InitPost_EventHandlers {
    #include "node_modules\cbrn\XEH_InitPost_eh.hpp"
};