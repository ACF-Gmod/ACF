--define the class
ACF_defineGunClass("RAC", {
	spread = 0.44,
	name = "Rotary Autocannon",
	desc = "Rotary Autocannons sacrifice weight, bulk and accuracy over classic Autocannons to get the highest rate of fire possible.",
	muzzleflash = "50cal_muzzleflash_noscale",
	rofmod = 0.07,
	sound = "weapons/acf_gun/mg_fire3.wav",
	soundDistance = " ",
	soundNormal = " ",
	color = {135, 135, 135}
} )

--[[ not officially added atm because too easy to abuse.  perhaps add in a future update when its possible to limit it.
ACF_defineGun("14.5mmRAC", { --id
	name = "14.5mm Rotary Autocannon",
	desc = "Best used as anti-infantry or light AA, as it's questionably effective against anything but the lightest of armor. Suffers from an extended cooldown period between bursts to avoid overheating the barrels.",
	model = "models/rotarycannon/kw/14_5mmrac.mdl",
	gunclass = "RAC",
	caliber = 1.45,
	weight = 589,
	year = 1962,
	magsize = 48,
	magreload = 12,
	rofmod = 4.54,
	round = {
		maxlength = 23,
		propweight = 0.06
	}
} )
]]--

ACF_defineGun("20mmRAC", { --id
	name = "20mm Rotary Autocannon",
	desc = "The 20mm is able to chew up light armor with decent penetration or put up a big flak screen. Typically mounted on ground attack aircraft, SPAAGs and the ocassional APC. Suffers from a moderate cooldown period between bursts to avoid overheating the barrels.",
	model = "models/rotarycannon/kw/20mmrac.mdl",
	gunclass = "RAC",
	caliber = 2.0,
	weight = 974,
	year = 1965,
	magsize = 48,
	magreload = 10,
	rofmod = 2.05,
	round = {
		maxlength = 30,
		propweight = 0.12
	}
} )

ACF_defineGun("30mmRAC", {
	name = "30mm Rotary Autocannon",
	desc = "The 30mm is the bane of ground-attack aircraft, able to tear up light armor without giving one single fuck.  Also seen in the skies above dead T-72s.  Has a moderate cooldown period between bursts to avoid overheating the barrels.",
	model = "models/rotarycannon/kw/30mmrac.mdl",
	gunclass = "RAC",
	caliber = 3.0,
	weight = 1863,
	year = 1975,
	magsize = 60,
	magreload = 8,
	rofmod = 0.884,
	round = {
		maxlength = 40,
		propweight = 0.350
	}
} )
