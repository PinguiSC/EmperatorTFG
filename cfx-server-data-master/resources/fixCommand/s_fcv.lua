--[[Fix/Clean Vehicle Script -- Fix and clean vehicles with a command
    Copyright (C) 2017  Murtaza

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. ]]--

-- Created by Murtaza || https://forum.fivem.net/u/murfasa/
-- Fix-Clean Vehicle Script v1.2.5

-- SERVERSIDE

----- CONFIG -----
local everyoneAllowed = false -- true = everyone is allowed || false = use steamIDs and IPs listed in allowed

local allowed = 
{
	"steam:110000106159bb5 ", --Edgar.
	"steam:110000106ff105d", --Pingui
	"steam:110000117a58911", --Parra
	"steam:1100001055a5c88" --Nailah
}

-- CODE! Do not touch unless you know what you're doing ;) If you have any suggestions or need help, send me a message

AddEventHandler('chatMessage', function(source, n, msg)
	local msg = string.lower(msg)
	local identifier = GetPlayerIdentifiers(source)[1]
	if msg == "/fix" then
		CancelEvent()
		if everyoneAllowed == true then
			TriggerClientEvent('murtaza:fix', source)
		else
			if checkAllowed(identifier) then
				TriggerClientEvent('murtaza:fix', source)
			else
				TriggerClientEvent('murtaza:noPerms', source)
			end
		end
	elseif msg == "/clean" then 
		CancelEvent()
		if everyoneAllowed == true then
			TriggerClientEvent('murtaza:clean', source)
		else
			if checkAllowed(identifier) then
				TriggerClientEvent('murtaza:clean', source)
			else
				TriggerClientEvent('murtaza:noPerms', source)
			end
		end
	end
end)

function checkAllowed(id)
	for k, v in pairs(allowed) do
		if id == v then
			return true
		end
	end
	
	return false
end