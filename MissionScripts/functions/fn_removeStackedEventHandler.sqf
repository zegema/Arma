params ["_nom","_type"];
private ["_types"];
_types = format ["BIS_stackedEventHandlers_%1",_type];
{
	if(_nom == _x select 0)then{
		[_nom, _type] call BIS_fnc_removeStackedEventHandler;
	};
} forEach (missionNamespace getVariable [_types,[]]);