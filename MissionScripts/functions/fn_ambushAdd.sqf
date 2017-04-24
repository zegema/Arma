/*
ElDoktor
this call DOK_fnc_ambushAdd;
*/
if(!isServer)exitWith{};
_this spawn {
	params ["_logic"];
	private ["_grp"];
	if(_logic isKindOf "Logic") then {
		{
			_grp = group leader _x;
			_grp setCombatMode "WHITE";
			{
				_x setUnitPos "DOWN";
			}forEach units _grp;
		} forEach synchronizedObjects _logic;
	};
};

