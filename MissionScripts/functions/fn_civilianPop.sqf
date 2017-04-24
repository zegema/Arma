/*
ElDoktor
0 call DOK_fnc_civilianPop;
*/
DOK_VAR_civilianManClass = ["C_man_w_worker_F", "C_man_pilot_F", "C_man_1","C_man_1_1_F","C_man_1_2_F",
						"C_man_1_3_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
						"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_shorts_2_F","C_man_shorts_3_F",
						"C_man_p_shorts_1_F","C_man_p_beggar_F","C_man_p_fugitive_F","C_man_hunter_1_F"];

DOK_VAR_civilianVehClass = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F","C_Hatchback_01_F",
						"C_Hatchback_01_sport_F","C_Quadbike_01_F","C_Offroad_01_F","C_SUV_01_F"];

if(!isServer)exitWith{};
0 spawn {
	waitUntil{!isNil "HC_NETID"};
	private ["_grp","_pos","_roads","_buildGrp"];
	{
		if(["civil_",_x] call BIS_fnc_inString)then{
			_pos = getMarkerPos _x;
			_buildGrp = [];
			while(count _buildGrp < 10) do {
				_buildGrp = _buildGrp + [DOK_VAR_civilianManClass call BIS_fnc_selectRandom];
			};
			_grp = [getMarkerPos _x, civilian, _buildGrp,[],[],[],[],[],0] call BIS_fnc_spawnGroup;
			_grp setGroupOwner HC_NETID;
			deleteMarker _x;
			{
				[_x] joinSilent grpNull;
				[group _x, _pos, 50] call BIS_fnc_taskPatrol;
			}forEach units _grp;
			_roads = _pos nearRoads 50;
			if(count _roads > 0)then{
				_pos = getPos(_roads select 0);
			};
			_grp = ([_pos, 0, DOK_VAR_civilianVehClass call BIS_fnc_selectRandom, civilian] call BIS_fnc_spawnVehicle) select 2;
			[_grp, _pos, 2000] call BIS_fnc_taskPatrol;
		};
	}forEach allMapMarkers;
};