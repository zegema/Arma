/*
Author : ElDoktor
Group : IA
Description : déplace des unités en patrouille. Se place dans l'init d'un Game Logic ou d'une unité.
arg1 : objet
arg2 : rayon d'action pour l'infanterie
arg3 : rayon d'action pour les véhicules
Exemple : fait patrouiller les infanteries dans un rayon de 300 m et les véhicules dans un rayon de 2000 m.
Syntax : [this,300,2000] call DOK_fnc_patroldAdd;
*/
if(!isServer)exitWith{};
_this spawn {
	params ["_obj","_unitRadius","_vehRadius"];
	private ["_unit","_units"];

	_units = _obj call DOK_fnc_getUnitOrLogic;

	{
		_unit = leader _x;
		if(_unit == vehicle _unit) then {
			[group _unit, getPos _unit, _unitRadius] call BIS_fnc_taskPatrol;
			(group _unit) setBehaviour "Danger";
		}else{
			private ["_roads","_farRoad","_farRoad2","_wp"];
			_roads = _unit nearRoads _vehRadius;
			_farRoad = _roads select (count(_roads)-1);
			_dist = 0;
			{
				if(_farRoad distance _x > _dist)then{
					_dist = _farRoad distance _x;
					_farRoad2 = _x;
				};
			}forEach _roads;
			_wp = (group _unit) addWaypoint [getPos _farRoad,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointBehaviour "SAFE";

			_wp = (group _unit) addWaypoint [getPos _farRoad2,0];
			_wp setWaypointType "CYCLE";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointBehaviour "SAFE";
		};
	} forEach _units;

};