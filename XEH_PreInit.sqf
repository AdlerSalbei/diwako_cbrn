diwako_cbrn_maxDamage = 100; // how much damage before death, 50% starts internal contamination
diwako_cbrn_backpacks = ["B_SCBA_01_F"];
diwako_cbrn_suits = ["U_C_cbrn_Suit_01_Blue_F",
    "U_B_cbrn_Suit_01_MTP_F",
    "U_B_cbrn_Suit_01_Tropic_F",
    "U_C_cbrn_Suit_01_White_F",
    "U_B_cbrn_Suit_01_Wdl_F",
    "U_I_cbrn_Suit_01_AAF_F",
    "U_I_E_cbrn_Suit_01_EAF_F"
];
diwako_cbrn_masks = ["G_AirPurifyingRespirator_02_black_F",
    "G_AirPurifyingRespirator_02_olive_F",
    "G_AirPurifyingRespirator_02_sand_F",
    "G_AirPurifyingRespirator_01_F",
    "G_RegulatorMask_F",
    "GP21_GasmaskPS",
    "GP5Filter_RaspiratorPS",
    "GP7_RaspiratorPS",
    "SE_M17",
    "Hamster_PS",
    "SE_S10"
];
diwako_cbrn_threatMeteritem = "ACE_microDAGR";
diwako_cbrn_maxOxygenTime = 60 * 30;

// do not edit below here unless you know what you are doing
if !(hasInterface) exitWith {};
diwako_cbrn_localZones = [];
["diwako_cbrn_createZone", {
    params ["_pos", "_threatLevel", "_size", "_falloffArea"];
    private _trg = createTrigger ["EmptyDetector", _pos, false];
    _trg setVariable ["diwako_cbrn_zone", true];
    _trg enableDynamicSimulation false;
    _trg setVariable ["diwako_cbrn_active", true];
    _trg setVariable ["diwako_cbrn_threatLevel", _threatLevel];
    _trg setVariable ["diwako_cbrn_size", _size];
    _trg setVariable ["diwako_cbrn_falloffArea", _falloffArea];
    private _radius = _size + _falloffArea;
    _trg setTriggerArea [_radius, _radius, 0, false, _radius];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["thisTrigger getVariable ['diwako_cbrn_active',false] && {this && {(vehicle ace_player) in thisList}}", "[thisTrigger, ace_player, true] call diwako_cbrn_fnc_addZone", "[thisTrigger, ace_player, false] call diwako_cbrn_fnc_addZone"];
    diwako_cbrn_localZones pushBack _trg;
}] call CBA_fnc_addEventhandler;


// display gas mask overlay above ace nvg and below DUI
if !(isNil "ace_nightvision") then {
    "ace_nightvision_display" cutFadeOut 0;
};
"diwako_cbrn_gasmask_overlay" cutFadeOut 0;
if !(isNil "diwako_dui_radar") then {
    "diwako_dui_compass" cutFadeOut 0;
    "diwako_dui_namebox" cutFadeOut 0;
};
