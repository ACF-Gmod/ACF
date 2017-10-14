--define the class
ACF_defineGunClass("HMG", {
	spread = 0.4,
	name = "Heavy Machinegun",
	desc = "Designed as autocannons for aircraft, HMGs are rapid firing, lightweight, and compact but sacrifice accuracy, magazine size, and reload times.  They excel at strafing and other situations where there isn't a lot of time on target.",
	muzzleflash = "50cal_muzzleflash_noscale",
	rofmod = 0.17, --was 0.29
	sound = "weapons/ACF_Gun/mg_fire3.wav",
	soundDistance = " ",
	soundNormal = " ",
	longbarrel = {
		index = 2, 
		submodel = 4, 
		newpos = "muzzle2"
	}
} )

--add a gun to the class
ACF_defineGun("20mmHMG", { --id
	name = "20mm Heavy Machinegun",
	desc = "The lightest of the HMGs, the 20mm has a rapid fire rate but suffers from poor payload size.  Often used to strafe ground troops or annoy low-flying aircraft.",
	model = "models/machinegun/machinegun_20mm_compact.mdl",
	gunclass = "HMG",
	caliber = 2.0,
	weight = 160,
	year = 1935,
	rofmod = 1.5,
	magsize = 12,
	magreload = 8,
	round = {
		maxlength = 30,
		propweight = 0.12
	}
} )

ACF_defineGun("30mmHMG", {
	name = "30mm Heavy Machinegun",
	desc = "30mm shell chucker, light and compact. Your average heavy aircraft autocannon.",
	model = "models/machinegun/machinegun_30mm_compact.mdl",
	gunclass = "HMG",
	caliber = 3.0,
	weight = 480,
	year = 1941,
	rofmod = 1.2,
	magsize = 10,
	magreload = 10,
	round = {
		maxlength = 37,
		propweight = 0.35
	}
} )

ACF_defineGun("40mmHMG", {
	name = "40mm Heavy Machinegun",
	desc = "The heaviest of the heavy machineguns.  Massively powerful with a killer reload and heft ammunition requirements.",
	model = "models/machinegun/machinegun_40mm_compact.mdl",
	gunclass = "HMG",
	caliber = 4.0,
	weight = 740,
	year = 1955,
	rofmod = 0.9,
	magsize = 8,
	magreload = 13,
	round = {
		maxlength = 42,
		propweight = 0.9
	}
} )
	
