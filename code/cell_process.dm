




/obj/move/attack_hand(mob/user)
	if(!user:canmove || (user:restrained() || !user:pulling)) return
	if(user:pulling:anchored) return
	if(user:pulling:loc != user:loc && get_dist(user, user:pulling) > 1) return



	if(ismob(user:pulling))
		var/M = user:pulling
		var/t = M:pulling
		M:pulling = null
		step(user:pulling, get_dir(user:pulling:loc, src))
		M:pulling = t
	else
		step(user:pulling, get_dir(user:pulling:loc, src))
/obj/move/proc/res_vars()
	oldoxy = oxygen
	tmpoxy = oxygen

	oldpoison = poison
	tmppoison = poison

	oldco2 = co2
	tmpco2 = co2

	osl_gas = sl_gas
	tsl_gas = sl_gas

	on2 = n2
	tn2 = n2

	oheat = heat
	theat = heat
/obj/move/proc/relocate(turf/T, degree)
	if(degree)
		for(var/atom/movable/A in loc)
			A:dir = turn(A:dir, degree)
	else
		for(var/atom/movable/A in loc)
			A:loc = T

/obj/move/floor
	icon_state = "floor"
/obj/move/wall
	icon_state = "wall"
	opacity = 1; density = 1
	updatecell = 0
/obj/move/wall/New()
	var/F = locate(/obj/move/floor) in loc
	if(F) del(F)
/obj/move/wall/process()
	updatecell = 0
	return



/obj/move
	var/oxygen = 1000
	var/oldoxy
	var/tmpoxy
	var/oldpoison
	var/tmppoison
	var/poison = 0
	var/co2 = 0
	var/oldco2
	var/tmpco2
	var/sl_gas = 0
	var/osl_gas
	var/tsl_gas
	var/n2 = 0
	var/on2
	var/tn2
	var/heat = 264700
	var/oheat = 264700
	var/theat = 264700
	var/firelevel = 0
	var/airdir
	var/airforce
	var/checkfire = 1

	icon = 'shuttle.dmi'
	anchored = 1
/obj/move/New()
	if((x & 1) == (y & 1))
		checkfire = 0
	tmpoxy = oxygen
	oldoxy = oxygen
	tmppoison = poison
	oldpoison = poison
	tmpco2 = co2
	oldco2 = co2
	oheat = 264700
	theat = 264700
	..()
/obj/move/proc/unburn() icon_state = initial(icon_state)
/obj/move/proc/Neighbors()
	var/L = list(NORTH, SOUTH, EAST, WEST)
	for(var/obj/machinery/door/window/D in loc)
		if(!D:density) goto label1
		if(D:dir & 12)
			L -= SOUTH
		else
			L -= EAST
		label1
	for(var/obj/window/D in loc)
		if(!D:density) goto label2
		L -= D:dir
		if(D:dir == SOUTHWEST)
			L:len = null
			return L
		label2
	return L
/obj/move/proc/FindTurfs()
	var/L = list()
	for(var/dir in Neighbors())
		var/T = get_step(loc, dir)
		if(!T)
			goto label1
		L += T
		for(var/obj/machinery/door/window/D in T)
			if(!D:density) goto label2
			var/direct = get_dir(src, T)
			if(D:dir & 12 && direct & 1)
				L -= T
				goto label2
			else if(direct & 8)
				L -= T
				goto label2
			label2
		for(var/obj/window/D in T)
			if(!D:density) goto label3
			var/direct = get_dir(T, loc)
			if(D:dir == SOUTHWEST)
				L -= T
				goto label3
			else if(direct == D:dir)
				L -= T
				goto label3
			label3
		label1
		if((locate(/obj/move) in T) && L:Find(T))
			L -= T
			var/O = locate(/obj/move) in T
			if(O:updatecell) L += O
		else
			if(!T:updatecell)
				L -= T
	return L

