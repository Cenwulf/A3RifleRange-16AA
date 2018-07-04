isHC = (!hasInterface && !isDedicated);
if (!isMultiplayer) then {
	isHC = isServer;
};
isHC = isServer;

if ((!isDedicated) && (player != player)) then {
  waitUntil {player == player};
};

if (isServer || isDedicated) then { {[_x, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes;} forEach allCurators; }; //Zeus vision modes

//=====Initialise Required Scripts=====
/* if (isServer) then {call { private _respawnPosition = getMarkerPos "respawn_west"; _respawnPosition set [2, (_respawnPosition select 2) + 58]; "respawn_west" setMarkerPos _respawnPosition;}}; */

/* 0 = [] spawn compile preprocessFileLineNumbers "scripts\damage.sqf"; // Blow stuff up */

// initiate Scott's rifle range (if included)
[] spawn RR_fnc_initCommon; // initialise common variable for rifle range script

if (isServer && !isNil "RR_fnc_initRifleRange") then {
	["ETR2",["LMG","ETR"],8,3,"AAC Airfield LMG ETR","An 8 lane electric target range (ETR) with targets placed at 100, 200, 300 and 400 meters. Three firing positions placed at 50, 100 and 200 meters distance from the first row of targets. Each set of targets consists of three fig. 11 that can be operated independantly or as one. This range is suitable for a wide array of weapon systems and drills including machineguns, infantry rifles and marksman rifles.",nil,true,getMarkerPos "ETR_Marker_0"] spawn RR_fnc_initRifleRange; // call this as many times as you want for each individual rifle range on the map
};

//ACRE Setup START
//Setup ACRE split radios and babel
[true, true] call acre_api_fnc_setupMission;

//Setup radios

//Setup Babel
["Initialising Babel - Please wait.", false, 60, 0] call ace_common_fnc_displayText;

//Defining the Babel languages
["en","English"] call acre_api_fnc_babelAddLanguageType;
["da","Dari"] call acre_api_fnc_babelAddLanguageType;

//ACRE Setup END

if ((isDedicated || isHC) && isMultiplayer) exitwith{}; /* no need to continue on HC or Dedicated Server */
0 = [] spawn compile preprocessFileLineNumbers "scripts\jipZeus.sqf"; //JIP Zeus issue 'fix'

player addrating 90000;	// Friendly fire safe check

waitUntil {!(isNull (findDisplay 46))};
waitUntil{!(isNil "BIS_fnc_init")};

sleep 10;
["Readiness Training", "Lemnos"] call BIS_fnc_infoText;
sleep 3;
["By 16AA.net", "16AA Milsim Unit"] call BIS_fnc_infotext;
sleep 3;
[name player, "Get the job done"] call BIS_fnc_infoText;	// personalises text to each player

//Setup Babel languages for each faction - Has to run late for some reason.
switch (side player) do {
	case west: {
		if (player getvariable ["isTranslator", false]) then {
		["Babel has Initialised. - You're a translator!", false, 10, 1] call ace_common_fnc_displayText;
		["en", "da"] call acre_api_fnc_babelSetSpokenLanguages;
		["en", "da"] call acre_api_fnc_babelSetSpeakingLanguage;
		}
		else {
		["Babel has Initialised.", false, 10, 1] call ace_common_fnc_displayText;
		["en"] call acre_api_fnc_babelSetSpokenLanguages;
		["en"] call acre_api_fnc_babelSetSpeakingLanguage;
		};
	};
	case east: {
		["Babel has Initialised.", false, 10, 1] call ace_common_fnc_displayText;
		["da"] call acre_api_fnc_babelSetSpokenLanguages;
		["da"] call acre_api_fnc_babelSetSpeakingLanguage;
	};
		case resistance: {
		["Babel has Initialised.", false, 10, 1] call ace_common_fnc_displayText;
		["da"] call acre_api_fnc_babelSetSpokenLanguages;
		["da"] call acre_api_fnc_babelSetSpeakingLanguage;
	};
	case civilian: {
		["Babel has Initialised.", false, 10, 1] call ace_common_fnc_displayText;
		["da"] call acre_api_fnc_babelSetSpokenLanguages;
		["da"] call acre_api_fnc_babelSetSpeakingLanguage;
	};
};