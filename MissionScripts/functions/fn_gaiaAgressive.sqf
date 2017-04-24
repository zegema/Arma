/*
Author : ElDoktor
Group : GAIA
Description : ajoute l'unité en mode agressive. Se place dans l'init d'un Game Logic ou d'objet.
arg1 : objet
arg2 : nombre de respawn (o)
syntax : [this,NB_RESPAWN] call DOK_fnc_gaiaAgressive;
syntax : [this] call DOK_fnc_gaiaAgressive;
syntax : [this,5] call DOK_fnc_gaiaAgressive;
*/
if(!isServer)exitWith{};
0 spawn DOK_fnc_gaiaInit;
_this spawn {
	waitUntil {!isNil "DOK_GAIA_var_ZONES_INIT"};
	params ["_obj",["_respawn",0]];

	private ["_units","_zone"];
	_units = _obj call DOK_fnc_getUnitOrLogic;

	{
		_zone = _x call DOK_fnc_gaiaSearchZone;
		if(_zone != "NONE")then{
			format ["DOK::GAIA => add agressive group %1 in zone %2",group _x,_zone] call DOK_fnc_LOG;
			if(_respawn != 0)then{
				(group _x) setVariable ["MCC_GAIA_RESPAWN", _respawn, true];
			};
			(group _x) setVariable ["GAIA_ZONE_INTEND",[_zone, "MOVE"], false];
		};
	} forEach _units;
};