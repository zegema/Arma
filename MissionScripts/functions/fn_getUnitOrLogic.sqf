/*
ElDoktor
Vérifie si on a un objet Logic ou une unité. Si Logic, on retourne la liste des objets synchronisés.
*/
private ["_units"];
_units = [_this];

if(_this isKindOf "Logic") then {
	_units = synchronizedObjects _this;
	deleteVehicle _this;
};

_units