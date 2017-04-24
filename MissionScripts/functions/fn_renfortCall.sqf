/*
ElDoktor
[_unit,1] call DOK_fnc_renfortCall
[thisTrigger,3]  call DOK_fnc_renfortCall
*/
if(!isServer)exitWith{};
if(count (DOK_VAR_renforts select _level) == 0)exitWith{};
if(isNil "DOK_FNC_checkInArea")then{
	DOK_FNC_checkInArea = {
		private ["_return"];
		_return = false;
		if(isNil "DOK_VAR_renfortAreas")then{
			DOK_VAR_renfortAreas = [];
		}else{
			{
				if(_this inArea [_x, 350, 350, 0, false])then{
					_return = true;
				};
			}forEach DOK_VAR_renfortAreas;
		};
		if(!_return)then{
			DOK_VAR_renfortAreas = DOK_VAR_renfortAreas + [(getPos _this)];
		};
		_return
	};
};

if(isNil "DOK_FNC_nearestRenfort")then{
	DOK_FNC_nearestRenfort = {
		params ["_unit","_renforts"];
		private ["_renfort","_dist"];
		_renfort = [];
		_dist = 99999;
		{
			if(_unit distance _x < _dist && alive _x)then{
				_dist = _unit distance _x;
				_renfort = _x;
			};
		} forEach _renforts;
		_renfort
	};
};

_this spawn {
	params ["_unit","_level"];
	private ["_checkInArea"];
	if(_unit isKindOf "EmptyDetector")then{
		private ["_renfort","_levelData"];
		_levelData = DOK_VAR_renforts select _level;
		_renfort = [_unit,_levelData] call DOK_FNC_nearestRenfort;
		_levelData = _levelData - [_renfort];
		DOK_VAR_renforts set [_level,_levelData];
		[(group _renfort),getPos _unit] call BIS_fnc_taskAttack;
	}else{
		if((_level == 0 && !(_unit call DOK_FNC_checkInArea)) || (_level > 0 && _unit == leader _unit))then {
			private ["_renfort","_levelData"];
			_levelData = DOK_VAR_renforts select _level;
			_renfort = [_unit,_levelData] call DOK_FNC_nearestRenfort;
			_levelData = _levelData - [_renfort];
			DOK_VAR_renforts set [_level,_levelData];
			(units _renfort) joinSilent (group _unit);
		};
	};
};