/*
ElDoktor
Group : Artillerie
Description : ajoute l'unité en tant qu'artillerie au mécanisme d'artillerie. Se place dans l'init de l'objet.
arg1 : objet
Exemple : ajoute l'unité "this"
Syntax : this call DOK_fnc_artyAdd;
*/
if(!isServer)exitWith{};
if(isNil "DOK_VAR_arty")then {
	DOK_VAR_arty = [];
};
DOK_VAR_arty = DOK_VAR_arty + [_this];
