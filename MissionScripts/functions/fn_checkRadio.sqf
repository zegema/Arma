/*
ElDoktor
Group : Emetteur
Description : Balaye la fréquence de la radio longue portée pour afficher l'info si les conditions sont remplies. Se place dans l'init.sqf.
Exemple : ajout de la fonction dans l'init du joueur en cours
Syntax : 0 spawn DOK_fnc_checkRadio
*/
if(isDedicated)exitWith{};

["DOK_EMETTEUR_CHECKRADIO","onEachFrame",{
	if(isNil "DOK_EMETTEUR_var_ELAPSETIME")then{
		DOK_EMETTEUR_var_ELAPSETIME = 60;
	};
	if(isNil "DOK_EMETTEUR_var_TRANSMITTIME")then{
		DOK_EMETTEUR_var_TRANSMITTIME = 8;
	};

	if(((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency in DOK_EMETTEUR_var_freq) && time%DOK_EMETTEUR_var_ELAPSETIME < DOK_EMETTEUR_var_TRANSMITTIME)then{
		{
			if(_x select 1 == (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency && player distance (_x select 0) < (_x select 2) && alive (_x select 0)) then {
				hintSilent format ["Signal au %1°",player getRelDir (_x select 0)];
			};
		} forEach DOK_EMETTEUR_var_obj;
	};
}] call DOK_fnc_addStackedEventHandler;