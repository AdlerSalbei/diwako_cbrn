params ["_shower"];

if (local _shower) then {
    _shower setVariable ["diwako_cbrn_water", 120, true];
};

if !(hasInterface) exitWith {};

_shower setVariable ["BIN_deconshower_disableAction", true];

private _action = ["diwako_cbrn_turn_on", "Turn on","",{
    ["diwako_cbrn_turnOnShower", [_target]] call cba_fnc_globalEvent;
    _target setVariable ["diwako_cbrn_starTime", cba_missionTime];
    _target setVariable ["diwako_cbrn_on", true, true];
    private _remainingWater = _target getVariable ["diwako_cbrn_water", 120];

    [{!(_this getVariable ["diwako_cbrn_on", false])}, {}, _target, _remainingWater, {
        ["diwako_cbrn_turnOffShower", [_this]] call cba_fnc_globalEvent;
        _this setVariable ["diwako_cbrn_water", 0, true];
        _this setVariable ["diwako_cbrn_on", false, true];
    }] call CBA_fnc_waitUntilAndExecute;
}, {
    !(_target getVariable ["diwako_cbrn_on", false]) && {(_target getVariable ["diwako_cbrn_water", 120]) > 0}
}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[_shower, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["diwako_cbrn_turn_off", "Turn off","",{
    ["diwako_cbrn_turnOffShower", [_target]] call cba_fnc_globalEvent;
    private _diff = cba_missionTime - (_target getVariable ["diwako_cbrn_starTime", cba_missionTime]);
    private _waterRemaining = ((_target getVariable ["diwako_cbrn_water", 120]) - _diff) max 0;
    _target setVariable ["diwako_cbrn_water", _waterRemaining, true];
    _target setVariable ["diwako_cbrn_on", false, true];
},{
    _target getVariable ["diwako_cbrn_on", false]
},{},[], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[_shower, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
