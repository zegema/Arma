params ["_nom","_type","_code",["_params",[]]];
[_nom, _type] call DOK_fnc_removeStackedEventHandler;
[_nom, _type, _code, _params] call BIS_fnc_addStackedEventHandler;