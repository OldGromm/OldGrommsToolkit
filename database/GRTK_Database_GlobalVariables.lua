-- Database Variables
GRTKDB_Profiles = GRTKDB_Profiles or {}
GRTKDB_MinimapButton = GRTKDB_MinimapButton or {}
GRTKDB_EditMode = GRTKDB_EditMode or {}
GRTKDB_Cache = GRTKDB_Cache or {}
GRTKDB_Options = {}



-- Initialization
GRTK_ExpansionLevel = 0
GRTK_Compartment_Enable = false
GRTK_InstanceList = {}
GRTK_InstanceData = {}
GRTK_PlayerDataError = false
GRTK_SetupComplete = false




-- Variables
GRTK_Variables_Categories = { "General", "SpecChange", "RepairMessage", "Sounds", "Mounts", "Hearthstone" }
GRTK_Variables_NonStandardEntries = { "ChoiceCurrent", "ChoiceOverride", "OrderType", "ListOrder_Random", "ListOrder_Sequential", "ListOrder_NoRepeats" }
GRTK_Variables_UseTempProfileName = false




-- Language
GRTK_UserLanguage_SupportedLanguage = { "enUS", "deDE" }
GRTK_UserLanguage_Full = { "English", "German (Deutsch)" }
GRTK_UserLanguage_Default = 1




-- Library Add-ons
GRTK_LibDBIcon = LibStub("LibDBIcon-1.0")
GRTK_LibEditMode = LibStub("LibEditMode")




-- Player Stats
GRTK_PlayerStats_PlayerID = {}
GRTK_PlayerStats_CurrentPlayer = {}
GRTK_PlayerStats_CurrentClass = {}
GRTK_PlayerStats_CurrentClassName = {}
GRTK_PlayerStats_CurrentRace = {}
GRTK_PlayerStats_CurrentFaction = {}
GRTK_PlayerStats_CurrentFactionNumber = {}
GRTK_PlayerStats_CurrentRegion = {}
GRTK_PlayerStats_IsUnderwater = false




-- Spec Change
GRTK_SpecChange_ChoiceOne = 0
GRTK_SpecChange_ChoiceTwo = 0
GRTK_SpecChange_ChoicesTotal = 0

GRTK_SpecChange_List = { {1, 2}, {1, 3}, {2, 3}, {4, 1}, {4, 2}, {4, 3} }

GRTK_SpecChange_Icons = {}
GRTK_SpecChange_Icons[1] = { 132355, 132347, 132341 } -- Warrior
GRTK_SpecChange_Icons[2] = { 135920, 236264, 535595 } -- Paladin
GRTK_SpecChange_Icons[3] = { 461112, 236179, 461113 } -- Hunter
GRTK_SpecChange_Icons[4] = { 236270, 236286, 132320 } -- Rogue
GRTK_SpecChange_Icons[5] = { 135940, 237542, 136207 } -- Priest
GRTK_SpecChange_Icons[6] = { 135770, 135773, 135775 } -- Death Knight
GRTK_SpecChange_Icons[7] = { 136048, 237581, 136042 } -- Shaman
GRTK_SpecChange_Icons[8] = { 135932, 135810, 135846 } -- Mage
GRTK_SpecChange_Icons[9] = { 136145, 136172, 136186 } -- Warlock
GRTK_SpecChange_Icons[10] = { 608951, 608952, 608953 } -- Monk
GRTK_SpecChange_Icons[11] = { 136096, 132115, 132276, 136041 } -- Druid
GRTK_SpecChange_Icons[12] = { 1247264, 1247265, 7455385 } -- Demon Hunter
GRTK_SpecChange_Icons[13] = { 4511811, 4511812, 5198700 } -- Evoker

GRTK_SpecChange_DefaultChoice = {2, 3, 1, 1, 3, 1, 2, 1, 1, 2, 2, 1, 1}

GRTK_SpecChange_OptionsMenu_Choice = {}
GRTK_SpecChange_Timeout = false
GRTK_SpecChange_UnlockedDevourerSpec = false





-- Repair Message
GRTK_RepairMessage_SoundEntries = { 567399, 566652, 1880888, 897841 }
GRTK_RepairMessage_OneProcessAlreadyRunning = false
GRTK_RepairMessage_Frame_ScreenMessageText = {}



