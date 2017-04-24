/*
ElDoktor
Group : Utils
Description : Surcouche de BIS_fnc_addStackedEventHandler, vérifie au préalable qu'une même stack n'existe pas, sinon la supprime.
arg1 : Nom de la stack
arg2 : Type
arg3 : Code
arg4 : Paramètres (o)
Exemple : ajoute une stack onEachFrame du nom de TEST qui ne fait rien.
Syntax : ["TEST","onEachFrame",{},[]] call DOK_fnc_addStackedEventHandler;
*/
params ["_nom","_type","_code",["_params",[]]];
[_nom, _type] call DOK_fnc_removeStackedEventHandler;
[_nom, _type, _code, _params] call BIS_fnc_addStackedEventHandler;