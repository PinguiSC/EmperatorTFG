ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)



RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	
--HOMBRE
		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['chain_1'] = 0, ['chain_2'] = 0,
		['decals_1'] = 0, ['decals_2'] = 0,
		['chain_1'] = 0, ['chain_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 61, ['pants_2'] = 1
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
--MUJER
RegisterNetEvent('smerfikubrania:camisetamujer')
AddEventHandler('smerfikubrania:camisetamujer', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['chain_1'] = 0, ['chain_2'] = 0,
		['decals_1'] = 0, ['decals_2'] = 0,
		['chain_1'] = 0, ['chain_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:pantalonmujer')
AddEventHandler('smerfikubrania:pantalonmujer', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 15, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:zapatosmujer')
AddEventHandler('smerfikubrania:zapatosmujer', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 35, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function OpenActionMenuInteraction(target)

	local elements = {}

	table.insert(elements, {label = ('Poner ropa'), value = 'ubie'})
	table.insert(elements, {label = ('Quitar camiseta hombre'), value = 'tul'})
	table.insert(elements, {label = ('Quitar pantalones hombre'), value = 'spo'})
	table.insert(elements, {label = ('Quitar zapatos hombre'), value = 'but'})
	table.insert(elements, {label = ('Quitar camiseta mujer'), value = 'cam'})
	table.insert(elements, {label = ('Quitar pantalones mujer'), value = 'pan'})
	table.insert(elements, {label = ('Quitar zapatos mujer'), value = 'zap'})
  		ESX.UI.Menu.CloseAll()	


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Ropa'),
			align    = 'top-left',
			elements = elements
		},
    function(data, menu)
		
		if data.current.value == 'ubie' then			
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
		--HOMBRE
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'tul' then
		TriggerEvent('smerfikubrania:koszulka')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'spo' then
		TriggerEvent('smerfikubrania:spodnie')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'but' then
		TriggerEvent('smerfikubrania:buty')
		ESX.UI.Menu.CloseAll()
		--MUJER
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'cam' then
		TriggerEvent('smerfikubrania:camisetamujer')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'pan' then
		TriggerEvent('smerfikubrania:pantalonmujer')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'zap' then
		TriggerEvent('smerfikubrania:zapatosmujer')
		ESX.UI.Menu.CloseAll()
		
	  end
	end)

end
	
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustReleased(0, 57) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
		OpenActionMenuInteraction()
    end
  end
end)