-- Sounds
GRTK_SoundHandle = {}
GRTK_SoundHandle_FirstTime = false
GRTK_Sounds_ChannelList = { "Master", "Music", "SFX", "Ambience", "Dialog" }
GRTK_Sounds_Victory_Entries = { 569678, 568480, 598724, 598343, 775180, 775184, 644933, 644935, 2146576, 2146606, 2167272, 2167275, 2575918, 2564880, 2564856, 1068315, 4438809, 4438817, 4438825 }
GRTK_Sounds_Victory_RandomList_Retail = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
GRTK_Sounds_Victory_RandomList_MoP = { 1, 2, 3, 4, 5, 6, 7, 8 }
GRTK_Sounds_Victory_RandomList_Classic = { 1, 2 }




-- Mount Macro
GRTK_Mounts_MountChoice_Current = {}
GRTK_Mounts_MountChoice_Final = {}
GRTK_Mounts_MountChoice_Override = {}
GRTK_Mounts_MountType = { "Ground", "Flying", "Aquatic", "Other" }
GRTK_Mounts_OrderType = { "Random", "Sequential", "NoRepeats" }
GRTK_Mounts_MountOrderType = { "Sequence_Ground", "Sequence_Flying", "Sequence_Aquatic", "Sequence_Other" }
GRTK_Mounts_LockButtons = false
GRTK_Mounts_DropdownMenu_VendorMount = ""
GRTK_Mounts_PaladinHorseList = { 41, 84, 149, 150, 230, 230, 350, 351, 367, 368, 1225, 1568, 2233 }
GRTK_Mounts_SpecialMountList = { 280, 284, 460, 1039, 2237, 2265 }
GRTK_Mounts_SpecialMountList_Names = {}
GRTK_Mounts_SpecialMountList_Final = {}
GRTK_Mounts_SpecialMountList_PlayerHasNone = false
GRTK_Mounts_Frame_MountMenu = {}
GRTK_Mounts_Frame_MountMenu_Visibility = false
GRTK_Mounts_Timeout = false




-- Hearthstone
GRTK_Hearthstone_List = { 54452, 64488, 93672, 142542, 162973, 163045, 165669, 165670, 165802, 166746, 166747, 168907, 172179, 180290, 182773, 183716, 184353, 188952, 190196, 190237, 193588, 200630, 206195, 208704, 209035, 210455, 212337, 228940, 235016, 236687, 245970, 246565, 257736, 263489, 263933, 264367, 265100 }
GRTK_Hearthstone_Icon = {}
GRTK_Hearthstone_Icon[54452] = 236222
GRTK_Hearthstone_Icon[64488] = 458254
GRTK_Hearthstone_Icon[93672] = 255348
GRTK_Hearthstone_Icon[142542] = 1529351
GRTK_Hearthstone_Icon[162973] = 2124576
GRTK_Hearthstone_Icon[163045] = 2124575
GRTK_Hearthstone_Icon[165669] = 2491049
GRTK_Hearthstone_Icon[165670] = 2491048
GRTK_Hearthstone_Icon[165802] = 2491065
GRTK_Hearthstone_Icon[166746] = 2491064
GRTK_Hearthstone_Icon[166747] = 2491063
GRTK_Hearthstone_Icon[168907] = 2491049
GRTK_Hearthstone_Icon[172179] = 3084684
GRTK_Hearthstone_Icon[180290] = 3489827
GRTK_Hearthstone_Icon[182773] = 3716927
GRTK_Hearthstone_Icon[183716] = 3514225
GRTK_Hearthstone_Icon[184353] = 3257748
GRTK_Hearthstone_Icon[188952] = 3528303
GRTK_Hearthstone_Icon[190196] = 3950360
GRTK_Hearthstone_Icon[190237] = 3954409
GRTK_Hearthstone_Icon[193588] = 4571434
GRTK_Hearthstone_Icon[200630] = 4080564
GRTK_Hearthstone_Icon[206195] = 1708140
GRTK_Hearthstone_Icon[208704] = 5333528
GRTK_Hearthstone_Icon[209035] = 2491064
GRTK_Hearthstone_Icon[210455] = 1686574
GRTK_Hearthstone_Icon[212337] = 5524923
GRTK_Hearthstone_Icon[228940] = 5891370
GRTK_Hearthstone_Icon[235016] = 4622300
GRTK_Hearthstone_Icon[236687] = 6383489
GRTK_Hearthstone_Icon[245970] = 133469
GRTK_Hearthstone_Icon[246565] = 5852174
GRTK_Hearthstone_Icon[257736] = 135981
GRTK_Hearthstone_Icon[263489] = 1708141
GRTK_Hearthstone_Icon[263933] = 5929569
GRTK_Hearthstone_Icon[264367] = 7702758
GRTK_Hearthstone_Icon[265100] = 4914667

