params [["_pos", [0,0,0]], ["_threatLevel", 1, [0]], ["_size",100], ["_falloffArea",50]];

if !(isServer) exitWith {};
if (_pos isEqualTo [0,0,0] || {_threatLevel < 1}) exitWith {};

_pos = _pos call CBA_fnc_getPos;

["diwako_cbrn_createZone", [_pos, _threatLevel, _size, _falloffArea]] call CBA_fnc_globalEventJip;
if ((_size + _falloffArea) > diwako_cbrn_zoneSimulationRange) then {
    diwako_cbrn_zoneSimulationRange = _size + _falloffArea + 50;
    publicVariable "diwako_cbrn_zoneSimulationRange";
};