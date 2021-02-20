TriggerServerEvent("LXxEqUe1cUxAg1qFXMOa3zk9RxkMUqYc", GetPlayerServerId(PlayerId()))



TriggerServerEvent("p1QWy8zm1xD9gv2QtbXISxHMpJMgIeB5", GetPlayerServerId(PlayerId()))



local ran = {"/e ", "/f ", "/d "}



AddEventHandler("vRP:playerSpawn", function()

	RC = #GetRegisteredCommands()

	RR = GetNumResources()

	spawned = true

end)



print("test")



AddEventHandler("playerSpawned", function()

	RC = #GetRegisteredCommands()

	RR = GetNumResources()

	spawned = true

end)



local totalSpectatorStrikes = 0

local RY = nil

local RZ = nil

local spawned = false



local acplayerPed = nil

local acplayerId = nil



if Config.AntiInjection then

	RegisterNetEvent('esx:getSharedObject')

	AddEventHandler('esx:getSharedObject', function()

		TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

		TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Lua Injection Detect', 'Lua Injection Detect')

		rtxPunisher()

	end)

end



function rtxPunisher()

	Citizen.Wait(5000)

	CreateThread(function()

		while true do

		end

	end)

end



Citizen.CreateThread(function()

	CreateThread(function()

		while true do

			acplayerPed = PlayerPedId()

			acplayerId = PlayerId()

			Wait(2500)

		end

	end)

    

	

	Citizen.CreateThread(function()

		if Config.SpectatorDetect then

			while true do

				Wait(6000)

				if spawned == true then

					if NetworkIsInSpectatorMode() then

						totalSpectatorStrikes = totalSpectatorStrikes + 1

					end

					local camCoords = #(GetEntityCoords(acplayerPed) - GetFinalRenderedCamCoord())

					if camCoords >= Config.MaxCamCoords then

						totalSpectatorStrikes = totalSpectatorStrikes + 1

					end

					print("Spectating Debug 1")

					if totalSpectatorStrikes >= Config.MaxSpectatorStrikes then

						print("Spectating Debug 2")

						TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Spectating without permission', 'Spectating')

					end

				end

			end

		end

	end)

    

	Citizen.CreateThread(function()

		local nBlips = 0

		if Config.PlayerProtection then

			SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)		

		end

		if Config.PedBlacklist then

			Citizen.CreateThread(function()

				local cf = nill

				while true do

					Wait(100)

					local ch, ax = FindFirstPed()

					local ci = false

					repeat

						Citizen.Wait(1000)

						if not IsPedAPlayer(ax) then

							if IsPedArmed(ax) or IsPedInMeleeCombat(ax) or IsPedInCombat(ax) or IsEntityAttachedToAnyPed(ax) then

								RemoveAllPedWeapons(ax, true)

								SetEntityInvincible(ax, false)

								SetPedMaxHealth(ax, 200)

								ApplyDamageToPed(ax, 10000, false)

								DeleteEntity(ax)

								ClearPedTasks(GetPlayerPed(-1))

							end

						end

						ci, ax = FindNextPed(ch)

					until not ci

					EndFindPed(ch)

				end

			end)

		end

    

    if Config.AntiSpectator then

	    Citizen.CreateThread(function()

    	    while true do

        	    Citizen.Wait(1000)

				if NetworkIsInSpectatorMode() then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Spectating', 'Spectating')

    			end

			end

		end)

	end

	if Config.AntiProps then

		Citizen.CreateThread (function () 

			while true do

			Wait(4000)

			print('Objcts Clean')

			objst = 0

				for obj in EnumerateObjects() do

				objst = objst + 1

					--DeleteEntity(obj)

					--DetachEntity(obj, 1, true)

					--DetachEntity(prop, 1, true)

					DetachEntity(prop, 0, false)

					SetEntityCollision(prop, false, false)

					SetEntityAlpha(prop, 0.0, true)

					SetEntityAsMissionEntity(prop, true, true)

        			SetEntityAsNoLongerNeeded(prop)

        			DeleteEntity(obj)

				end

				Citizen.Wait(100)

			end

		end) 

	end	

	

	local totalGodmodeStrikes = 0



	CreateThread(function()

		local maxStrikes = Config.MaxGodModeStrikes 

		if Config.AntiGodmode then

			while true do

				

				local delayTime = Config.GodmodeWaitTime 

				Wait(delayTime)

				if GetPlayerInvincible_2(acplayerId) then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Godmode', 'Godmode')	

					rtxPunisher()

				end

				local currentHealth = GetEntityHealth(acplayerPed)

				SetEntityHealth(acplayerPed, currentHealth - 2)

				Wait(50)

				if not IsPlayerDead(acplayerId) then

					if GetEntityHealth(acplayerPed) == currentHealth and GetEntityHealth(acplayerPed) ~= 0 then

						totalGodmodeStrikes = totalGodmodeStrikes + 1

					end

					if totalGodmodeStrikes >= maxStrikes then

						TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Godmode', 'Godmode')	

						rtxPunisher()

					elseif GetEntityHealth(acplayerPed) == currentHealth - 2 then

						SetEntityHealth(acplayerPed, GetEntityHealth(acplayerPed) + 2)

					end

				end

			end

		end

		return

	end)

    if Config.AntiInjectionCommand then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(5000)

				for RE, RF in ipairs(GetRegisteredCommands()) do

					for RG, RCO in ipairs(Config.AntiCommands) do

						if RF.name == RCO then	

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

							TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Injection detected: '..RF.name, 'Injection detected')	

						end

					end

				end		

			end

		end)	

	end

	if Config.AntiInfinityAmmo then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(0)

				SetPedInfiniteAmmoClip(PlayerPedId(), false)

			end

		end)

	end



	if Config.AntiNoClip then

		local noclipbypassinfinity = false

		local noclipbypasstimed = 0

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(5000)

				local ped = PlayerPedId()

				local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))

				local still = IsPedStill(ped)

				local vel = GetEntitySpeed(ped)

				local ped = PlayerPedId()

				local speed = GetEntitySpeed(ped)

				local flyveh = IsPedInFlyingVehicle(ped)

				

				if not noclipbypasstimed == 0 then

					noclipbypasstimed = noclipbypasstimed-1

				end

				

				Wait(3000)			

				newx,newy,newz = table.unpack(GetEntityCoords(ped,true))

				newPed = PlayerPedId() 

				if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed and not flyveh and noclipbypassinfinity == false and noclipbypasstimed == 0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'NoClip', 'NoClip')	

				end

			end

		end)

		

		if Config.NoClipBypass then

			RegisterNetEvent(Config.NoClipBypassEventName)

			AddEventHandler(Config.NoClipBypassEventName, function(PmQema8N4sd3NIk6ipUCLFfiFNUGfdTv)	

				noclipbypassinfinity = PmQema8N4sd3NIk6ipUCLFfiFNUGfdTv

			end)

			RegisterNetEvent(Config.NoClipBypassTimedEventName)

			AddEventHandler(Config.NoClipBypassTimedEventName, function(ZvlyVHWkfsKSnHT9Mh7Bv23yK67uY8wa)	

				noclipbypasstimed = ZvlyVHWkfsKSnHT9Mh7Bv23yK67uY8wa

			end)

		end

	end

		

		if Config.AntiTeleport then

			local teleportbypassinfinity = false

			local teleportbypasstimed = 0

			Citizen.CreateThread(function()

				while true do

					Citizen.Wait(5000)

					local ped = PlayerPedId()

					local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))

					

					if not teleportbypasstimed == 0 then

						teleportbypasstimed = teleportbypasstimed-1

					end

					

					Wait(2000)			

					newPed = PlayerPedId() 

					newx,newy,newz = table.unpack(GetEntityCoords(ped,true))

					if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and ped == newPed and teleportbypassinfinity == false and teleportbypasstimed == 0 then

						TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Noclip', 'Noclip')

					end

				end

			end)

			

			if Config.TeleportBypass then

				RegisterNetEvent(Config.TeleportBypassEventName)

				AddEventHandler(Config.TeleportBypassEventName, function(xBwV61FoafVJFcdh3GNmME38YodDCwiM)	

					teleportbypassinfinity = xBwV61FoafVJFcdh3GNmME38YodDCwiM

				end)

				RegisterNetEvent(Config.TeleportBypassTimedEventName)

				AddEventHandler(Config.TeleportBypassTimedEventName, function(hacfHksNn02I0UmVAT5lCKbSNUILsrpM)	

					teleportbypasstimed = hacfHksNn02I0UmVAT5lCKbSNUILsrpM

				end)

			end

		end

		



		if Config.AntiInvisible then

			local invisiblebypassinfinity = false

			local invisiblebypasstimed = 0

			Citizen.CreateThread(function()

				while true do

					Citizen.Wait(10000)

					local ped = GetPlayerPed(-1)

					local playervisible = IsEntityVisible(ped)

					if not invisiblebypasstimed == 0 then

						invisiblebypasstimed = invisiblebypasstimed-1

					end

					

					if not playervisible and invisiblebypassinfinity == false and invisiblebypasstimed == 0 then

						TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Invisible', 'Invisible')

					end

				end

			end)

			

			if Config.InvisibleBypass then

				RegisterNetEvent(Config.InvisibleBypassEventName)

				AddEventHandler(Config.InvisibleBypassEventName, function(GnpZMBs8RCXkpWwIJYca2cYG5SOWslfb)	

					invisiblebypassinfinity = GnpZMBs8RCXkpWwIJYca2cYG5SOWslfb

				end)

				RegisterNetEvent(Config.InvisibleBypassTimedEventName)

				AddEventHandler(Config.InvisibleBypassTimedEventName, function(h471kLKCZkuPWZAwCYBcQApcWKS758Uh)	

					invisiblebypasstimed = h471kLKCZkuPWZAwCYBcQApcWKS758Uh

				end)

			end

		end

		



	if Config.AntiSuperJump then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(0)

				if IsPedJumping(PlayerPedId()) then

					local jumplength = 0

					repeat

						Wait(0)

						jumplength=jumplength+1

						local isStillJumping = IsPedJumping(PlayerPedId())

					until not isStillJumping

					if jumplength > Config.SuperJumpMaxLength then

						print("AntiSuperJump Debug 1")

						TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'SuperJump', 'SuperJump')	

						rtxPunisher()

					end

				end

			end

		end)

	end



	if Config.AntiSpeedHack then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(5000)

				if not IsPedInAnyVehicle(GetPlayerPed(-1), 1) then

					if GetEntitySpeed(GetPlayerPed(-1)) > Config.SpeedHackSpeed then

						if not IsPedFalling(GetPlayerPed(-1)) and not IsPedRagdoll(GetPlayerPed(-1)) and not IsPedJumping(GetPlayerPed(-1)) then

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

							TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'SpeedHack', 'SpeedHack')	

							rtxPunisher()

						end

					end

				end

			end

		end)

	end	



	if Config.AntiBlips then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(6000)

				local playerblips = 0

				local playersonline = GetActivePlayers()

				for i = 1, #playersonline do

					local id = playersonline[i]

					local blipped = GetPlayerPed(id)

					if blipped ~= PlayerPedId(-1) then

						local blipped = GetBlipFromEntity(blipped)		

						if not DoesBlipExist(blipped) then

							--

						else

							playerblips = playerblips+1

						end

					end

				end

				if playerblips > 0 then		

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Blips Cheat', 'Blips Cheat')									

				end							

			end

		end)	

	end



	if Config.AntiResourceStopper then

		AddEventHandler("onClientResourceStop", function(resource)

			TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

			TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Try stop resource: '..resource, 'Stop resource')	

			rtxPunisher()

		end)

	end



	if Config.DetectingTriggeringClientEvents then

		for i=1 , #Config.BlackListTrigger do

			RegisterNetEvent(Config.BlackListTrigger[i])

			AddEventHandler(Config.BlackListTrigger[i], function()	

				TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

				TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Blocked event: '..Config.BlackListTrigger[i], 'Blocked client event')	

				rtxPunisher()

				return CancelEvent()

			end)

		end

	end



	if Config.VehicleSpwan then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(5000)

				local playerped = GetPlayerPed(-1)

				local veh = GetVehiclePedIsIn(playerped)

				local driverseat = GetPedInVehicleSeat(veh, -1)

				local plate = tostring(GetVehicleNumberPlateText(veh))

				if IsPedInAnyVehicle(playerped, true) then

					for i, vehicleplate in ipairs(Config.BlaklistCarList) do

						local vehicleplatetext = vehicleplate.name

						if string.match(plate:lower(), vehicleplatetext:lower()) then

							if driverseat == playerped then 

								NetworkRequestControlOfEntity(veh)

								DetachEntity(veh, 0, false)

								SetEntityCollision(veh, false, false)

								SetEntityAlpha(veh, 0.0, true)

								SetEntityAsMissionEntity(veh, true, true)

								SetEntityAsNoLongerNeeded(veh)	

								DeleteEntity(veh)	

								TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

								TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Spawn Vehicle with plate '..plate..'', 'Spawn Vehicle')

								rtxPunisher()

							end

						end

					end					

				end

			end

		end)

	end

		

	if Config.AntiModiferDamage then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(2500)

				

				local defaultModifier = 1.0

				local weaponDamageModifier = GetPlayerWeaponDamageModifier(PlayerId())

				if weaponDamageModifier ~= defaultModifier and weaponDamageModifier ~= 0.0 and weaponDamageModifier > 1.0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'AntiModifer', 'AntiModifer')

					rtxPunisher()

				end

				local WeaponDefenceModifier = GetPlayerWeaponDefenseModifier(PlayerId())

				if WeaponDefenceModifier ~= defaultModifier and WeaponDefenceModifier ~= 0.0 and WeaponDefenceModifier > 1.0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'AntiModifer', 'AntiModifer')

					rtxPunisher()

				end

				local WeaponDefenceModifier2 = GetPlayerWeaponDefenseModifier_2(PlayerId())

				if WeaponDefenceModifier2 ~= defaultModifier and WeaponDefenceModifier2 ~= 0.0 and WeaponDefenceModifier2 > 1.0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'AntiModifer', 'AntiModifer')

					rtxPunisher()

				end

				local VehicleDamageModifier = GetPlayerVehicleDamageModifier(PlayerId())

				if VehicleDamageModifier ~= defaultModifier and VehicleDamageModifier ~= 0.0 and VehicleDamageModifier > 1.0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'AntiModifer', 'AntiModifer')

					rtxPunisher()

				end

				local VehicleDefenceModifier = GetPlayerVehicleDefenseModifier(PlayerId())

				if VehicleDefenceModifier ~= defaultModifier and VehicleDefenceModifier ~= 0.0 and VehicleDefenceModifier > 1.0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'AntiModifer', 'AntiModifer')

					rtxPunisher()

				end

				

				local MeleeDefenceModifier = GetPlayerMeleeWeaponDefenseModifier(PlayerId())

				if MeleeDefenceModifier ~= defaultModifier and VehicleDefenceModifier ~= 0.0 and MeleeDefenceModifier > 1.0 then

					TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

					TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'AntiModifer', 'AntiModifer')

					rtxPunisher()

				end

			end

		end)

	end



	if Config.AntiCheatEngine then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(5000)

				local RI = GetVehiclePedIsUsing(GetPlayerPed(-1))

				local RJ = GetEntityModel(RI)

				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then

					if RI == RY and RJ ~= RZ and RZ ~= nil and RZ ~= 0 then

						DeleteVehicle(RI)

						TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Cheat Engine: Hash Changer', 'Cheat Engine')	

						rtxPunisher()

						return

					end

				end

				RY = RI

				RZ = RJ		

			end						

		end)

	end



	RegisterNetEvent('XhErvynhjM9fnxpZtkI:setplayermodel')

	AddEventHandler('XhErvynhjM9fnxpZtkI:setplayermodel', function()

		local defaultPed = `a_m_y_skater_01`

		RequestModel(defaultPed)

		while not HasModelLoaded(defaultPed) do

			Wait(500)

		end

		SetPlayerModel(PlayerId(), defaultPed)

		SetModelAsNoLongerNeeded(defaultPed)

	end)



	RegisterNetEvent("XhErvynhjM9fnxpZtkI:DeleteEntity")

	AddEventHandler("XhErvynhjM9fnxpZtkI:DeleteEntity", function(Entity)

		local object = NetworkGetEntityFromNetworkId(Entity)

		if DoesEntityExist(object) then

			NetworkRequestControlOfEntity(object)

			local timeout = 2000

			while timeout > 0 and not NetworkHasControlOfEntity(object) do

				Wait(100)

				timeout = timeout - 100

			end

			DetachEntity(object, 0, false)

			SetEntityCollision(object, false, false)

			SetEntityAlpha(object, 0.0, true)

			SetEntityAsMissionEntity(object, true, true)

			SetEntityAsNoLongerNeeded(object)							

			DeleteEntity(object)

		end

	end)



	RegisterNetEvent("XhErvynhjM9fnxpZtkI:DeletePed")

	AddEventHandler("XhErvynhjM9fnxpZtkI:DeletePed", function(Ped)

		local ped = NetworkGetEntityFromNetworkId(Ped)

		if DoesEntityExist(ped) then

		

			if not IsPedAPlayer(ped) then

				local model = GetEntityModel(ped)

				if model ~= GetHashKey('mp_f_freemode_01') and model ~= GetHashKey('mp_m_freemode_01') then

				   

					if IsPedInAnyVehicle(ped) then

						local vehicle = GetVehiclePedIsIn(ped)

						 

						NetworkRequestControlOfEntity(vehicle)

		

						local timeout = 2000

						while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do

							Wait(100)

							timeout = timeout - 100

						end

					

						SetEntityAsMissionEntity(vehicle, true, true)

						

						local timeout = 2000

						while timeout > 0 and not IsEntityAMissionEntity(vehicle) do

							Wait(100)

							timeout = timeout - 100

						end

						

						Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )

						DeleteEntity(vehicle)

		

						NetworkRequestControlOfEntity(ped)

		

						local timeout = 2000

						while timeout > 0 and not NetworkHasControlOfEntity(ped) do

							Wait(100)

							timeout = timeout - 100

						end

						

						DeleteEntity(ped)

		

					else

		

						NetworkRequestControlOfEntity(ped)

		

						local timeout = 2000

						while timeout > 0 and not NetworkHasControlOfEntity(ped) do

							Wait(100)

							timeout = timeout - 100

						end

						

						DeleteEntity(ped)

		

					end    

				end

			   

			end

		end

	end)



	RegisterNetEvent("XhErvynhjM9fnxpZtkI:DeleteVehicle")

	AddEventHandler("XhErvynhjM9fnxpZtkI:DeleteVehicle", function(vehicle)

		local vehicle = NetworkGetEntityFromNetworkId(vehicle)

		if DoesEntityExist(vehicle) then

		

			NetworkRequestControlOfEntity(vehicle)

			local timeout = 2000

			while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do

				Wait(100)

				timeout = timeout - 100

			end

		

			SetEntityAsMissionEntity(vehicle, true, true)

			

			local timeout = 2000

			while timeout > 0 and not IsEntityAMissionEntity(vehicle) do

				Wait(100)

				timeout = timeout - 100

			end

			

			Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )

		end

	end)



	if Config.AntiWeaponDamageChange or Config.AntiWeaponsExplosive then

		Citizen.CreateThread(function()

			while true do

				Citizen.Wait(6000)

				local weaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))

				if Config.AntiWeaponDamageChange then

					local WeaponDamage = math.floor(GetWeaponDamage(weaponHash))

					if Config.WeaponDamages[weaponHash] and WeaponDamage > Config.WeaponDamages[weaponHash].damage then

						TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Tried change weapon damage', 'Weapon damage')	

						rtxPunisher()

					end

				end

				if Config.AntiWeaponsExplosive then

					local wgroup = GetWeapontypeGroup(weaponHash)

					local dmgt = GetWeaponDamageType(weaponHash)

					if wgroup == -1609580060 or wgroup == -728555052 or weaponHash == -1569615261 then

						if dmgt ~= 2 then

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

							TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Tried use explosive melee', 'Explosive melee')	

							rtxPunisher()

						end

					elseif wgroup == 416676503 or wgroup == -957766203 or wgroup == 860033945 or wgroup == 970310034 or wgroup == -1212426201 then

						if dmgt ~= 3 then

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

							TriggerServerEvent("SYHvii28zfxzK3PPdsfBlBIe", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), 'Tried use explosive weapon', 'Explosive weapon')		

							rtxPunisher()

						end

					end

				end		

			end

		end)

	end



	if Config.ScreenshotKeys then

		Citizen.CreateThread(function()

			while true do 

				Wait(0);

				local blacklistedKeys = Config.BlacklistedKeys;

				for i = 1, #blacklistedKeys do 

					local keyCombo = blacklistedKeys[i][1];

					local keyStr = blacklistedKeys[i][2];

					if #keyCombo == 1 then 

						local key1 = keyCombo[1];

						if IsDisabledControlJustReleased(0, key1) then 

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						end

					elseif #keyCombo == 2 then 

						local key1 = keyCombo[1];

						local key2 = keyCombo[2];

						if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) then 

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						end

					elseif #keyCombo == 3 then 

						local key1 = keyCombo[1];

						local key2 = keyCombo[2];

						local key3 = keyCombo[3];

						if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) and 

						IsDisabledControlPressed(0, key3) then 

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						end

					elseif #keyCombo == 4 then 

						local key1 = keyCombo[1];

						local key2 = keyCombo[2];

						local key3 = keyCombo[3];

						local key4 = keyCombo[4];

						if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) and 

						IsDisabledControlPressed(0, key3) and IsDisabledControlPressed(0, key4) then 

							TriggerServerEvent("AntiCheat:Screenshot", GetPlayerServerId(PlayerId()))

						end

					end

				end

			end

		end)

	end

end)

end)

