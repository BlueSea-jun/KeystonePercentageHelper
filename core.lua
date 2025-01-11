local AddOnName, KeystonePercentageHelper = ...;
local _G = _G;
local pairs, unpack, select = pairs, unpack, select
local floor = math.floor
local format = string.format

local AceAddon = LibStub("AceAddon-3.0")
KeystonePercentageHelper = AceAddon:NewAddon(KeystonePercentageHelper, AddOnName, "AceConsole-3.0", "AceEvent-3.0");

KeystonePercentageHelper.constants = {
    mediaPath = "Interface\\AddOns\\" .. AddOnName .. "\\media\\"
}

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

KeystonePercentageHelper.LSM = LibStub('LibSharedMedia-3.0');

local success, result = pcall(function() return LibStub("AceLocale-3.0"):GetLocale(AddOnName, false) end)
local L = success and result or LibStub("AceLocale-3.0"):GetLocale(AddOnName, true, "enUS")
local options 

KeystonePercentageHelper.DUNGEONS = {}

-- List of expansions and their corresponding data
local expansions = {
    {id = "TWW", name = "EXPANSION_WW", order = 4},        -- The War Within
    --{id = "DF", name = "EXPANSION_DF", order = 5},         -- Dragonflight
    {id = "SL", name = "EXPANSION_SL", order = 6},         -- Shadowlands
    {id = "BFA", name = "EXPANSION_BFA", order = 7},       -- Battle for Azeroth
    {id = "LEGION", name = "EXPANSION_LEGION", order = 8}, -- Legion
    --{id = "WOD", name = "EXPANSION_WOD", order = 9},       -- Warlords of Draenor
    --{id = "MOP", name = "EXPANSION_MOP", order = 10},      -- Mists of Pandaria
    {id = "CATACLYSM", name = "EXPANSION_CATA", order = 11}, -- Cataclysm
    --{id = "TBC", name = "EXPANSION_TBC", order = 12} -- The Burning Crusade
    --{id = "Vanilla", name = "EXPANSION_VANILLA", order = 12} -- Vanilla WoW
}

local function LoadExpansionDungeons()
    -- Load dungeons from all expansions
    for _, expansion in ipairs(expansions) do
        local dungeons = KeystonePercentageHelper[expansion.id .. "_DUNGEONS"]
        if dungeons then
            for id, data in pairs(dungeons) do
                KeystonePercentageHelper.DUNGEONS[id] = data
            end
        end
    end
end

KeystonePercentageHelper.currentDungeonID = 0
KeystonePercentageHelper.currentSection = 1

KeystonePercentageHelper.defaults = {
    profile = {
        general = {
            fontSize = 12,
            position = "CENTER",
            xOffset = 0,
            yOffset = 0,
            informGroup = true,
            informChannel = "PARTY",
            advancedOptionsEnabled = false,
        },
        text = {
            font = "Friz Quadrata TT",
        },
        color = {
            inProgress = {r = 1, g = 1, b = 1, a = 1},
            finished = {r = 0, g = 1, b = 0, a = 1},
            missing = {r = 1, g = 0, b = 0, a = 1}
        },
        advanced = {}
    }
}

-- Load defaults from all expansions
for _, expansion in ipairs(expansions) do
    local defaults = KeystonePercentageHelper[expansion.id .. "_DEFAULTS"]
    if defaults then
        for k, v in pairs(defaults) do
            KeystonePercentageHelper.defaults.profile.advanced[k] = v
        end
    end
end

