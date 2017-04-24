/*
ElDoktor
Group : Renfort
Addon nécessaire : Task Force Radio.
Description : ajoute un émetteur sur objet afin de le détecter par triangularisation. Se place dans l'init de l'objet.
arg1 : objet
arg2 : fréquence
arg3 : portée
[this,1] call DOK_fnc_renfortAdd
*/
if(!isServer)exitWith{};

params ["_obj","_level"];
private ["_levelData"];

if(isNil "DOK_VAR_renforts")then{
	DOK_VAR_renforts = [];
};

if(_level + 1 > count DOK_VAR_renforts)then {
	DOK_VAR_renforts set [_level,[]];
};

_levelData = DOK_VAR_renforts select _level;

if(isNil "_levelData")then{
	DOK_VAR_renforts set [_level,[]];
};

_levelData = DOK_VAR_renforts select _level;

if(_obj isKindOf "Logic")then{
	{
		_levelData = _levelData + [_x];
		DOK_VAR_renforts set [_level,_levelData];
	} forEach synchronizedObjects _obj;
}else{
	_levelData = _levelData + [_obj];
	DOK_VAR_renforts set [_level,_levelData];
};