local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Benny's Original Motor Works", colour=5, id=446, x = -205.38, y = -1310.13, z = 31.3},
     {title="Departamento Sheriff", colour=1, id=60, x = 826.91, y = -1289.95, z = 28.24},
     {title="Departamento FIB", colour=4, id=60, x = 62.2, y = -732.83, z = 43.55},
     {title="Salon de bodas", colour=5, id=176, x = -1545.62, y = 115.96, z = 56.3},
     {title="Bahama", colour=3, id=93, x = -1388.22, y = -586.85, z = 30.22}
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)