function KeystonePercentageHelper:GetAdvancedOptions()
    -- Helper function to get dungeon name with icon
    local function GetDungeonNameWithIcon(dungeonKey)
        local icon = self.dungeonIcons and self.dungeonIcons[dungeonKey] or ""
        return icon .. " " .. L[dungeonKey]
    end

    -- Helper function to format dungeon text
    local function FormatDungeonText(self, dungeonKey, defaults)
        local text = ""
        if defaults then
            text = text .. "|cffffd700" .. GetDungeonNameWithIcon(dungeonKey) .. "|r:\n"
            local bossNum = 1
            while defaults["Boss" .. self:GetBossNumberString(bossNum)] do
                local bossKey = "Boss" .. self:GetBossNumberString(bossNum)
                local informKey = bossKey .. "Inform"
                text = text .. string.format("  %s: |cff40E0D0%.2f%%|r - Inform group: %s\n",
                    L[dungeonKey .. "_BOSS" .. bossNum],
                    defaults[bossKey],
                    defaults[informKey] and '|cff00ff00Yes|r' or '|cffff0000No|r')
                bossNum = bossNum + 1
            end
            text = text .. "\n"
        end
        return text
    end

    -- Create shared dungeon options
    local sharedDungeonOptions = {}
    for _, expansion in ipairs(expansions) do
        local dungeonIds = self[expansion.id .. "_DUNGEON_IDS"]
        if dungeonIds then
            for dungeonKey, dungeonId in pairs(dungeonIds) do
                sharedDungeonOptions[dungeonKey] = self:CreateDungeonOptions(dungeonKey, 0)
            end
        end
    end

    -- Create expansion-specific dungeon args
    local function CreateExpansionDungeonArgs(dungeonIds, defaults)
        local args = {
            defaultPercentages = {
                order = 0,
                type = "description",
                fontSize = "medium",
                name = function()
                    local text = "Default percentages:\n\n"
                    for dungeonKey, _ in pairs(dungeonIds or {}) do
                        if defaults and defaults[dungeonKey] then
                            text = text .. FormatDungeonText(self, dungeonKey, defaults[dungeonKey])
                        end
                    end
                    return text
                end
            }
        }
        
        -- Add dungeon options
        if dungeonIds then
            for dungeonKey, _ in pairs(dungeonIds) do
                args[dungeonKey] = sharedDungeonOptions[dungeonKey]
            end
        end
        
        return args
    end

    -- Create current season options
    local currentSeasonDungeons = {}
    
    -- Collect all current season dungeons
    for _, expansion in ipairs(expansions) do
        local dungeonIds = self[expansion.id .. "_DUNGEON_IDS"]
        if dungeonIds then
            for dungeonKey, dungeonId in pairs(dungeonIds) do
                if self:IsCurrentSeasonDungeon(dungeonId) then
                    table.insert(currentSeasonDungeons, {key = dungeonKey, id = dungeonId})
                end
            end
        end
    end
    
    -- Sort dungeons alphabetically by their localized names
    table.sort(currentSeasonDungeons, function(a, b)
        return L[a.key] < L[b.key]
    end)

    -- Create current season dungeon args
    local dungeonArgs = {
        defaultPercentages = {
            order = 0,
            type = "description",
            fontSize = "medium",
            name = function()
                local text = "Default percentages:\n\n"
                for _, dungeon in ipairs(currentSeasonDungeons) do
                    local dungeonKey = dungeon.key
                    local defaults
                    for _, expansion in ipairs(expansions) do
                        if self[expansion.id .. "_DUNGEON_IDS"][dungeonKey] then
                            defaults = self[expansion.id .. "_DEFAULTS"][dungeonKey]
                            break
                        end
                    end
                    
                    text = text .. FormatDungeonText(self, dungeonKey, defaults)
                end
                return text
            end
        }
    }
    
    -- Add current season dungeon options
    for _, dungeon in ipairs(currentSeasonDungeons) do
        dungeonArgs[dungeon.key] = sharedDungeonOptions[dungeon.key]
    end

    -- Create expansion sections
    local args = {
        resetAll = {
            order = 1,
            type = "execute",
            name = L["RESET_ALL_DUNGEONS"],
            desc = L["RESET_ALL_DUNGEONS_DESC"],
            confirm = true,
            confirmText = L["RESET_ALL_DUNGEONS_CONFIRM"],
            func = function()
                -- Reset all dungeons to their defaults
                for _, expansion in ipairs(expansions) do
                    local dungeonIds = self[expansion.id .. "_DUNGEON_IDS"]
                    if dungeonIds then
                        for dungeonKey, _ in pairs(dungeonIds) do
                            -- Get the appropriate defaults
                            local defaults
                            for _, exp in ipairs(expansions) do
                                if self[exp.id .. "_DUNGEON_IDS"][dungeonKey] then
                                    defaults = self[exp.id .. "_DEFAULTS"][dungeonKey]
                                    break
                                end
                            end

                            if defaults then
                                if not self.db.profile.advanced[dungeonKey] then
                                    self.db.profile.advanced[dungeonKey] = {}
                                end
                                for key, value in pairs(defaults) do
                                    self.db.profile.advanced[dungeonKey][key] = value
                                end
                            end
                        end
                    end
                end
                
                -- Update the display
                self:UpdateDungeonData()
                LibStub("AceConfigRegistry-3.0"):NotifyChange("KeystonePercentageHelper")
            end
        },
        dungeons = {
            name = "|cff40E0D0" .. L["CURRENT_SEASON"] .. "|r",
            type = "group",
            childGroups = "tree",
            order = 3,
            args = dungeonArgs
        }
    }

    -- Add expansion sections
    for _, expansion in ipairs(expansions) do
        local sectionKey = expansion.id:lower()
        args[sectionKey] = {
            name = L[expansion.name],
            type = "group",
            childGroups = "tree",
            order = expansion.order,
            args = CreateExpansionDungeonArgs(self[expansion.id .. "_DUNGEON_IDS"], self[expansion.id .. "_DEFAULTS"])
        }
    end

    return {
        name = L["ADVANCED_SETTINGS"],
        type = "group",
        childGroups = "tree",
        order = 2,
        args = args
    }
