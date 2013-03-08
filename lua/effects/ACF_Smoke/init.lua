
   
 /*--------------------------------------------------------- 
    Initializes the effect. The data is a table of data  
    which was passed from the server. 
 ---------------------------------------------------------*/ 
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = data:GetNormal()
	self.Radius = math.max(data:GetRadius()/50,1)
	self.Emitter = ParticleEmitter( self.Origin )
	
	local ImpactTr = { }
		ImpactTr.start = self.Origin - self.DirVec*20
		ImpactTr.endpos = self.Origin + self.DirVec*20
	local Impact = util.TraceLine(ImpactTr)					--Trace to see if it will hit anything
	self.Normal = Impact.HitNormal
	
	local GroundTr = { }
		GroundTr.start = self.Origin + Vector(0,0,1)
		GroundTr.endpos = self.Origin - Vector(0,0,1)*self.Radius*20
		GroundTr.mask = 131083
	local Ground = util.TraceLine(GroundTr)				
	
	local SmokeColor = Vector(255,255,255)
	if Ground.HitWorld then
		self:Shockwave( Ground, SmokeColor )
	end

 end   
 
function EFFECT:Core()
		

	
	for i=0, 2*self.Radius do
		local Whisp = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Origin )
			if (Whisp) then
				Whisp:SetVelocity(VectorRand() * math.random( 150,250*self.Radius) )
				Whisp:SetLifeTime( 0 )
				Whisp:SetDieTime( math.Rand( 3 , 5 )*self.Radius/3  )
				Whisp:SetStartAlpha( math.Rand( 0, 0 ) )
				Whisp:SetEndAlpha( 0 )
				Whisp:SetStartSize( 10*self.Radius )
				Whisp:SetEndSize( 80*self.Radius )
				Whisp:SetRoll( math.Rand(150, 360) )
				Whisp:SetRollDelta( math.Rand(-0.2, 0.2) )			
				Whisp:SetAirResistance( 100 ) 			 
				Whisp:SetGravity( Vector( math.random(-5,5)*self.Radius, math.random(-5,5)*self.Radius, 0 ) ) 			
				Whisp:SetColor( 150,150,150 )
			end
	end
	

	sound.Play( "ambient/explosions/explode_5.wav", self.Origin , math.Clamp(self.Radius*10,75,165), math.Clamp(300 - self.Radius*12,15,255))
	sound.Play( "ambient/explosions/explode_4.wav", self.Origin , math.Clamp(self.Radius*10,75,165), math.Clamp(300 - self.Radius*25,15,255))
	
end

function EFFECT:Shockwave( Ground, SmokeColor )

	local Mat = Ground.MatType
	local Radius = (1-Ground.Fraction)*self.Radius
	local Density = 7*Radius
	local Angle = Ground.HitNormal:Angle()
	for i=0, Density do	
		
		Angle:RotateAroundAxis(Angle:Forward(), (360/Density))
		local ShootVector = Angle:Up()
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), Ground.HitPos )
		if (Smoke) then
			Smoke:SetVelocity( ShootVector * math.Rand(5,200*Radius) )
			Smoke:SetLifeTime( 0 )
			Smoke:SetDieTime( math.Rand( 20 , 20 )*Radius /3 )
			Smoke:SetStartAlpha( math.Rand( 10, 30 ) )
			Smoke:SetEndAlpha( 0 )
			Smoke:SetStartSize( 200*Radius )
			Smoke:SetEndSize( 500*Radius )
			Smoke:SetRoll( math.Rand(0, 360) )
			Smoke:SetRollDelta( math.Rand(-0.2, 0.2) )			
			Smoke:SetAirResistance( 200 ) 			 
			Smoke:SetGravity( Vector( math.Rand( -20 , 20 ), math.Rand( -20 , 20 ), math.Rand( 10 , 100 ) ) )			
			Smoke:SetColor( SmokeColor.x,SmokeColor.y,SmokeColor.z )
		end	
	
	end

end

   
/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
		
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
end

 