/obj/move/proc/process()
	if(locate(/obj/shuttle/door) in loc)
		var/D = locate(/obj/shuttle/door) in loc
		updatecell = !D:density
		if(!updatecell) return
	checkfire = !checkfire
	if(checkfire)
		if(cellcontrol:var_swap)
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			var/burn = firelevel >= 10
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					break
				divideby++
				total += T:oldoxy
				tpoison += T:oldpoison
				tco2 += T:oldco2
				tosl_gas += T:osl_gas
				ton2 += T:on2
				toheat += T:oheat
				if(T:firelevel >= 100) burn = 1
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(poison > 200)
				overlays = list(plmaster)
			else if(sl_gas > 5)
				overlays = list(slmaster)
			else
				overlays = null
			if(burn) firelevel = oxygen + poison
			if(firelevel >= 100)
				icon_state = "burning"
				if(oxygen > 50)
					co2 += 25
					oxygen -= 50
				else
					oxygen = 0
				poison = max(0, poison - 10)
				if(locate(/obj/machinery/atmoalter/canister) in loc)
					for(var/obj/machinery/atmoalter/canister/C in src.loc)
						C:health = max(C:health - firelevel, 0)
						C:healthcheck()
				if(locate(/obj/effects/water) in loc)
					firelevel = 0
				var/A = loc:loc
				if(!istype(A, /area)) goto label1
				for(var/obj/machinery/firealarm/F in loc)
					if(F:working && F:detecting)
						A:firealert()
						break
			else
				firelevel = 0
				if(icon_state == "burning")
					unburn()
			label1
			tmpoxy = oxygen
			tmppoison = poison
			tmpco2 = co2
			tsl_gas = sl_gas
			tn2 = n2
			theat = heat
		else
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			var/burn = firelevel >= 10
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					break
				divideby++
				total += T:tmpoxy
				tpoison += T:tmppoison
				tco2 += T:tmpco2
				tosl_gas += T:tsl_gas
				ton2 += T:tn2
				toheat += T:theat
				if(T:firelevel >= 100) burn = 1
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(poison > 200)
				overlays = list(plmaster)
			else if(sl_gas > 5)
				overlays = list(slmaster)
			else
				overlays = null
			if(burn) firelevel = oxygen + poison
			if(firelevel >= 100)
				icon_state = "burning"
				if(oxygen > 50)
					co2 += 25
					oxygen -= 50
				else
					oxygen = 0
				poison = max(0, poison - 10)
				co2 += 25
				if(locate(/obj/machinery/atmoalter/canister) in loc)
					for(var/obj/machinery/atmoalter/canister/C in src.loc)
						C:health = max(C:health - firelevel, 0)
						C:healthcheck()
				if(locate(/obj/effects/water) in src)
					firelevel = 0
				var/A = loc:loc
				if(!istype(A, /area)) goto label2
				for(var/obj/machinery/firealarm/F in loc)
					if(F:working && F:detecting)
						A:firealert()
						break
			else if(icon_state == "burning")
				firelevel = 0
				unburn()
			label2
			oldoxy = oxygen
			oldpoison = poison
			oldco2 = co2
			osl_gas = sl_gas
			on2 = n2
			oheat = heat
	else
		if(cellcontrol:var_swap)
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			airdir = null
			airforce = 0
			var/adiff
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					airforce = oxygen + poison + co2 + 50
					airdir = get_dir(src, T)
					break
				divideby++
				total += T:oldoxy
				tpoison += T:oldpoison
				tco2 += T:oldco2
				tosl_gas += T:osl_gas
				ton2 += T:on2
				toheat += T:oheat
				adiff = oldoxy + oldco2 - (T:oldoxy + T:oldco2)
				if(adiff > airforce)
					airforce = adiff
					airdir = get_dir(src, T)
			if(airforce > 50)
				for(var/atom/movable/AM in src.loc)
					if(!AM:anchored && AM:weight <= airforce)
						spawn(0) step(AM, airdir)
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(co2 >= poison)
				co2 -= poison
				oxygen += poison
				poison = 0
			else
				poison -= co2
				oxygen += co2
				co2 = 0

			tmpoxy = oxygen
			tmppoison = poison
			tmpco2 = co2
			tsl_gas = sl_gas
			tn2 = n2
			theat = heat
		else
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			airdir = null
			airforce = 0
			var/adiff
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					airforce = oxygen + poison + co2 + 50
					airdir = get_dir(src, T)
					break
				divideby++
				total += T:tmpoxy
				tpoison += T:tmppoison
				tco2 += T:tmpco2
				tosl_gas += T:tsl_gas
				ton2 += T:tn2
				toheat += T:theat
				adiff = tmpoxy + tmpco2 - (T:tmpoxy + T:tmpco2)
				if(adiff > airforce)
					airforce = adiff
					airdir = get_dir(src, T)
			if(airforce > 50)
				for(var/atom/movable/AM in src.loc)
					if(!AM:anchored && AM:weight <= airforce)
						spawn(0) step(AM, airdir)
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(co2 >= poison)
				co2 -= poison
				oxygen += poison
				poison = 0
			else
				poison -= co2
				oxygen += co2
				co2 = 0

			oldoxy = oxygen
			oldpoison = poison
			oldco2 = co2
			osl_gas = sl_gas
			on2 = n2
			oheat = heat
	if((locate(/obj/effects/water) in loc) || firelevel < 100)
		firelevel = 0