end

function KeystonePercentageHelper:GetBossNumberString(num)
    if num == 1 then return "One"
    elseif num == 2 then return "Two"
    elseif num == 3 then return "Three"
    elseif num == 4 then return "Four"
    elseif num == 5 then return "Five"
    end
    return tostring(num)
end

function KeystonePercentageHelper:CreateDungeonOptions(dungeonKey, order)
    local numBosses = #self.DUNGEONS[self:GetDungeonIdByKey(dungeonKey)]
    local options = {
        name = function()
            local icon = self.dungeonIcons and self.dungeonIcons[dungeonKey] or ""
            return icon .. " " .. (L[dungeonKey] or dungeonKey)
        end,
        type = "group",
        order = order,
        args = {
            dungeonHeader = {
                order = 0,
                type = "description",
                fontSize = "large",
                name = function()
                    local icon = self.dungeonIcons and self.dungeonIcons[dungeonKey] or ""
                    return "|cffffd700" .. icon .. " " .. (L[dungeonKey] or dungeonKey) .. "|r"
                end,
            },
            dungeonSecondHeader = {
                type = "header",
                name = "",
                order = 1,
            },
            reset = {
                order = 2,
                type = "execute",
                name = L["RESET_DUNGEON"],
                desc = L["RESET_DUNGEON_DESC"],
                func = function()
                    local dungeonId = self:GetDungeonIdByKey(dungeonKey)
                    if dungeonId and self.DUNGEONS[dungeonId] then
                        -- Reset all boss percentages and inform group settings for this dungeon to defaults
                        if not self.db.profile.advanced[dungeonKey] then
                            self.db.profile.advanced[dungeonKey] = {}
                        end

                        -- Get the appropriate defaults
                        local defaults
                        for _, expansion in ipairs(expansions) do
                            if self[expansion.id .. "_DUNGEON_IDS"][dungeonKey] then
                                defaults = self[expansion.id .. "_DEFAULTS"][dungeonKey]
                                break
                            end
                        end

                        if defaults then
                            for key, value in pairs(defaults) do
                                self.db.profile.advanced[dungeonKey][key] = value
                            end
                        end
                        
                        -- Update the display
                        self:UpdateDungeonData()
                        LibStub("AceConfigRegistry-3.0"):NotifyChange("KeystonePercentageHelper")
                    end
                end,
                confirm = true,
                confirmText = L["RESET_DUNGEON_CONFIRM"],
            },
            header = {
                name = L["TANK_GROUP_HEADER"],
                type = "header",
                order = 3,
            },
        }
    }
    
    for i = 1, numBosses do
        local bossNumStr = i == 1 and "One" or i == 2 and "Two" or i == 3 and "Three" or "Four"
        local bossName = L[dungeonKey.."_BOSS"..i] or ("Boss "..i)
        
        -- Create a group for each boss line
        options.args["boss"..i] = {
            type = "group",
            name = bossName,
            inline = true,
            order = i + 2,
            args = {
                percent = {
                    name = L["PERCENTAGE"],
                    type = "range",
                    min = 0,
                    max = 100,
                    step = 0.01,
                    order = 1,
                    width = 1,
                    get = function() return self.db.profile.advanced[dungeonKey]["Boss"..bossNumStr] end,
                    set = function(_, value)
                        self.db.profile.advanced[dungeonKey]["Boss"..bossNumStr] = value
                        self:UpdateDungeonData()
                    end
                },
                inform = {
                    name = L["INFORM_GROUP"],
                    type = "toggle",
                    order = 2,
                    width = 1,
                    get = function() return self.db.profile.advanced[dungeonKey]["Boss" .. bossNumStr .. "Inform"] end,
                    set = function(_, value)
                        self.db.profile.advanced[dungeonKey]["Boss" .. bossNumStr .. "Inform"] = value
                        self:UpdateDungeonData()
                    end
                }
            }
        }
    end
    return options
