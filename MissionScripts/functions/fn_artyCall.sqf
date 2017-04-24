/*
ElDoktor
Group : Artillerie
Description : appel l'action pour la déclencher les feux de l'artillerie sur les positions notées sur carte et commençant par "T_"
Exemple : peut se positionner dans une addAction ou une boucle et va déclencher le feu sur le marker avec le texte "T_TARGET_BLABLABLA"
Syntax : call DOK_fnc_artyCall;
*/
0 spawn {
	{
		if(["T_",markerText _x] call BIS_fnc_inString)then{
			[markerText _x,getMarkerPos _x,_x] remoteExec ["DOK_fnc_artyFire",2];
		};
	}forEach allMapMarkers;
};