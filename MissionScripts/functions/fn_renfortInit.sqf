/*
ElDoktor
Group : Renfort
Addon nécessaire : Task Force Radio.
Description : ajoute un émetteur sur objet afin de le détecter par triangularisation. Se place dans l'init de l'objet.
arg1 : objet
arg2 : fréquence
arg3 : portée
call DOK_fnc_renfortInit
*/
if(!isServer)exitWith{};
0 spawn {
	{
		if(side _x == east)then{
			_x addEventHandler ["Fired",{[(_this select 0),0] call DOK_fnc_renfortCall}];
			_x addEventHandler ["Reloaded",{[(_this select 0),1] call DOK_fnc_renfortCall}];
		};
	}forEach (allUnits - (playableUnits + switchableUnits));
};