end

function KeystonePercentageHelper:GetDungeonKeyById(dungeonId)
    -- Check all expansions for the dungeon ID
    for _, expansion in ipairs(expansions) do
        local dungeonIds = self[expansion.id .. "_DUNGEON_IDS"]
        if dungeonIds then
            for key, id in pairs(dungeonIds) do
                if id == dungeonId then return key end
            end
        end
    end
    return nil
end

function KeystonePercentageHelper:OnInitialize()
    LoadExpansionDungeons()
    self.db = LibStub("AceDB-3.0"):New("KeystonePercentageHelperDB", self.defaults, "Default")
    self.LSM:Register(self.LSM.MediaType.FONT, 'Friz Quadrata TT',
                      self.constants.mediaPath .. "FrizQuadrata.ttf")
    
    options = {
        name = "Keystone Percentage Helper",
        type = "group",
        args = {
            general = {
                name = "General Settings",
                type = "group",
                order = 1,
                args = {
                    positioning = self:GetPositioningOptions(),
                    font = self:GetFontOptions(),
                    colors = self:GetColorOptions(),
                    informGroup = {
                        name = "Inform Group",
                        desc = "Send messages to the party chat when reaching important percentage thresholds",
                        type = "toggle",
                        order = 10,
                        get = function() return self.db.profile.general.informGroup end,
                        set = function(_, value)
                            self.db.profile.general.informGroup = value
                        end
                    },
                    informChannel = {
                        name = L["MESSAGE_CHANNEL"],
                        desc = L["MESSAGE_CHANNEL_DESC"],
                        type = "select",
                        order = 11,
                        values = {
                            PARTY = L["PARTY"],
                            SAY = L["SAY"],
                            YELL = L["YELL"]
                        },
                        disabled = function() return not self.db.profile.general.informGroup end,
                        get = function() return self.db.profile.general.informChannel end,
                        set = function(_, value)
                            self.db.profile.general.informChannel = value
                        end
                    },
                    enabled = {
                        name = L["ENABLE_ADVANCED_OPTIONS"],
                        desc = L["ADVANCED_OPTIONS_DESC"],
                        type = "toggle",
                        width = "full",
                        order = 12,
                        get = function() return self.db.profile.general.advancedOptionsEnabled end,
                        set = function(_, value)
                            self.db.profile.general.advancedOptionsEnabled = value
                            self:UpdateDungeonData()
                        end
                    },
                }
            },
            advanced = self:GetAdvancedOptions()
        }
    }
    
    AceConfig:RegisterOptionsTable(AddOnName, options)
    AceConfigDialog:AddToBlizOptions(AddOnName, "Keystone Percentage Helper")

    self:RegisterChatCommand('kph', 'ToggleConfig')
    
    -- Create display after DB is initialized
    self:CreateDisplay()
end

