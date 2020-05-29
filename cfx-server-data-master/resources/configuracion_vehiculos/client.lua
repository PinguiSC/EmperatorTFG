local deformationMultiplier = 10.0				-- Cuanto debería deformarse visualmente el vehiculo de una colision. Rango 0.0 a 10.0 Donde 0.0 no es deformacion y 10.0 es 10x deformacion. -1 = no tocar
local weaponsDamageMultiplier = 0.01			-- Cuánto daño debería recibir el vehículo del fuego de las armas. Rango 0.0 a 10.0, donde 0.0 no es daño y 10.0 es 10x daño. -1 = no tocar
local damageFactorEngine = 10.0					-- Los valores correctos son de 1 a 100. Valores más altos significan más daño al vehículo. Un buen punto de partida es 10
local damageFactorBody = 10.0					-- Los valores correctos son de 1 a 100. Valores más altos significan más daño al vehículo. Un buen punto de partida es 10
local damageFactorPetrolTank = 64.0				-- Los valores correctos son de 1 a 100. Valores más altos significan más daño al vehículo. Un buen punto de partida es 64
local cascadingFailureSpeedFactor = 8.0			-- Los valores correctos son de 1 a 100. Cuando la salud del vehículo cae por debajo de cierto punto, se establece una falla en cascada y la salud cae rápidamente hasta que el vehículo muere. Los valores más altos significan una falla más rápida. Un buen punto de partida es 8
local degradingHealthSpeedFactor = 10			-- Velocidad de salud que se degrada lentamente, pero no falla. El valor de 10 significa que tomará aproximadamente 0.25 segundos por punto de salud, por lo que la degradación de 800 a 305 tomará aproximadamente 2 minutos de conducción limpia.
local degradingFailureThreshold = 800.0			-- Por debajo de este valor, la degradación lenta de la salud se establecerá en
local cascadingFailureThreshold = 360.0			-- Por debajo de este valor, se establecerá una falla de salud en cascada
local engineSafeGuard = 100.0					-- Valor final de falla. Póngalo demasiado alto y el vehículo no fumará cuando esté desactivado. Si se ajusta demasiado bajo, el automóvil se incendiará desde una sola bala al motor. Con la salud 100, un automóvil típico puede llevar de 3 a 4 balas al motor antes de incendiarse.
local displayBlips = true						-- Mostrar blips para ubicaciones de mecánicos


-- id=446 id=72
local mechanics = {
	{name="Mechanic", id=446, r=25.0, x=-337.0,  y=-135.0,  z=39.0},	-- LSC Burton
	{name="Mechanic", id=446, r=25.0, x=-1155.0, y=-2007.0, z=13.0},	-- LSC by airport
	{name="Mechanic", id=446, r=25.0, x=734.0,   y=-1085.0, z=22.0},	-- LSC La Mesa
	{name="Mechanic", id=446, r=25.0, x=1177.0,  y=2640.0,  z=37.0},	-- LSC Harmony
	{name="Mechanic", id=446, r=25.0, x=108.0,   y=6624.0,  z=31.0},	-- LSC Paleto Bay
	{name="Mechanic", id=446, r=18.0, x=538.0,   y=-183.0,  z=54.0},	-- Mechanic Hawic
	{name="Mechanic", id=446, r=15.0, x=1774.0,  y=3333.0,  z=41.0},	-- Mechanic Sandy Shores Airfield
	{name="Mechanic", id=446, r=15.0, x=1143.0,  y=-776.0,  z=57.0},	-- Mechanic Mirror Park
	{name="Mechanic", id=446, r=30.0, x=2508.0,  y=4103.0,  z=38.0},	-- Mechanic East Joshua Rd.
	{name="Mechanic", id=446, r=16.0, x=2006.0,  y=3792.0,  z=32.0},	-- Mechanic Sandy Shores gas station
	{name="Mechanic", id=446, r=25.0, x=484.0,   y=-1316.0, z=29.0},	-- Hayes Auto, Little Bighorn Ave.
	{name="Mechanic", id=446, r=33.0, x=-1419.0, y=-450.0,  z=36.0},	-- Hayes Auto Body Shop, Del Perro
	{name="Mechanic", id=446, r=33.0, x=268.0,   y=-1810.0, z=27.0},	-- Hayes Auto Body Shop, Davis
--	{name="Mechanic", id=446, r=24.0, x=288.0,   y=-1730.0, z=29.0},	-- Hayes Auto, Rancho (Disabled, looks like a warehouse for the Davis branch)
	{name="Mechanic", id=446, r=27.0, x=1915.0,  y=3729.0,  z=32.0},	-- Otto's Auto Parts, Sandy Shores
	{name="Mechanic", id=446, r=45.0, x=-29.0,   y=-1665.0, z=29.0},	-- Mosley Auto Service, Strawberry
	{name="Mechanic", id=446, r=44.0, x=-212.0,  y=-1378.0, z=31.0},	-- Glass Heroes, Strawberry
	{name="Mechanic", id=446, r=33.0, x=258.0,   y=2594.0,  z=44.0},	-- Mechanic Harmony
	{name="Mechanic", id=446, r=18.0, x=-32.0,   y=-1090.0, z=26.0},	-- Simeons
	{name="Mechanic", id=446, r=25.0, x=-211.0,  y=-1325.0, z=31.0},	-- Bennys
	{name="Mechanic", id=446, r=25.0, x=903.0,   y=3563.0,  z=34.0},	-- Auto Repair, Grand Senora Desert
	{name="Mechanic", id=446, r=25.0, x=437.0,   y=3568.0,  z=38.0}		-- Auto Shop, Grand Senora Desert
}

