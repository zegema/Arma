/*
ElDoktor
_pos call DOK_fnc_artyFire;
*/
if(!isServer)exitWith{};
_this spawn {
	params ["_markerTxt","_markerPos","_markerName"];
	private ["_arty"];
	if(count DOK_VAR_arty > 0)then{
		_arty = DOK_VAR_arty call BIS_fnc_selectRandom;
		DOK_VAR_arty = DOK_VAR_arty - [_arty];
		_arty doArtilleryFire [_markerPos, "32Rnd_155mm_Mo_shells", 10];
		(format["Arty : la cible %1 est en cours d'acquisition ...",_markerTxt]) remoteExec ["systemChat", 0];
		sleep 1;
		_arty call DOK_fnc_artyAdd;
		_markerName remoteExec ["deleteMarker",0];

	};
};