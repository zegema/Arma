/*
ElDoktor
Group : Utils
Description : Surcouche de BIS_fnc_removeStackedEventHandler, vérifie au préalable qu'une même stack existe avant de la supprimer.
arg1 : Nom de la stack
arg2 : Type
Exemple : retire une stack onEachFrame du nom de TEST si elle existe.
Syntax : ["TEST","onEachFrame"] call DOK_fnc_removeStackedEventHandler;
*/
params ["_nom","_type"];
private ["_types"];
_types = format ["BIS_stackedEventHandlers_%1",_type];
{
	if(_nom == _x select 0)then{
		[_nom, _type] call BIS_fnc_removeStackedEventHandler;
	};
} forEach (missionNamespace getVariable [_types,[]]);