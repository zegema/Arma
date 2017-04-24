/*
Author : ElDoktor
Group : IA
Description : place les unités dans les batiments alentours. Se place dans l'init d'un Game Logic ou d'une unité.
arg1 : objet
arg2 : rayon du placement
Exemple : place les unités du groupe de l'objet this dans les batiments dans un rayon de 300 m.
Syntax : [this,300] call DOK_fnc_fortifiedAdd;
*/
if(!isServer)exitWith{};
params ["_obj","_radius"];

_units = _obj call DOK_fnc_getUnitOrLogic;

private ["_buildings","_buildingsPos","_pos"];
_pos = [];
_buildings = nearestObjects [_obj, ["House", "Building"], _radius];
_buildingsPos = [];
{
	_buildingsPos = _buildingsPos + ([_x] call BIS_fnc_buildingPositions);
}forEach _buildings;
{
	{
		_pos = _buildingsPos call BIS_fnc_selectRandom;
		if(!isNil "_pos") then {
			_buildingsPos = _buildingsPos - [_pos];
			_x setPos _pos;
			_x forceSpeed 0;
		};
	}forEach (units group _x);
}forEach _units;