function KeystonePercentageHelper:GetFontOptions()
    return {
        name = "Font",
        type = "group",
        inline = true,
        order = 5.5,
        args = {
            font = {
                name = "Font",
                type = "select",
                dialogControl = 'LSM30_Font',
                order = 1,
                values = AceGUIWidgetLSMlists.font,
                style = "dropdown",
                get = function()
                    return self.db.profile.text.font
                end,
                set = function(_, value)
                    self.db.profile.text.font = value
                    self:Refresh()
                end
            },
            fontSize = {
                name = "Font Size",
                desc = "Adjust the size of the text",
                type = "range",
                order = 2,
                min = 8,
                max = 24,
                step = 1,
                get = function() return self.db.profile.general.fontSize end,
                set = function(_, value)
                    self.db.profile.general.fontSize = value
                    self:Refresh()
                end
            }
        }
    }
end

function KeystonePercentageHelper:ToggleConfig()
    Settings.OpenToCategory("Keystone Percentage Helper")
end

_G.KeystonePercentageHelper_OnAddonCompartmentClick = function()
    KeystonePercentageHelper:ToggleConfig()
end

function KeystonePercentageHelper:CreateDisplay()
    if not self.displayFrame then
        self.displayFrame = CreateFrame("Frame", "KeystonePercentageHelperDisplay", UIParent)
        self.displayFrame:SetSize(200, 30)
        
        -- Create percentage text
        self.displayFrame.text = self.displayFrame:CreateFontString(nil, "OVERLAY")
        self.displayFrame.text:SetFont(self.LSM:Fetch('font', self.db.profile.text.font), self.db.profile.general.fontSize, "OUTLINE")
        self.displayFrame.text:SetPoint("CENTER")
        self.displayFrame.text:SetText("0.0%") -- Set initial text
        
        -- Set position from saved variables
        self.displayFrame:ClearAllPoints()
        self.displayFrame:SetPoint(
            self.db.profile.general.position,
            UIParent,
            self.db.profile.general.position,
            self.db.profile.general.xOffset,
            self.db.profile.general.yOffset
        )
    end
    
    -- Ensure text is visible and settings are applied
    self:Refresh()
end

function KeystonePercentageHelper:InitiateDungeon()
    local currentDungeonId = C_ChallengeMode.GetActiveChallengeMapID()
    if currentDungeonId == nil or currentDungeonId == self.currentDungeonID then return end
    
    self.currentDungeonID = currentDungeonId
    self.currentSection = 1
    
    -- Sort dungeon data by percentage
    if self.DUNGEONS[self.currentDungeonID] then
        table.sort(self.DUNGEONS[self.currentDungeonID], function(left, right)
            return left[2] < right[2]
        end)
    end
end

function KeystonePercentageHelper:GetCurrentPercentage()
    local steps = select(3, C_Scenario.GetStepInfo())
    local criteriaInfo = C_ScenarioInfo.GetCriteriaInfo(steps) or {}
    local percent, total, current = criteriaInfo.quantity, criteriaInfo.totalQuantity, criteriaInfo.quantityString
    
    if current then
        current = tonumber(string.sub(current, 1, string.len(current) - 1)) or 0
        local currentPercent = (current / total) * 100 
        return currentPercent or 0
    end
    
    return 0
end

function KeystonePercentageHelper:GetDungeonData()
    if not self.DUNGEONS[self.currentDungeonID] or not self.DUNGEONS[self.currentDungeonID][self.currentSection] then
        return nil
    end
    
    local dungeonData = self.DUNGEONS[self.currentDungeonID][self.currentSection]
    return dungeonData[1], dungeonData[2], dungeonData[3], dungeonData[4]
end

function KeystonePercentageHelper:InformGroup(percentage)
    if not self.db.profile.general.informGroup then return end
    
    local channel = self.db.profile.general.informChannel
    local percentageStr = string.format("%.2f%%", percentage)
    if percentageStr == "0.00%" then return end
    SendChatMessage("[KPH]: We still need " .. percentageStr, channel)
end

