/*
ElDoktor
*/
if(!isServer)exitWith{};

_this spawn {
	params ["_leader"];
	private ["_transport"];
	_leader stop true;
	_transport = objNull;
	waitUntil {
		sleep 0.1;
		_transport = objNull;
		if(count (_leader nearEntities [["Air","Car","Tank"],100]) > 0)then{
			_transport = (_leader nearEntities [["Air","Car","Tank"],100]) call BIS_fnc_selectRandom;
		};
		isTouchingGround _transport;
	};
	{
		_x assignAsCargo _transport;
		[_x] orderGetIn true;
	} forEach units group _leader;
	waitUntil {sleep 0.1;!(isTouchingGround _transport)};
	waitUntil {sleep 0.1;isTouchingGround _transport};
	{
		unassignVehicle _x;
	} forEach units group _leader;
	_leader stop false;
};