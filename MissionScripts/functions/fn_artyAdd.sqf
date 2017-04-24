/*
ElDoktor
this call DOK_fnc_artyAdd;
*/
if(!isServer)exitWith{};
if(isNil "DOK_VAR_arty")then {
	DOK_VAR_arty = [];
};
DOK_VAR_arty = DOK_VAR_arty + [_this];
