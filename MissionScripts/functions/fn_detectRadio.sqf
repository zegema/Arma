/*
ElDoktor
["radio",60] call DOK_fnc_detectRadio
*/
DOK_VAR_transmit = false;
_this spawn {
	params ["_source","_transmitTime"];
	private ["_dist","_deg"];
	DOK_VAR_transmit = true;
	_transmitTime spawn {
		sleep _this;
		DOK_VAR_transmit = false;
	};
	while{DOK_VAR_transmit} do {
		_dist = player distance (getMarkerPos _source);
		_deg = player getRelDir (getMarkerPos _source);
		if(_deg > 180)then{
			_deg = 360 - _deg;
		};
		_deg = (180-_deg)*10/_dist;
		hintSilent format ["%1 dB",_deg];
		sleep 0.1;
	};
};