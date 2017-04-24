/*
Author : ElDoktor
Group : GAIA
Initialisation du module GAIA si utilisé avec les autres commandes.
*/

// We set the markers invisible (if you use more then 100 markers, then increase). Or delete if you want them visible
DOK_GAIA_var_ZONES = [];
{
	if(["GAIA_", _x,true] call BIS_fnc_inString)then{
		_x setMarkerAlpha 0;
		DOK_GAIA_var_ZONES = DOK_GAIA_var_ZONES + [_x];
	};
}foreach allMapMarkers;

if(!isServer)exitWith{DOK_GAIA_var_ZONES = nil;};

sleep random 3;
if(!isNil "DOK_GAIA_var_ZONES_INIT_START")exitWith{};
DOK_GAIA_var_ZONES_INIT_START = true;

// Chang the following numbers to your liking
if (isServer) then {
	// From what range away from closest player should units be cached (in meters or what every metric system arma uses)?
	// To test this set it to 20 meters. Then make sure you get that close and move away.
	// You will notice 2 levels of caching 1 all but leader, 2 completely away
	// Stage 2 is 2 x GAIA_CACHE_STAGE_1. So default 2000, namely 2 x 1000
	GAIA_CACHE_STAGE_1				= 1000;

	// The follow 3 influence how close troops should be to known conflict to be used. (so they wont travel all the map to support)
	// How far should footmobiles be called in to support attacks.
	// This is also the range that is used by the transport system. If futher then the below setting from a zone, they can get transport.
	MCC_GAIA_MAX_SLOW_SPEED_RANGE	= 3000;

	// How far should vehicles be called in to support attacks. (including boats)
	MCC_GAIA_MAX_MEDIUM_SPEED_RANGE	= 4500;

	// How far should air units be called in to support attacks.
	MCC_GAIA_MAX_FAST_SPEED_RANGE	= 80000;

	// How logn should mortars and artillery wait (in seconds) between fire support missions.
	MCC_GAIA_MORTAR_TIMEOUT			= 300;

	// DANGEROUS SETTING!!!
	// If set to TRUE gaia will even send units that she does NOT control into attacks. Be aware ONLy for attacks.
	// They will not suddenly patrol if set to true.
	MCC_GAIA_ATTACKS_FOR_NONGAIA	= false;

	// If set to false, ai will not use smoke and flares (during night)
	MCC_GAIA_AMBIANT				= true;

	// Influence how high the chance is (when applicaple) that units do smokes and flare (so not robotic style)
	// Default is 20 that is a chance of 1 out of 20 when they are applicable to use smokes and flares
	MCC_GAIA_AMBIANT_CHANCE			= 20;

	// The seconds of rest a transporter takes after STARTING his last order
	MCC_GAIA_TRANSPORT_RESTTIME		= 40;

	DOK_GAIA_var_ZONES_INIT = true;
	format ["DOK::GAIA : zones found : %1",DOK_GAIA_var_ZONES] call DOK_fnc_LOG;
	format ["DOK::GAIA : init zones (%1) [OK]",count DOK_GAIA_var_ZONES] call DOK_fnc_LOG;
};

//DO NOT CHANGE FROM BELOW (You can, but you will be out of support :P )

//----------------------gaia------------------------------------------------------
if (isserver) then {call compile preprocessfile "gaia\gaia_init.sqf";};


//===============Delete Groups ====================
if (isServer ) then {
	[] spawn {
		private ["_gaia_respawn"];
		_gaia_respawn = [];
		while {true} do	{
			//player globalchat "Deleting started..............";
			{
				_gaia_respawn = (missionNamespace getVariable [ "GAIA_RESPAWN_" + str(_x),[] ]);
				//Store ALL original group setups
				if (count(_gaia_respawn)==0) then {[(_x)] call fn_cache_original_group;};

				if ((({alive _x} count units _x) == 0) ) then {
					//Before we send him to heaven check if he should be reincarnated
					if (count(_gaia_respawn)==2) then {
						[
							_gaia_respawn,
							(_x getVariable  ["MCC_GAIA_RESPAWN",-1]),
							(_x getVariable  ["MCC_GAIA_CACHE",false]),
							(_x getVariable  ["GAIA_zone_intend",[]])
						] call fn_uncache_original_group;};
					//Remove the respawn group content before the group is re-used
					missionNamespace setVariable ["GAIA_RESPAWN_" + str(_x), nil];
					deleteGroup _x;
				};
				sleep .1;
			}foreach allGroups;
			sleep 2;
		};
	};
};
