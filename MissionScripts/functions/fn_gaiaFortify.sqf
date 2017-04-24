/*
ElDoktor
[this,NB_RESPAWN] call DOK_fnc_gaiaFortify;
[this] call DOK_fnc_gaiaFortify;
[this,5] call DOK_fnc_gaiaFortify;
*/
if(!isServer)exitWith{};
0 spawn DOK_fnc_gaiaInit;
_this spawn {
	waitUntil {!isNil "DOK_GAIA_var_ZONES_INIT"};
	params ["_obj",["_respawn",0]];

	private ["_units","_zone"];
	_units = [_obj];

	if(_obj isKindOf "Logic") then {
		_units = synchronizedObjects _obj;
		deleteVehicle _obj;
	};

	{
		_zone = _x call DOK_fnc_gaiaSearchZone;
		if(_zone != "NONE")then{
			format ["DOK::GAIA => add fortify group %1 in zone %2",group _x,_zone] call DOK_fnc_LOG;
			if(_respawn != 0)then{
				(group _x) setVariable ["MCC_GAIA_RESPAWN", _respawn, true];
			};
			(group _x) setVariable ["GAIA_ZONE_INTEND",[_zone, "FORTIFY"], false];
		};
	} forEach _units;
};