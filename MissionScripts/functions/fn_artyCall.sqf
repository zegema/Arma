/*
ElDoktor
call DOK_fnc_artyCall;
*/
0 spawn {
	{
		if(["T_",markerText _x] call BIS_fnc_inString)then{
			[markerText _x,getMarkerPos _x,_x] remoteExec ["DOK_fnc_artyFire",2];
		};
	}forEach allMapMarkers;
};