local fixMessages = {
	"Vuelves a apretar el tapon del aceite... ¿Esto era aqui?",
	"Utilizas un cicle para evitar la fuga del aceite, que profesional",
	"Un poco de cinta por aqui, otro por allá... ¡Perfecto!",
	"Colocas un poco las piezas en mal estado... ¿Aqui no habia unos tornillos?",
	"Pateaste el motor... Esto empieza a sonar",
	"Quitas un poco de oxido del tubo de escape...",
	"Gritas al vehiculo de forma agresiva, el vehiculo se asusta y vuelve a funcionar magicamente... ¡Milagro!"
}
local fixMessageCount = 7
local fixMessagePos = math.random(fixMessageCount)

local noFixMessages = {
	"Revisaste el tapón de aceite. Todavía está ahí",
	"Miraste tu motor, parecía estar bien",
	"Te aseguraste de que la cinta adhesiva todavía sujetaba el motor",
	"Subiste el volumen de la radio. Simplemente ahogó los ruidos extraños del motor",
	"Agregaste un producto anticorrosivo al tubo de chispa. No hizo ninguna diferencia",
	"Nunca arreglen algo que no esté roto, dijeron. No escuchaste. Al menos no empeoró"
}
local noFixMessageCount = 6
local noFixMessagePos = math.random(noFixMessageCount)

local pedInVehicleLast=false
local lastVehicle
local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0

local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0

-- Ver marcas en el mapa
Citizen.CreateThread(function()
	if (displayBlips == true) then
	  for _, item in pairs(mechanics) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	  end
	end
end)
  
RegisterNetEvent('iens:repair')
AddEventHandler('iens:repair', function()
	if isPedInVehicle() then
		local ped = GetPlayerPed(-1)		
		local vehicle = GetVehiclePedIsIn(ped, false)
		if IsNearMechanic() then
			SetVehicleUndriveable(vehicle,false)
			SetVehicleFixed(vehicle)
			healthBodyLast=1000.0
			healthEngineLast=1000.0
			healthPetrolTankLast=1000.0
			SetVehicleEngineOn(vehicle, true, false )
			notification("~g~El mecanico te ha reparado el vehiculo... ¡Como nuevo!")
			return
		end
		if GetVehicleEngineHealth(vehicle) < cascadingFailureThreshold + 5 then
			if GetVehicleOilLevel(vehicle) > 0 then
				SetVehicleUndriveable(vehicle,false)
				SetVehicleEngineHealth(vehicle, cascadingFailureThreshold + 5)
				SetVehiclePetrolTankHealth(vehicle, 750.0)
				healthEngineLast=cascadingFailureThreshold +5
				healthPetrolTankLast=750.0
					SetVehicleEngineOn(vehicle, true, false )
				SetVehicleOilLevel(vehicle,(GetVehicleOilLevel(vehicle)/3)-0.5)
				notification("~g~" .. fixMessages[fixMessagePos] .. ", ...Llevalo a un mecanico!")
				fixMessagePos = fixMessagePos + 1
				if fixMessagePos > fixMessageCount then fixMessagePos = 1 end
			else
				notification("~r~Tu vehiculo está para el arrastre... debe de arreglarlo un profesional, ¡Pimpollo!")
			end
		else
			notification("~y~" .. noFixMessages[noFixMessagePos] )
			noFixMessagePos = noFixMessagePos + 1
			if noFixMessagePos > noFixMessageCount then noFixMessagePos = 1 end
		end
	else
		notification("~y~Debes entrar en el vehiculo para intentar repararlo")
	end
end)