var/datum/control/cellular/cellcontrol
var/datum/control/gameticker/ticker
var/data_core
var/plmaster
var/slmaster




/obj/move
	var/updatecell = 1
/turf/proc/res_vars()
	oldoxy = oxygen
	tmpoxy = oxygen

	oldpoison = poison
	tmppoison = poison

	oldco2 = co2
	tmpco2 = co2

	osl_gas = sl_gas
	tsl_gas = sl_gas

	on2 = n2
	tn2 = n2

	oheat = heat
	theat = heat

/turf
	var/firelevel
	var/oxygen = 1000
	var/oldoxy
	var/tmpoxy
	var/oldpoison
	var/tmppoison
	var/poison = 0
	var/co2 = 0
	var/oldco2
	var/tmpco2
	var/sl_gas = 0
	var/osl_gas
	var/tsl_gas
	var/n2 = 0
	var/on2
	var/tn2
	var/heat = 264700
	var/oheat = 264700
	var/theat = 264700
	var/airdir
	var/airforce
	var/checkfire = 1
	var/atmoalt

	icon = 'turfs.dmi'
	level = 1
/turf/New()
	if((x & 1) == (y & 1))
		checkfire = 0
	tmpoxy = oxygen
	oldoxy = oxygen
	tmppoison = poison
	oldpoison = poison
	tmpco2 = co2
	oldco2 = co2
	osl_gas = sl_gas
	tsl_gas = sl_gas
	on2 = n2
	tn2 = n2
	oheat = heat
	theat = heat
	..()
/turf/proc/unburn() icon_state = initial(icon_state)
/turf/proc/Neighbors()
	var/L = list(NORTH, SOUTH, EAST, WEST)
	for(var/obj/machinery/door/window/D in src)
		if(!D:density) goto label1
		if(D:dir & 12)
			L -= SOUTH
		else
			L -= EAST
		label1
	for(var/obj/window/D in src)
		if(!D:density) goto label2
		L -= D:dir
		if(D:dir == SOUTHWEST)
			L:len = null
			return L
		label2
	return L
/turf/proc/FindTurfs()
	var/L = list()
	if(locate(/obj/move) in src) return list()
	for(var/dir in Neighbors())
		var/T = get_step(src, dir)
		if(!T || !T:updatecell)
			goto label1
		L += T
		for(var/obj/machinery/door/window/D in T)
			if(!D:density) goto label2
			var/direct = get_dir(src, T)
			if(D:dir & 12 && direct & 1)
				L -= T
				goto label2
			else if(direct & 8)
				L -= T
				goto label2
			label2
		for(var/obj/window/D in T)
			if(!D:density) goto label3
			var/direct = get_dir(T, src)
			if(D:dir == SOUTHWEST)
				L -= T
				goto label3
			else if(direct == D:dir)
				L -= T
				goto label3
			label3
		label1
	for(var/T as turf in L)
		if(locate(/obj/move) in T)
			L -= T
			var/O = locate(/obj/move) in T
			if(O:updatecell) L += O
	return L





































