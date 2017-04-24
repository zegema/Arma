/*
ElDoktor
Exemple : [this,"BEGINSB_1",["control_1","control_2","control_3"]] call DOK_fnc_strikeBack
*/
if(!(!hasInterface && !isDedicated))exitWith{};
if!((_this select 0) isKindOf "Logic")exitWith{};
_this spawn {
	params ["_obj","_var","_speed","_markers"];
	private ["_pos","_grp","_wp"];
	{
		_x setMarkerAlpha 0;
	} forEach _markers;
	waitUntil{sleep 1;!isNil _var};
	{
		_grp = group _x;
		{
			_x forceSpeed _speed;
		}forEach (units _grp);
		{
			_pos = getMarkerPos _x;
			_grp setCombatMode "RED";
			_grp setBehaviour "Safe";
			_wp = _grp addWaypoint [_pos, 5];
			if(_forEachIndex == 0)then {
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true", "(group this) setBehaviour 'Danger'"];
			}else{
				_wp setWaypointType "SAD";
				_wp setWaypointBehaviour "COMBAT";
			};
		} forEach _markers;
	}forEach synchronizedObjects _obj;
};