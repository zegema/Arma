/*
Author : ElDoktor
Group : Intel
Description : Permet d'ajouter une action pour fouiller un corps à la recherche d'information et révèle des markers positionnés sur la carte. Se place dans l'init de l'objet.
arg1 : objet
arg2 : texte à afficher lors de la fouille
arg3 : liste des markers à révéler après la fouille.
arg4 : Afficher l'information à tous les joueurs. Non par défaut. (o)
Exemple : Ajoute la fouille sur l'objet this et lorsque l'on fouille,
Syntax : [this,"De nouvelles informations sur la carte ...",["Point_A","Point_B"]] call DOK_fnc_fouille;
Syntax : [this,"Vous n'avez trouvé aucune information.",[]] call DOK_fnc_fouille;
Syntax : [this,"Vous n'avez trouvé aucune information.",[],true] call DOK_fnc_fouille;
*/
if(isDedicated)exitWith{};

params["_unit","_msg","_markers",["_displayAll",false]];

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
		if(_displayAll)then{
			_msg remoteExec ["hint", 0];
		}else{
			hint _msg;
		};
	}
] call BIS_fnc_holdActionAdd;