--[[

--------------| ABOUT RANKS |--------------

RANK	| DEFAULT NAME	| COMMANDS	| EXTRA DETAILS
-------------------------------------------------------------------------------------------------------------------
5		| Owner			| All		| Is automtically set. The Owner has full access to commands and features.
-------------------------------------------------------------------------------------------------------------------
4 		| HeadAdmin		| 1,2,3,4	| 
3 		| Admin			| 1,2,3		| 
2		| Mod			| 1,2		| Can only use commands on one person at a time. 
1 		| VIP			| 1			| Can only use commands on theirself.
-------------------------------------------------------------------------------------------------------------------
0		| NonAdmin		| 0			| The default rank. Players are limited to basic features.




--------------| SETUP RANKS |--------------																															 ]]
return {

	-- RANK, RANK NAMES & SPECIFIC USERS
	Ranks = {
		{ 5, "Owner" },
		{ 4, "Administrator", { "", 0 } },
		{ 3, "Developer", { "", 0 } },
		{ 2, "Moderator", { "", 0 } },
		{ 1, "VIP", { "", 0 } },
		{ 0, "None" },
	},

	-- GAMEPASSES
	Gamepasses = {
		[0] = "VIP",
	},

	-- ASSETS
	Assets = {
		[0] = "VIP",
	},

	-- GROUPS
	Groups = {
		[4973811] = {
			[255] = "Owner",
			[254] = "Administrator",
			[253] = "Developer",
			[252] = "Moderator",
			[251] = "VIP",
		},
	},

	-- FRIENDS
	Friends = "None",

	-- VIP SERVER OWNER
	VipServerOwner = "Moderator",

	-- FREE ADMIN
	FreeAdmin = "None",

	--------------| BANLAND |--------------
	Banned = { "", 0 },

	--------------| SYSTEM SETTINGS |--------------
	Prefix = "/", -- The character you use before every command (e.g. ';jump me').
	SplitKey = " ", -- The character inbetween command arguments (e.g. setting it to '/' would change ';jump me' to ';jump/me').
	BatchKey = "", -- The character inbetween batch commands (e.g. setting it to '|' would change ';jump me ;fire me ;smoke me' to ';jump me | ;fire me | ;smoke me'
	QualifierBatchKey = ",", -- The character used to split up qualifiers (e.g. ;jump player1,player2,player3)

	Theme = "Black", -- The default UI theme.
	NoticeSoundId = 2865227271, -- The SoundId for notices.
	NoticeVolume = 0.1, -- The Volume for notices.
	NoticePitch = 1, -- The Pitch/PlaybackSpeed for notices.
	ErrorSoundId = 2865228021, -- The SoundId for error notifications.
	ErrorVolume = 0.1, -- The Volume for error notifications.
	ErrorPitch = 1, -- The Pitch/PlaybackSpeed for error notifications.
	AlertSoundId = 3140355872, -- The SoundId for alerts.
	AlertVolume = 0.5, -- The Volume for alerts.
	AlertPitch = 1, -- The Pitch/PlaybackSpeed for alerts.

	WelcomeBadgeId = 2124750786, -- Award new players a badge, such as 'Welcome to the game!'. Set to 0 for no badge.

	CommandDebounce = true, -- Wait until the command effect is over to use again. Helps to limit abuse & lag. Set to 'false' to disable.
	SaveRank = true, -- Saves a player's rank in the server they received it. (e.g. ;rank plrName rank). Use ';permRank plrName rank' to permanently save a rank. Set to 'false' to disable.
	LoopCommands = 3, -- The minimum rank required to use LoopCommands.
	MusicList = { 505757009 }, -- Songs which automatically appear in a user's radio. Type '!radio' to display the radio.

	ThemeColors = { -- The colours players can set their HD Admin UI (in the 'Settings' menu). | Format: {ThemeName, ThemeColor3Value};
		{ "Red", Color3.fromRGB(150, 0, 0) },
		{ "Orange", Color3.fromRGB(150, 75, 0) },
		{ "Brown", Color3.fromRGB(120, 80, 30) },
		{ "Yellow", Color3.fromRGB(130, 120, 0) },
		{ "Green", Color3.fromRGB(0, 120, 0) },
		{ "Blue", Color3.fromRGB(0, 100, 150) },
		{ "Purple", Color3.fromRGB(100, 0, 150) },
		{ "Pink", Color3.fromRGB(150, 0, 100) },
		{ "Black", Color3.fromRGB(60, 60, 60) },
	},

	Colors = { -- The colours for ChatColors and command arguments. | Format: {"ShortName", "FullName", Color3Value};
		{ "r", "Red", Color3.fromRGB(255, 0, 0) },
		{ "o", "Orange", Color3.fromRGB(250, 100, 0) },
		{ "y", "Yellow", Color3.fromRGB(255, 255, 0) },
		{ "g", "Green", Color3.fromRGB(0, 255, 0) },
		{ "dg", "DarkGreen", Color3.fromRGB(0, 125, 0) },
		{ "b", "Blue", Color3.fromRGB(0, 255, 255) },
		{ "db", "DarkBlue", Color3.fromRGB(0, 50, 255) },
		{ "p", "Purple", Color3.fromRGB(150, 0, 255) },
		{ "pk", "Pink", Color3.fromRGB(255, 85, 185) },
		{ "bk", "Black", Color3.fromRGB(0, 0, 0) },
		{ "w", "White", Color3.fromRGB(255, 255, 255) },
	},
	ChatColors = { -- The colour a player's chat will appear depending on their rank. '["Owner"] = "Yellow";' makes the owner's chat yellow.
	},

	Cmdbar = 2, -- The minimum rank required to use the Cmdbar.
	Cmdbar2 = 2, -- The minimum rank required to use the Cmdbar2.
	ViewBanland = 2, -- The minimum rank required to view the banland.
	OnlyShowUsableCommands = true, -- Only display commands equal to or below the user's rank on the Commands page.
	RankRequiredToViewPage = { -- || The pages on the main menu ||
		["Commands"] = 2,
		["Admin"] = 2,
		["Settings"] = 2,
	},
	RankRequiredToViewRank = { -- || The rank categories on the 'Ranks' subPage under Admin ||
		["Owner"] = 2,
		["Administrator"] = 2,
		["Developer"] = 2,
		["Moderator"] = 2,
		["VIP"] = 2,
	},
	RankRequiredToViewRankType = { -- || The collection of loader-rank-rewarders on the 'Ranks' subPage under Admin ||
		["Owner"] = 0,
		["SpecificUsers"] = 0,
		["Gamepasses"] = 0,
		["Assets"] = 0,
		["Groups"] = 0,
		["Friends"] = 0,
		["FreeAdmin"] = 0,
		["VipServerOwner"] = 0,
	},
	RankRequiredToViewIcon = 2,

	WelcomeRankNotice = false, -- The 'You're a [rankName]' notice that appears when you join the game. Set to false to disable.
	WelcomeDonorNotice = false, -- The 'You're a Donor' notice that appears when you join the game. Set to false to disable.
	WarnIncorrectPrefix = false, -- Warn the user if using the wrong prefix | "Invalid prefix! Try using [correctPrefix][commandName] instead!"
	DisableAllNotices = true, -- Set to true to disable all HD Admin notices.

	ScaleLimit = 4, -- The maximum size players with a rank lower than 'IgnoreScaleLimit' can scale theirself. For example, players will be limited to ;size me 4 (if limit is 4) - any number above is blocked.
	IgnoreScaleLimit = 3, -- Any ranks equal or above this value will ignore 'ScaleLimit'
	CommandLimits = { -- Enables you to set limits for commands which have a number argument. Ranks equal to or higher than 'IgnoreLimit' will not be affected by Limit.
		["fly"] = {
			Limit = 10000,
			IgnoreLimit = 3,
		},
		["fly2"] = {
			Limit = 10000,
			IgnoreLimit = 3,
		},
		["noclip"] = {
			Limit = 10000,
			IgnoreLimit = 3,
		},
		["noclip2"] = {
			Limit = 10000,
			IgnoreLimit = 3,
		},
		["speed"] = {
			Limit = 10000,
			IgnoreLimit = 3,
		},
		["jumpPower"] = {
			Limit = 10000,
			IgnoreLimit = 3,
		},
	},

	VIPServerCommandBlacklist = { "permRank", "permBan", "globalAnnouncement" }, -- Commands players are probihited from using in VIP Servers.
	GearBlacklist = { 67798397 }, -- The IDs of gear items to block when using the ;gear command.
	IgnoreGearBlacklist = 4, -- The minimum rank required to ignore the gear blacklist.

	PlayerDataStoreVersion = "V1.0", -- Data about the player (i.e. permRanks, custom settings, etc). Changing the Version name will reset all PlayerData.
	SystemDataStoreVersion = "V1.0", -- Data about the game (i.e. the banland, universal message system, etc). Changing the Version name will reset all SystemData.

	CoreNotices = { -- Modify core notices. You can find a table of all CoreNotices under [MainModule > Client > SharedModules > CoreNotices]
		--NoticeName = NoticeDetails;
	},

	--------------| MODIFY COMMANDS |--------------
	SetCommandRankByName = {
		--["jump"] = "VIP";
	},
	SetCommandRankByTag = {
		--["abusive"] = "Admin";
	},
}
