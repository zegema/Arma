/*
Author : ElDoktor
Group : GAIA
Recherche le marker où se trouve l'unité
unit call DOK_fnc_gaiaSearchZone;
*/
private ["_mutex_zones","_zone","_size"];
_mutex_zones=[];
_zone = "NONE";
_size = 99999;

{
	if(count((getPos _this) inAreaArray _x) > 0)then{
		_mutex_zones = _mutex_zones + [_x];
	};
}foreach DOK_GAIA_var_ZONES;

//Aucune zone trouvée : on recherche la zone la plus proche
if(count _mutex_zones == 0)then{
	_size = 99999;
	{
		if(_this distance (getMarkerPos _x) < _size)then{
			_size = _this distance (getMarkerPos _x);
			_zone = _x;
		};
	}foreach DOK_GAIA_var_ZONES;
};

//Une zone trouvée : on prend la zone
if(count _mutex_zones == 1)then{
	_zone = _mutex_zones select 0;
};

//Plusieurs zone trouvées : on prend la plus petite
if(count _mutex_zones > 1)then{
	_size = 99999;
	{
		if(markerSize _x < _size)then{
			_size = markerSize _x;
			_zone = _x;
		};
	}foreach _mutex_zones;
};

_zone