RegisterNetEvent('iens:notAllowed')
AddEventHandler('iens:notAllowed', function()
	notification("~r~You don't have permission to repair vehicles")
end)

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

function IsNearMechanic()
	local ped = GetPlayerPed(-1)
	local pedLocation = GetEntityCoords(ped, 0)
	for _, item in pairs(mechanics) do
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  pedLocation["x"], pedLocation["y"], pedLocation["z"], true)
		if distance <= item.r then
			return true
		end
	end
end

function isPedInVehicle()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(ped, false) then
		-- Comprobará el tipo de vehiculo que se mete en el punto	
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local class = GetVehicleClass(vehicle)
			-- No entrará ningun vehiculo que sea aviones (15) helicopteros (16) bicicletas (21) y trenes (13)
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	return false
end


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(50)
		local ped = GetPlayerPed(-1)
		if isPedInVehicle() then
			vehicle = GetVehiclePedIsIn(ped, false)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)
			if healthEngineCurrent == 1000 then healthBodyLast = 1000.0 end
			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * damageFactorEngine
			
			healthBodyCurrent = GetVehicleBodyHealth(vehicle)
			if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * damageFactorBody
			
			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
			if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
			healthPetrolTankNew = healthPetrolTankCurrent 
			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
			healthPetrolTankDeltaScaled = healthPetrolTankDelta * damageFactorPetrolTank
			
			if healthEngineCurrent > engineSafeGuard+1 then
				SetVehicleUndriveable(vehicle,false)
			end

			if healthEngineCurrent <= engineSafeGuard+1 then
				SetVehicleUndriveable(vehicle,true)
			end


			if pedInVehicleLast == true then
				-- El daño ocurrió mientras estaba en el automóvil, se puede multiplicar

				-- Solo haga cálculos si hay algún daño presente en el automóvil. Previene comportamientos extraños al arreglar usando el fix u otro script

				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then

					-- Combina los valores delta
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled, healthPetrolTankDeltaScaled)

					-- Si hay un daño enorme, reduzca un poco
					if healthEngineCombinedDelta > (healthEngineCurrent - engineSafeGuard) then
						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
					end

					-- Si el daño es completo, pero no catastrófico (es decir, territorio de explosión), retroceda un poco, para dar un par de segundos de tiempo de funcionamiento del motor antes de morir.
					if healthEngineCombinedDelta > healthEngineCurrent then
						healthEngineCombinedDelta = healthEngineCurrent - (cascadingFailureThreshold / 5)
					end



					------- Calcular nuevo valor

					healthEngineNew = healthEngineLast - healthEngineCombinedDelta


					------- CONTROL DE DANYOS

					-- Si esta un poco dañazo el vehiculo va bajando muy lentamente la salud.

					if healthEngineNew > (cascadingFailureThreshold + 5) and healthEngineNew < degradingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.038 * degradingHealthSpeedFactor)
					end
	
					-- Si el daño es critico va bajando poco a poco la salud del vehiculo
					if healthEngineNew < cascadingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.1 * cascadingFailureSpeedFactor)
					end

					-- Evita que la vida del motor llegue a 0, así se puede volver a entrar al vehiculo
					if healthEngineNew < engineSafeGuard then
						healthEngineNew = engineSafeGuard 
					end

					-- Evita las explosiones del vehiculo, si el valor es menor a 750 el vehiculo puede explotar
					if healthPetrolTankCurrent < 750 then
						healthPetrolTankNew = 750.0
					end

					-- Previene daños del vehiculo negativos. (evita explosiones del mismo)
					if healthBodyNew < 0  then
						healthBodyNew = 0.0
					end
				end
			else
				-- Acabo de subir al vehículo. El daño no se puede multiplicar esta ronda

				-- Establecer datos de manejo del vehículo
				if deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', deformationMultiplier) end
				if weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', weaponsDamageMultiplier/damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody
				
				-- Si el daño del vehiculo es total, lo reinicia un poco para que podamos multiplicar el daño.
				if healthBodyCurrent < cascadingFailureThreshold then
					healthBodyNew = cascadingFailureThreshold
				end
				pedInVehicleLast = true
			end

			-- establece los nuevos valores reales
			if healthEngineNew ~= healthEngineCurrent then SetVehicleEngineHealth(vehicle, healthEngineNew) end
			if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
			if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end

			-- Almacena los valores actuales, para que podamos calcular delta la próxima vez
			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			healthPetrolTankLast = healthPetrolTankNew
			lastVehicle=vehicle
		else
			if pedInVehicleLast == true then
				-- Acabamos de salir del auto
				if weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor	
			end
			pedInVehicleLast = false
		end
	end
end)