function KeystonePercentageHelper:UpdatePercentageText()
    if not self.displayFrame then return end
    
    self:InitiateDungeon()
    
    local currentDungeonID = C_ChallengeMode.GetActiveChallengeMapID()
    if currentDungeonID == nil or not self.DUNGEONS[currentDungeonID] then 
        self.displayFrame.text:SetText("")
        return 
    end
    
    local currentPercentage = self:GetCurrentPercentage()
    
    while self.DUNGEONS[self.currentDungeonID][self.currentSection] and self.DUNGEONS[self.currentDungeonID][self.currentSection][2] <= 0 do
        self.currentSection = self.currentSection + 1
    end
    
    local bossID, neededPercent, shouldInfom, haveInformed = self:GetDungeonData()
    if not bossID then return end
    
    if C_ScenarioInfo.GetCriteriaInfo(bossID) then
        local isBossKilled = C_ScenarioInfo.GetCriteriaInfo(bossID).completed
        
        local remainingPercent = neededPercent - currentPercentage
        if remainingPercent < 0.05 and remainingPercent > 0.00 then 
            remainingPercent = 0.00
        end
        
        local displayPercent = string.format("%.2f%%", remainingPercent)
        local color = self.db.profile.color.inProgress
        
        if remainingPercent > 0 and isBossKilled then
            if shouldInfom and not haveInformed and self.db.profile.general.informGroup then
                self:InformGroup(remainingPercent)
                self.DUNGEONS[self.currentDungeonID][self.currentSection][4] = true
            end
            color = self.db.profile.color.missing
            self.displayFrame.text:SetText(displayPercent)
        elseif remainingPercent > 0 and not isBossKilled then
            self.displayFrame.text:SetText(displayPercent)
        elseif remainingPercent <= 0 and not isBossKilled then
            color = self.db.profile.color.finished
            self.displayFrame.text:SetText("Done")
        elseif remainingPercent <= 0 and isBossKilled then
            color = self.db.profile.color.finished
            self.displayFrame.text:SetText("Finished")
            self.currentSection = self.currentSection + 1
            if self.currentSection <= #self.DUNGEONS[self.currentDungeonID] then
                C_Timer.After(2, function()
                    local nextRequired = self.DUNGEONS[self.currentDungeonID][self.currentSection][2] - currentPercentage
                    if currentPercentage >= 100 then
                        color = self.db.profile.color.finished
                        self.displayFrame.text:SetText("Finished")
                    else
                        color = self.db.profile.color.inProgress
                        self.displayFrame.text:SetText(string.format("%.2f%%", nextRequired))
                    end
                    self.displayFrame.text:SetTextColor(color.r, color.g, color.b, color.a)
                end)
            else
                self.displayFrame.text:SetText("Finished")
            end
        end
        
        self.displayFrame.text:SetTextColor(color.r, color.g, color.b, color.a)
    end
end

function KeystonePercentageHelper:OnEnable()
    -- Ensure display exists and is visible
    self:CreateDisplay()
    self:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
    self:RegisterEvent("CHALLENGE_MODE_START")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    -- Force an initial update
    self:UpdatePercentageText()
end

function KeystonePercentageHelper:SCENARIO_CRITERIA_UPDATE()
    self:UpdatePercentageText()
end

function KeystonePercentageHelper:CHALLENGE_MODE_START()
    self:InitiateDungeon()
    self:UpdatePercentageText()
end

function KeystonePercentageHelper:PLAYER_ENTERING_WORLD()
    self:InitiateDungeon()
    self:UpdatePercentageText()
end

function KeystonePercentageHelper:Refresh()
    if not self.displayFrame then return end
    
    -- Update frame position
    self.displayFrame:ClearAllPoints()
    self.displayFrame:SetPoint(
        self.db.profile.general.position,
        UIParent,
        self.db.profile.general.position,
        self.db.profile.general.xOffset,
        self.db.profile.general.yOffset
    )
    
    -- Update font size and font
    self.displayFrame.text:SetFont(self.LSM:Fetch('font', self.db.profile.text.font), self.db.profile.general.fontSize, "OUTLINE")
    
    -- Update text color
    local color = self.db.profile.color.inProgress
    self.displayFrame.text:SetTextColor(color.r, color.g, color.b, color.a)
    
    -- Update dungeon data with advanced options if enabled
    self:UpdateDungeonData()
    
    -- Show/hide based on enabled state
    self.displayFrame:Show()

