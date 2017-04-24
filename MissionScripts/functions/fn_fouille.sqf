/*
ElDoktor
[this,"De nouvelles informations sur la carte ...",["Point_A","Point_B"]] call DOK_fnc_fouille;
[this,"Vous n'avez trouvé aucune information.",[]] call DOK_fnc_fouille;
*/
if(isDedicated)exitWith{};

params["_unit","_msg","_markers"];

_unit setVariable ["DOK_VAR_fouille_data",_this];

{_x setMarkerAlpha 0;}forEach _markers;

[
	_unit,
	"Fouiller le corps",
	"A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",
	"A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",
	"_target getVariable ['DOK_VAR_fouille_fouillé',true]",
	"true",
	{},
	{},
	{
		private ["_data","_unit","_msg","_markers"];
		_data = (_this select 0) getVariable ["DOK_VAR_fouille_data",[]];
		_unit = _data select 0;
		_msg = _data select 1;
		_markers = _data select 2;
		[_unit,_this select 2] remoteExec ["BIS_fnc_holdActionRemove",0];
		_unit setVariable ["DOK_VAR_fouille_fouillé",false,true];
		{_x setMarkerAlpha 1;}forEach _markers;
		_msg remoteExec ["hint", 0];
	}
] call BIS_fnc_holdActionAdd;