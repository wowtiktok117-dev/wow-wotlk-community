local GlobalAddonName, ExRT = ...

local VMRT = nil

local module = ExRT:New("WhoPulled",ExRT.L.WhoPulled)
local ELib,L = ExRT.lib,ExRT.L

local UnitAffectingCombat, string_find = UnitAffectingCombat, string.find
local bit_band = bit.band

local USE_CLEU = ExRT.isWotLKOnly
local PRIMARY_DETECTION_EVENT = USE_CLEU and 'COMBAT_LOG_EVENT_UNFILTERED' or 'UNIT_FLAGS'

module.db.lastPull = nil
module.db.lastBossName = nil
module.db.whoPulled = nil
module.db.isPet = nil

function module.options:Load()
	self:CreateTilte()

	local function UpdatePage()
		local pull = "-"
		if module.db.lastPull then
			pull = date("%d/%m/%Y %H:%M:%S",module.db.lastPull).." "..(module.db.lastBossName or "")
		end
	  	self.lastPull:SetText(L.WhoPulledlastPull..": "..pull)
	  	if module.db.isPet then
	  		self.Name:SetText((module.db.whoPulled or "").." ("..PET.." "..module.db.isPet..")")
	  	else
	  		self.Name:SetText(module.db.whoPulled or "")
	  	end
	end

	self.lastPull = ELib:Text(self,"",12):Point("TOP",0,-50):Top():Color()
	self.Name = ELib:Text(self,"",18):Point("TOP",0,-65):Top():Color()

	self.chatCheck = ELib:Check(self,L.WhoPulledChatOption,not VMRT.WhoPulled.DisableChat):Point("BOTTOMLEFT",10,40):OnClick(function(self)
		VMRT.WhoPulled.DisableChat = not self:GetChecked()
	end)

	function self:OnShow()
		UpdatePage()
	end
end


function module.main:ADDON_LOADED()
	VMRT = _G.VMRT
	VMRT.WhoPulled = VMRT.WhoPulled or {}

	module:RegisterEvents('ENCOUNTER_START')
	module:RegisterEvents('ZONE_CHANGED_NEW_AREA')
	module.main:ZONE_CHANGED_NEW_AREA()
end

local affectedCombat,affectedCombatPetOwner = nil
local announcedCombat = false

local function WhoPulledAnnounce()
	if not affectedCombat then
		return false
	end
	if announcedCombat then
		module.db.whoPulled = affectedCombat
		module.db.isPet = affectedCombatPetOwner
		return true
	end
	announcedCombat = true
	module.db.whoPulled = affectedCombat
	module.db.isPet = affectedCombatPetOwner
	module.db.lastPull = module.db.lastPull or time()
	if not VMRT.WhoPulled or VMRT.WhoPulled.DisableChat then
		return true
	end
	local _,class = UnitClass(affectedCombatPetOwner or affectedCombat)
	local color = class and ExRT.F.classColor(class) or "ffffffff"
	print("|cffffff00MRT|r "..L.WhoPulled..": |c"..color..affectedCombat..(affectedCombatPetOwner and " ["..affectedCombatPetOwner.."]" or ""))
	return true
end
function module.main:ENCOUNTER_START(encounterID, encounterName, difficultyID, groupSize)
	module.db.lastPull = time()
	module.db.lastBossName = encounterName
	if not ExRT.isWotLKOnly then
		module.db.whoPulled = nil
		module.db.isPet = nil
	end
	if not WhoPulledAnnounce() then
		C_Timer.After(1,WhoPulledAnnounce)
	end
end

local function ZoneNewFunction()
	local _, zoneType, difficulty, _, _, _, _, mapID = GetInstanceInfo()
	if zoneType == "raid" or zoneType == "party" then
		module:RegisterEvents(PRIMARY_DETECTION_EVENT,'PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED')
		if module._WhoPulledPoll and not InCombatLockdown() then module._WhoPulledPoll:Show() end
	else
		module:UnregisterEvents(PRIMARY_DETECTION_EVENT,'PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED')
		if module._WhoPulledPoll then module._WhoPulledPoll:Hide() end
	end
end

function module.main:ZONE_CHANGED_NEW_AREA()
	ExRT.F.ScheduleTimer(ZoneNewFunction, 2)
end

local function ClearAffectedCombat()
	affectedCombat = nil
	affectedCombatPetOwner = nil
end

function module.main:UNIT_FLAGS(unit)
	if not affectedCombat and UnitAffectingCombat(unit) and (string_find(unit,"^raid") or unit == "player" or string_find(unit,"^party")) then
		affectedCombat = UnitName(unit)
		if string_find(unit,"pet") then
			local ownerUnitID = unit:gsub("pet","")
			affectedCombatPetOwner = UnitName(ownerUnitID)
		end
		WhoPulledAnnounce()
		C_Timer.After(3,ClearAffectedCombat)
	end