/turf/updatecell()
	checkfire = !checkfire
	if(checkfire)
		if(cellcontrol:var_swap)
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			var/burn = firelevel >= 10
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					break
				divideby++
				total += T:oldoxy
				tpoison += T:oldpoison
				tco2 += T:oldco2
				tosl_gas += T:osl_gas
				ton2 += T:on2
				toheat += T:oheat
				if(T:firelevel >= 100) burn = 1
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(poison > 200)
				overlays = list(plmaster)
			else if(sl_gas > 5)
				overlays = list(slmaster)
			else
				overlays = null
			if(burn) firelevel = oxygen + poison
			if(firelevel >= 100)
				icon_state = "burning"
				if(oxygen > 50)
					co2 += 25
					oxygen -= 50
				else
					oxygen = 0
				poison = max(0, poison - 10)
				co2 += 25
				if(locate(/obj/effects/water) in src)
					firelevel = 0
				for(var/atom/movable/A in src)
					A:burn(firelevel)
			else
				firelevel = 0
				if(icon_state == "burning")
					unburn()
			tmpoxy = oxygen
			tmppoison = poison
			tmpco2 = co2
			tsl_gas = sl_gas
			tn2 = n2
			theat = heat
		else
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			var/burn = firelevel >= 10
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					break
				divideby++
				total += T:tmpoxy
				tpoison += T:tmppoison
				tco2 += T:tmpco2
				tosl_gas += T:tsl_gas
				ton2 += T:tn2
				toheat += T:theat
				if(T:firelevel >= 100) burn = 1
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(poison > 200)
				overlays = list(plmaster)
			else if(sl_gas > 5)
				overlays = list(slmaster)
			else
				overlays = null
			if(burn) firelevel = oxygen + poison
			if(firelevel >= 100)
				icon_state = "burning"
				if(oxygen > 50)
					co2 += 25
					oxygen -= 50
				else
					oxygen = 0
				poison = max(0, poison - 10)
				co2 += 25
				if(locate(/obj/effects/water) in src)
					firelevel = 0
				for(var/atom/movable/A in src)
					A:burn(firelevel)
			else if(icon_state == "burning")
				firelevel = 0
				unburn()
			oldoxy = oxygen
			oldpoison = poison
			oldco2 = co2
			osl_gas = sl_gas
			on2 = n2
			oheat = heat
	else
		if(cellcontrol:var_swap)
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			airdir = null
			airforce = 0
			var/adiff
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					airforce = oxygen + poison + co2 + 50
					airdir = get_dir(src, T)
					break
				divideby++
				total += T:oldoxy
				tpoison += T:oldpoison
				tco2 += T:oldco2
				tosl_gas += T:osl_gas
				ton2 += T:on2
				toheat += T:oheat
				adiff = oldoxy + oldco2 - (T:oldoxy + T:oldco2)
				if(adiff > airforce)
					airforce = adiff
					airdir = get_dir(src, T)
			if(airforce > 50)
				for(var/atom/movable/AM in src)
					if(!AM:anchored && AM:weight <= airforce)
						spawn(0) step(AM, airdir)
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(co2 >= poison)
				co2 -= poison
				oxygen += poison
				poison = 0
			else
				poison -= co2
				oxygen += co2
				co2 = 0

			tmpoxy = oxygen
			tmppoison = poison
			tmpco2 = co2
			tsl_gas = sl_gas
			tn2 = n2
			theat = heat
		else
			var/divideby = 1
			var/total = oxygen
			var/tpoison = poison
			var/tco2 = co2
			var/tosl_gas = sl_gas
			var/ton2 = n2
			var/toheat = heat
			var/space = 0
			airdir = null
			airforce = 0
			var/adiff
			for(var/S in src.FindTurfs())
				var/T = S
				if(istype(T, /turf/space))
					space = 1
					airforce = oxygen + poison + co2 + 50
					airdir = get_dir(src, T)
					break
				divideby++
				total += T:tmpoxy
				tpoison += T:tmppoison
				tco2 += T:tmpco2
				tosl_gas += T:tsl_gas
				ton2 += T:tn2
				toheat += T:theat
				adiff = tmpoxy + tmpco2 - (T:tmpoxy + T:tmpco2)
				if(adiff > airforce)
					airforce = adiff
					airdir = get_dir(src, T)
			if(airforce > 50)
				for(var/atom/movable/AM in src)
					if(!AM:anchored && AM:weight <= airforce)
						spawn(0) step(AM, airdir)
			if(space)
				oxygen = 0
				poison = 0
				co2 = 0
				sl_gas = 0
				n2 = 0
				heat = 0
			else
				oxygen = total / divideby
				poison = tpoison / divideby
				co2 = tco2 / divideby
				sl_gas = tosl_gas / divideby
				n2 = ton2 / divideby
				heat = toheat / divideby
			if(sl_gas > 0) sl_gas--
			if(co2 >= poison)
				co2 -= poison
				oxygen += poison
				poison = 0
			else
				poison -= co2
				oxygen += co2
				co2 = 0

			oldoxy = oxygen
			oldpoison = poison
			oldco2 = co2
			osl_gas = sl_gas
			on2 = n2
			oheat = heat
	if((locate(/obj/effects/water) in src) || firelevel < 100)
		firelevel = 0
