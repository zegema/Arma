/*
ElDoktor
[this,300] call DOK_fnc_fortifiedAdd;
*/
if(!isServer)exitWith{};
params ["_obj","_radius"];
if(_obj isKindOf "Logic") then {
	{
		private ["_buildings","_buildingsPos","_pos"];
		_pos = [];
		_buildings = nearestObjects [_x, ["House", "Building"], _radius];
		_buildingsPos = [];
		{
			_buildingsPos = _buildingsPos + ([_x] call BIS_fnc_buildingPositions);
		}forEach _buildings;
		{
			_pos = _buildingsPos call BIS_fnc_selectRandom;
			if(!isNil "_pos") then {
				_buildingsPos = _buildingsPos - [_pos];
				_x setPos _pos;
				_x forceSpeed 0;
			};
		}forEach (units group _x);
	} forEach synchronizedObjects _obj;
}else{
	private ["_buildings","_buildingsPos","_pos"];
	_pos = [];
	_buildings = nearestObjects [_obj, ["House", "Building"], _radius];
	_buildingsPos = [];
	{
		_buildingsPos = _buildingsPos + ([_x] call BIS_fnc_buildingPositions);
	}forEach _buildings;
	{
		_pos = _buildingsPos call BIS_fnc_selectRandom;
		if(!isNil "_pos") then {
			_buildingsPos = _buildingsPos - [_pos];
			_x setPos _pos;
			_x forceSpeed 0;
		};
	}forEach (units group _obj);
};