end

if USE_CLEU then
	local AFFIL_OURS_MASK = 0x00000007
	local REACTION_HOSTILE = 0x00000040
	local POLL_INTERVAL    = 0.02
	local ANNOUNCE_DELAY   = 0.5
	local TIE_WINDOW       = 0.05

	local firstCombat   = {}
	local firstHostile  = {}
	local petOwners     = {}
	local prevInCombat  = {}

	local function ResetPullState()
		wipe(firstCombat)
		wipe(firstHostile)
		wipe(petOwners)
		wipe(prevInCombat)
		affectedCombat = nil
		affectedCombatPetOwner = nil
		announcedCombat = false
	end
	module._WhoPulledResetState = ResetPullState

	local function eachGroupUnit(cb)
		if IsInRaid and IsInRaid() then
			local n = GetNumGroupMembers and GetNumGroupMembers() or 0
			for i = 1, n do
				cb("raid"..i, "raid"..i.."pet")
			end
		else
			cb("player", "pet")
			local n = GetNumGroupMembers and GetNumGroupMembers() or 0
			for i = 1, n - 1 do
				cb("party"..i, "partypet"..i)
			end
		end
	end

	function module.main.COMBAT_LOG_EVENT_UNFILTERED(_, subEvent, _, _, srcName, srcFlags, _, _, dstName, dstFlags)
		if announcedCombat or not srcName then return end
		if not srcFlags or bit_band(srcFlags, AFFIL_OURS_MASK) == 0 then return end
		if not dstFlags or bit_band(dstFlags, REACTION_HOSTILE) == 0 then return end
		if dstName == srcName then return end
		if subEvent == "UNIT_DIED" or subEvent == "UNIT_DESTROYED" or subEvent == "PARTY_KILL" then return end
		if firstHostile[srcName] then return end
		firstHostile[srcName] = GetTime()
	end

	local pollFrame = CreateFrame("Frame")
	local pollAccum = 0
	pollFrame:Hide()
	pollFrame:SetScript("OnUpdate", function(self, elapsed)
		pollAccum = pollAccum + elapsed
		if pollAccum < POLL_INTERVAL then return end
		pollAccum = 0
		if announcedCombat then return end

		local now = GetTime()

		eachGroupUnit(function(unit, petUnit)
			if UnitExists(unit) then
				if UnitAffectingCombat(unit) then
					if not prevInCombat[unit] then
						prevInCombat[unit] = true
						local name = UnitName(unit)
						if name and not firstCombat[name] then
							firstCombat[name] = now
						end
					end
				else
					prevInCombat[unit] = false
				end
			end
			if UnitExists(petUnit) then
				if UnitAffectingCombat(petUnit) then
					if not prevInCombat[petUnit] then
						prevInCombat[petUnit] = true
						local petName = UnitName(petUnit)
						local ownerName = UnitName(unit)
						if petName and not firstCombat[petName] then
							firstCombat[petName] = now
							if ownerName then petOwners[petName] = ownerName end
						end
					end
				else
					prevInCombat[petUnit] = false
				end
			end
		end)

		if next(firstCombat) == nil then return end

		local earliestT, earliestN = math.huge, nil
		for name, t in pairs(firstCombat) do
			if t < earliestT then earliestT, earliestN = t, name end
		end
		if (now - earliestT) < ANNOUNCE_DELAY then return end

		for name, t in pairs(firstCombat) do
			if name ~= earliestN and (t - earliestT) < TIE_WINDOW then
				local ca = firstHostile[earliestN] or math.huge
				local cb = firstHostile[name]      or math.huge
				if cb < ca then earliestN = name end
			end
		end

		affectedCombat = earliestN
		affectedCombatPetOwner = petOwners[earliestN]
		WhoPulledAnnounce()
	end)

	module._WhoPulledPoll = pollFrame
end

function module.main:PLAYER_REGEN_DISABLED(unit)
	if not ExRT.isWotLKOnly then
		module:UnregisterEvents(PRIMARY_DETECTION_EVENT)
		if module._WhoPulledPoll then module._WhoPulledPoll:Hide() end
	end
end

function module.main:PLAYER_REGEN_ENABLED(unit)
	if module._WhoPulledResetState then
		module._WhoPulledResetState()
	else
		affectedCombat = nil
		affectedCombatPetOwner = nil
		announcedCombat = false
	end
	ZoneNewFunction()
end
