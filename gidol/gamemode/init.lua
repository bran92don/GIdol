//DeriveGamemode( "sandbox" )

include( "shared.lua" )



function GM:PlayerConnect( name, ip )
	print("Player:"..name.. ", has joined the game with the ip:"..ip)

end





function GM:PlayerInitialSpawn( ply )

 
self.BaseClass:PlayerInitialSpawn( ply )
print("Player:"..ply:Nick().. ", has spawned.")
	
	
	//Testing purposes CHANGE BACK AFTER YOUR DONE DIGI 
	ply:SetTeam(3)
	ply:SetGravity( 1 )


end



function GM:PlayerSpawn( ply )
ply:SetTeam(3)



	ply:StripWeapons()
	
	//da hands
	  local oldhands = ply:GetHands()
		if ( IsValid( oldhands ) ) then oldhands:Remove() end
		
		local hands = ents.Create( "gmod_hands" )
			if ( IsValid( hands ) ) then
				ply:SetHands( hands )
				hands:SetOwner( ply )
			
				-- Which hands should we use?
				local cl_playermodel = ply:GetInfo( "cl_playermodel" )
				local info = player_manager.TranslatePlayerHands( cl_playermodel )
				if ( info ) then
					hands:SetModel( info.model )
					hands:SetSkin( info.skin )
					hands:SetBodyGroups( info.body )
				end
			
				-- Attach them to the viewmodel
				local vm = ply:GetViewModel( 0 )
				hands:AttachToViewmodel( vm )
			
				vm:DeleteOnRemove( hands )
				ply:DeleteOnRemove( hands )
			
				hands:Spawn()
			end
	
		self.BaseClass:PlayerSpawn( ply )

			
			//SET MODEL--------------------------
				if ply:Team() == 2 then
					ply:SetModel(model_axis[math.random(1,#model_axis)])
				end
				
				if ply:Team() == 3 then
					ply:SetModel(model_allies[math.random(1,#model_allies)])
				end
			//-----------------------------
			
			ply:SetHealth(100)
			ply:SetMaxHealth( 100, true )
			ply:SetWalkSpeed(180)
			ply:SetRunSpeed(270)
			


	
	
	
	
end




function GM:GetFallDamage( ply, speed )
	speed = speed - 580
    return speed*(100/(1024-580))
end








function GM:PlayerAuthed( ply, steamID, uniqueID )
	print("Player:"..ply:Nick().. ", is authed.")
	//ply:databaseCheck()
end

function GM:PlayerDisconnected( ply )
	PrintMessage( HUD_PRINTTALK, ply:Name().. " Has disconnected" )
	//ply:databaseDisconnect()
end

function GM:PlayerNoClip( ply )
	if not ply:IsAdmin() or not ply:IsSuperAdmin() then
		return false 
	end
	return false
end


function GM:PlayerDeathSound( ply )
	return true 
end





function GM:PlayerSwitchFlashlight( ply)
	return true
end



function GM:PlayerShouldTakeDamage( victim, ply )
	
	
	if ply:IsPlayer() then -- check the attacker is player 
		if( victim:Team() == ply:Team() and GetConVarNumber( "mp_friendlyfire" ) == 0 and victim:UniqueID() != ply:UniqueID()) then -- check the teams are equal and that friendly fire is off.
			return false -- do not damage the player
		end
		
	
	return true -- damage the player
	
		
end
end


//HUD STUFF-------------------------------------------------------------------

//F1 button menu for teams
function GM:ShowTeam( ply )
	umsg.Start( "TeamMenu", ply )
	umsg.End()
end


//F4 Menu
function GM:ShowSpare2( ply )
	umsg.Start( "ClassMenu", ply )
	umsg.End()
end

function GM:ShowHelp( ply )
	umsg.Start( "HelpMenu", ply )
	umsg.End()
end