GRTK_Hearthstone_SpecialStoneList = { 140192, 110560 }
GRTK_Hearthstone_Missing_List = {}
GRTK_Hearthstone_Missing_Count = 0
GRTK_Hearthstone_MainChoice = 0
GRTK_Hearthstone_MessageParts = {}
GRTK_Hearthstone_Timeout = false
GRTK_Hearthstone_Cooldown = 0



-- Options Menu
GRTK_Options = {}
GRTK_Options_Category_Main, GRTK_Options_Layout_Main = {}
GRTK_Options_Category_Sub_General, GRTK_Options_Layout_Sub_General = {}
GRTK_Options_Category_Sub_SpecChange, GRTK_Options_Layout_Sub_SpecChange = {}
GRTK_Options_Category_Sub_RepairMessage, GRTK_Options_Layout_Sub_RepairMessage = {}
GRTK_Options_Category_Sub_Sounds, GRTK_Options_Layout_Sub_Sounds = {}
GRTK_Options_Category_Sub_Mounts, GRTK_Options_Layout_Sub_Mounts = {}
GRTK_Options_Category_Sub_Hearthstone, GRTK_Options_Layout_Sub_Hearthstone = {}

GRTK_Options_FullList_General = {}
GRTK_Options_FullList_SpecChange = {}
GRTK_Options_FullList_RepairMessage = {}
GRTK_Options_FullList_Sounds = {}
GRTK_Options_FullList_Mounts = {}
GRTK_Options_FullList_Hearthstone = {}

GRTK_Options_ResetInProgress = false
GRTK_Options_DefaultValues = {}
GRTK_Options_DefaultVariables = {}
GRTK_Options_Timeout = false



-- Combat Lockdown Message
GRTK_CombatLockdown_Message_Cooldown = false
GRTK_CombatLockdown_Frame_Main = {}
GRTK_CombatLockdown_Frame_Message_01 = {}
GRTK_CombatLockdown_Frame_Message_02 = {}
GRTK_CombatLockdown_Frame_Message_03 = {}
GRTK_CombatLockdown_Frame_Message_EditMode = {}
GRTK_CombatLockdown_Message_Count = 0




-- Macros
GRTK_MacroTextBody = {}




-- Edit Mode
GRTK_EditMode_FramesList_ExpansionLevel_3 = {
    { ["framename"] = "RepairMessage", ["position"] = "CENTER", ["coordinates_x"] = 0.0, ["coordinates_y"] = 100.0 },
	{ ["framename"] = "Mounts", ["position"] = "CENTER", ["coordinates_x"] = 160.0, ["coordinates_y"] = 250.0 },
	{ ["framename"] = "CombatLockdown", ["position"] = "CENTER", ["coordinates_x"] = -300.0, ["coordinates_y"] = 250.0 },
}
GRTK_EditMode_FramesList_ExpansionLevel_2 = {
    { ["framename"] = "RepairMessage", ["position"] = "CENTER", ["coordinates_x"] = 0.0, ["coordinates_y"] = 100.0 },
	{ ["framename"] = "Mounts", ["position"] = "CENTER", ["coordinates_x"] = 160.0, ["coordinates_y"] = 250.0 },
	{ ["framename"] = "CombatLockdown", ["position"] = "CENTER", ["coordinates_x"] = -300.0, ["coordinates_y"] = 250.0 },
}
GRTK_EditMode_FramesList_ExpansionLevel_1 = {
    { ["framename"] = "RepairMessage", ["position"] = "CENTER", ["coordinates_x"] = 0.0, ["coordinates_y"] = 100.0 },
	{ ["framename"] = "CombatLockdown", ["position"] = "CENTER", ["coordinates_x"] = -300.0, ["coordinates_y"] = 250.0 },
}