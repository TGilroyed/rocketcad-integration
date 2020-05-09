-- Branding!
local label = [[ RocketCAD by Modern Solutions ]]

function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end 

PerformHttpRequest( "https://wolfknight98.github.io/wk_wars2x_web/version.txt", function( err, text, headers )
	Citizen.Wait( 1000 )
	print( label )
	local Version = GetCurrentVersion()
	
	if ( text ~= nil ) then 
		print( "  ||    Current version: " .. Version )
		print( "  ||    Latest recommended version: " .. text .."\n  ||" )
		
		if ( text ~= Version ) then
			print( "  ||    ^1Your Wraith ARS 2X version is outdated, visit the FiveM forum post to get the latest version.\n^0  \\\\\n" )
		else
			print( "  ||    ^2Wraith ARS 2X is up to date!\n^0  ||\n  \\\\\n" )
		end
	else 
		print( "  ||    ^1There was an error getting the latest version information, if the issue persists contact WolfKnight#8586 on Discord.\n^0  ||\n  \\\\\n" )
	end 
end )