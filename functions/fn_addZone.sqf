params["_trigger", ["_unit", ace_player], ["_add", false]];

private _zones = _unit getVariable ["diwako_cbrn_zones", []];

if(_add) then {
    _zones pushBack _trigger;
} else {
    _zones = _zones - [_trigger];
};

_unit setVariable ["diwako_cbrn_zones", _zones, true];
