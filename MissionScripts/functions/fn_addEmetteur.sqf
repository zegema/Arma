/*
ElDoktor
Group : Emetteur
Addon nécessaire : Task Force Radio.
Description : ajoute un émetteur sur objet afin de le détecter par triangularisation. Se place dans l'init de l'objet.
arg1 : objet
arg2 : fréquence
arg3 : portée
Exemple : ajoute un emetteur sur l'objet "this" pour la fréquence 30.1 MHz et une portée de 2 Km
Syntax : [this,30.1,2000] call DOK_fnc_addEmetteur;
*/
params ["_obj","_freq","_portee"];

if(isNil "DOK_EMETTEUR_var_freq")then{
	DOK_EMETTEUR_var_freq = [];
};
if(isNil "DOK_EMETTEUR_var_obj")then{
	DOK_EMETTEUR_var_obj = [];
};

DOK_EMETTEUR_var_freq = DOK_EMETTEUR_var_freq + [str(_freq)];
DOK_EMETTEUR_var_obj = DOK_EMETTEUR_var_obj + [[_obj,str(_freq),_portee]];