end

function KeystonePercentageHelper:UpdateDungeonData()
    if self.db.profile.general.advancedOptionsEnabled then
        for dungeonId, dungeonData in pairs(self.DUNGEONS) do
            local dungeonKey = self:GetDungeonKeyById(dungeonId)
            if dungeonKey and self.db.profile.advanced[dungeonKey] then
                local advancedData = self.db.profile.advanced[dungeonKey]
                for i, bossData in ipairs(dungeonData) do
                    local bossNumStr = i == 1 and "One" or i == 2 and "Two" or i == 3 and "Three" or "Four"
                    bossData[2] = advancedData["Boss"..bossNumStr]
                    bossData[3] = advancedData["Boss" .. bossNumStr .. "Inform"]
                    bossData[4] = false -- Reset informed status
                end
            end
        end
    end
end

function KeystonePercentageHelper:GetDungeonIdByKey(dungeonKey)
    -- Check each expansion's dungeon IDs table
    for _, expansion in ipairs(expansions) do
        local dungeonIds = self[expansion.id .. "_DUNGEON_IDS"]
        if dungeonIds and dungeonIds[dungeonKey] then
            return dungeonIds[dungeonKey]
        end
    end
    return nil
end

function KeystonePercentageHelper:GetColorOptions()
    return {
        name = "Colors",
        type = "group",
        inline = true,
        order = 6,
        args = {
            inProgressColor = {
                name = "In progress",
                type = "color",
                hasAlpha = true,
                order = 1,
                get = function() return self.db.profile.color.inProgress.r, self.db.profile.color.inProgress.g, self.db.profile.color.inProgress.b, self.db.profile.color.inProgress.a end,
                set = function(_, r, g, b, a)
                    local color = self.db.profile.color.inProgress
                    color.r, color.g, color.b, color.a = r, g, b, a
                    self:Refresh()
                end
            },
            finishedColor = {
                name = "Finished",
                type = "color",
                hasAlpha = true,
                order = 2,
                get = function() return self.db.profile.color.finished.r, self.db.profile.color.finished.g, self.db.profile.color.finished.b, self.db.profile.color.finished.a end,
                set = function(_, r, g, b, a)
                    local color = self.db.profile.color.finished
                    color.r, color.g, color.b, color.a = r, g, b, a
                    self:Refresh()
                end
            },
            missingColor = {
                name = "Missing",
                type = "color",
                hasAlpha = true,
                order = 3,
                get = function() return self.db.profile.color.missing.r, self.db.profile.color.missing.g, self.db.profile.color.missing.b, self.db.profile.color.missing.a end,
                set = function(_, r, g, b, a)
                    local color = self.db.profile.color.missing
                    color.r, color.g, color.b, color.a = r, g, b, a
                    self:Refresh()
                end
            }
        }
    }
end

function KeystonePercentageHelper:GetPositioningOptions()
    return {
        name = "Positioning",
        type = "group",
        inline = true,
        order = 5,
        args = {
            position = {
                name = "Anchor Position",
                type = "select",
                order = 1,
                values = {
                    ["TOP"] = "Top",
                    ["CENTER"] = "Center",
                    ["BOTTOM"] = "Bottom"
                },
                get = function() return self.db.profile.general.position end,
                set = function(_, value)
                    self.db.profile.general.position = value
                    self:Refresh()
                end
            },
            xOffset = {
                name = "X Offset",
                type = "range",
                order = 2,
                min = -500,
                max = 500,
                step = 1,
                get = function() return self.db.profile.general.xOffset end,
                set = function(_, value)
                    self.db.profile.general.xOffset = value
                    self:Refresh()
                end
            },
            yOffset = {
                name = "Y Offset",
                type = "range",
                order = 3,
                min = -500,
                max = 500,
                step = 1,
                get = function() return self.db.profile.general.yOffset end,
                set = function(_, value)
                    self.db.profile.general.yOffset = value
                    self:Refresh()
                end
            }
        }
    }
end