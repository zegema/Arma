/*
ElDoktor
[this,100,2000] call DOK_fnc_patrolAdd;
*/
if(!isServer)exitWith{};
_this spawn {
	params ["_logic","_unitRadius","_vehRadius"];
	private ["_unit"];
	if(_logic isKindOf "Logic") then {
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
		} forEach synchronizedObjects _logic;
	};
};