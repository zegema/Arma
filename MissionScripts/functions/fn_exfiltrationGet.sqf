params ["_veh","_pos"];
private ["_wp"];

DOK_EXFILTRATION_var_grpCH47 = createGroup [west,true];
(crew _veh) joinSilent DOK_EXFILTRATION_var_grpCH47;

_wp = DOK_EXFILTRATION_var_grpCH47 addWaypoint [_pos,0];
_wp setWaypointType "TR UNLOAD";
_wp setWaypointSpeed "FULL";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointStatements ["true","this lockWP true"];

publicVariable "DOK_EXFILTRATION_var_grpCH47";