-- Branding!
local label = [[^5RocketCAD by Modern Solutions]]

function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

PerformHttpRequest( "https://therocketcad.com/integration-version.txt", function( err, text, headers )
	Citizen.Wait( 1000 )
	print( label )
	local currentVersion = GetCurrentVersion()

	if ( text ~= nil ) then
		print( "Your version: " .. currentVersion )
		print( "Latest version: " .. text .."\n" )

		if ( text ~= currentVersion ) then
			print( "^3Your RocketCAD Integration script is out of date. Please update by going to modsol.co/rc-update^0  \n" )
		else
			print( "^2RocketCAD Integration is up to date!^0 \n" )
		end
	else
		print( "^1There was an error getting the latest version information, if this continues please reach out to us using therocketcad.com/support^0 \\\\n" )
	end
end )
