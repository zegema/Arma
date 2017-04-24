params ["_coords"];

if(isNil "_coords")then{
	private ["_found"];
	_found = false;

	if(isNil "DOK_EXFILTRATION_var")then{
		DOK_EXFILTRATION_var = _found;
	};

	{
		if(markerText _x == "LZXIT" && !DOK_EXFILTRATION_var)then{
			DOK_EXFILTRATION_var = true;
			(getMarkerPos _x) spawn DOK_fnc_exfiltrationCall;
		};
		if(markerText _x == "LZXIT")then{
			_found = true;
		}
	} forEach allMapMarkers;

	DOK_EXFILTRATION_var = _found;
}else{
	hint "ok";
	DOK_EXFILTRATION_serverCode = {
		if(!isServer)exitWith{};
		_this spawn {
			private ["_baseCoords","_spawnVeh","_veh","_wp","_coords","_vehCH47"];

//----------CH47
			_baseCoords = getMarkerPos "LZXITBASE";
			_spawnVeh = [_baseCoords, 0, "GOS_H_CH47", WEST] call bis_fnc_spawnvehicle;
			_vehCH47 = _spawnVeh select 0;
			DOK_EXFILTRATION_var_grpCH47 = _spawnVeh select 2;

			//Waypoint 1
			/*_wp = DOK_EXFILTRATION_var_grpCH47 addWaypoint [_this,0];
			_wp setWaypointType "TR UNLOAD";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "CARELESS";
			_wp setWaypointStatements ["true","this lockWP true"];

			//Waypoint 2
			_wp = DOK_EXFILTRATION_var_grpCH47 addWaypoint [getPos _veh,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "CARELESS";
			_wp setWaypointStatements ["true","vehicle leader this land 'LAND'"];*/

			//No voice
			{
				_x setSpeaker "NoVoice";
			}foreach units DOK_EXFILTRATION_var_grpCH47;
//----------Wildcats 1
			_coords = [(_baseCoords select 0)+250,_baseCoords select 1,_baseCoords select 2];
			_spawnVeh = [_coords, 0, "GOS_H_Wildcat_CAS", WEST] call bis_fnc_spawnvehicle;
			_veh = _spawnVeh select 0;
			DOK_EXFILTRATION_var_grpWC1 = _spawnVeh select 2;

			//Waypoint 1
			_wp = DOK_EXFILTRATION_var_grpWC1 addWaypoint [_this,0];
			_wp setWaypointType "LOITER";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "CARELESS";
			_cmdWp = format ["[%1,%2] call DOK_fnc_exfiltrationGet;this lockWP true",_vehCH47,_this];
			_wp setWaypointStatements ["true",_cmdWp];

			//Waypoint 2
			_wp = DOK_EXFILTRATION_var_grpWC1 addWaypoint [getPos _veh,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointStatements ["true","vehicle leader this land 'LAND'"];

			//No voice
			/*{
				_x setSpeaker "NoVoice";
			}foreach units DOK_EXFILTRATION_var_grpWC1;*/
//----------Wildcats 2
			_coords = [(_baseCoords select 0)-250,_baseCoords select 1,_baseCoords select 2];
			_spawnVeh = [_coords, 0, "GOS_H_Wildcat_CAS", WEST] call bis_fnc_spawnvehicle;
			_veh = _spawnVeh select 0;
			DOK_EXFILTRATION_var_grpWC2 = _spawnVeh select 2;

			//Waypoint 1
			/*_wp = DOK_EXFILTRATION_var_grpWC2 addWaypoint [_this,0];
			_wp setWaypointType "LOITER";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "CARELESS";
			_wp setWaypointStatements ["true","this lockWP true"];

			//Waypoint 2
			_wp = DOK_EXFILTRATION_var_grpWC2 addWaypoint [getPos _veh,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointStatements ["true","vehicle leader this land 'LAND'"];*/

			(units DOK_EXFILTRATION_var_grpCH47) joinSilent DOK_EXFILTRATION_var_grpWC1;
			(units DOK_EXFILTRATION_var_grpWC2) joinSilent DOK_EXFILTRATION_var_grpWC1;

			//No voice
			{
				_x setSpeaker "NoVoice";
			}foreach units DOK_EXFILTRATION_var_grpWC1;

			//publicVariable "DOK_EXFILTRATION_var_grpCH47";
			publicVariable "DOK_EXFILTRATION_var_grpWC1";
			//publicVariable "DOK_EXFILTRATION_var_grpWC2";

			(driver _vehCH47) doFollow (vehicle leader DOK_EXFILTRATION_var_grpWC1);
		};
	};
	hint format ["Foxtrot : ordre d'exfiltration reçu aux coordonnées %1",_this];
	publicVariableServer "DOK_EXFILTRATION_serverCode";
	_this remoteExec ["DOK_EXFILTRATION_serverCode", 2];
	player addAction ["[Exfiltration] GOGOGO !",{call DOK_fnc_exfiltrationExecute;},nil,1.5,false,true,"","vehicle player != player"];
};