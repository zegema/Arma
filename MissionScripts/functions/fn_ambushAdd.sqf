/*
Author : ElDoktor
Group : IA
Addon nécessaire : Task Force Radio.
Description : ajoute un émetteur sur objet afin de le détecter par triangularisation. Se place dans dans l'init d'un Game Logic ou d'une unité.
arg1 : objet/Logic
Exemple : positionne un groupe en embuscade : les couche au sol et les mets en mode combat "WHITE"
Syntax : this call DOK_fnc_ambushAdd;
*/
if(!isServer)exitWith{};
_this spawn {
	params ["_obj"];
	private ["_grp","_units"];

	_units = _obj call DOK_fnc_getUnitOrLogic;

	{
		_grp = group leader _x;
		_grp setCombatMode "WHITE";
		{
			_x setUnitPos "DOWN";
		}forEach units _grp;
	} forEach _units;
};

