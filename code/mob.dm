var/datum/engine_eject/engine_eject_control
var/main_hud
var/main_hud2
var/ooc_allowed = 1

var/banned = list()

var/dna_ident = 1
var/abandon_allowed = 1
var/shuttle_frozen = 0
var/prison_entered






























/obj/point
	icon_state = "arrow"
	icon = 'screen1.dmi'
	layer = 16
/obj/point/point()
/proc/hsl2rgb(h, s, l)

/proc/stars(n, pr)
	var/te = n
	var/t = ""
	if(!pr)
		n = length(n)
		for(var/p = 1, p < n, p++)
			if(copytext(te, p, p + 1) == " " || prob(25))
				t = "[t][copytext(te, p, p + 1)]"
			else
				t = "[t]*"
	else
		n = length(n)
		for(var/p = 1, p < n, p++)
			if(copytext(te, p, p + 1) == " " || prob(pr))
				t = "[t][copytext(te, p, p + 1)]"
			else
				t = "[t]*"
	return t
/proc/stutter(n)
	var/te = n
	var/t = ""
	n = length(n)
	for(var/p = 1, p <= n, p++)
		var/n_letter = copytext(te, p, p + 1)
		if(prob(80))
			if(prob(10))
				n_letter = "[n_letter][n_letter][n_letter][n_letter]"
			else if(prob(20))
				n_letter = "[n_letter][n_letter][n_letter]"
			else if(prob(5))
				n_letter = null
			else
				n_letter = "[n_letter][n_letter]"
		t = "[t][n_letter]"
	return t
/proc/findname(msg)
	for(var/mob/M in world)
		if(M:rname == "[msg]")
			return 1
	return 0
/obj/dna
	var/spec_identity
	var/r_spec_identity
	var/use_enzyme
	var/struc_enzyme
	var/uni_identity
	var/n_chromo
/obj/dna/proc/cleanup()
	var/e1 = length(struc_enzyme) > 3 ? copytext(struc_enzyme, 1, 4) : null
	if(e1 == "AEC" && length(spec_identity) > n_chromo)
		r_spec_identity = spec_identity
	else if(e1 == "14A")
		var/t1 = rand(1, 3)
		for(var/t, t < t1, t++)
			var/t2 = rand(1, length(use_enzyme) + 1)
			use_enzyme = "[copytext(1, t2)]0[copytext(t2 + 1, length(use_enzyme) + 1)]"
	else if(e1 == "CDE")
		if(length(spec_identity) == length(r_spec_identity))
			spec_identity = r_spec_identity
		else
			r_spec_identity = spec_identity
	else
		spec_identity = r_spec_identity
	n_chromo = length(r_spec_identity)
























/obj/hud/hud2
	h_type = /obj/screen/screen2
/obj/hud
	var/adding
	var/other
	var/intents
	var/mov_int
	var/mon_blo
	var/m_ints
	var/vimpaired
	var/g_dither
	var/blurry
	var/h_type = /obj/screen
/obj/hud/New()
	instantiate()
	..()
/obj/hud/proc/instantiate()
	adding = list()
	other = list()
	intents = list()
	mon_blo = list()
	m_ints = list()
	mov_int = list()
	vimpaired = list()

	g_dither = new h_type(src)
	g_dither:screen_loc = "1,1 to 15,15"
	g_dither:name = "Mask"
	g_dither:icon_state = "dither12g"
	g_dither:layer = 18

	blurry = new h_type(src)
	blurry:screen_loc = "1,1 to 15,15"
	blurry:name = "Blurry"
	blurry:icon_state = "blurry"
	blurry:layer = 17

	var/using = new h_type(src)

	using:name = "vitals"
	using:dir = SOUTH
	using:screen_loc = "15,2 to 15,15"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "actions"
	using:dir = EAST
	using:screen_loc = "4,1 to 14,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:dir = NORTHWEST
	using:screen_loc = "15,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:dir = WEST
	using:screen_loc = "1,3 to 2,3"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:dir = NORTHEAST
	using:screen_loc = "3,3"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:dir = NORTH
	using:screen_loc = "3,2"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:dir = SOUTHEAST
	using:screen_loc = "3,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:dir = SOUTHWEST
	using:screen_loc = "1,1 to 2,2"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "drop"
	using:icon_state = "act_drop"
	using:screen_loc = "7,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "throw"
	using:icon_state = "act_throw"
	using:screen_loc = "9,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "swap"
	using:icon_state = "act_hand"
	using:screen_loc = "11,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "i_clothing"
	using:dir = SOUTH
	using:icon_state = "center"
	using:screen_loc = "2,2"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "o_clothing"
	using:dir = SOUTH
	using:icon_state = "equip"
	using:screen_loc = "2,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "headset"
	using:dir = SOUTHEAST
	using:icon_state = "equip"
	using:screen_loc = "3,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "r_hand"
	using:dir = WEST
	using:icon_state = "equip"
	using:screen_loc = "1,2"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "l_hand"
	using:dir = EAST
	using:icon_state = "equip"
	using:screen_loc = "3,2"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "id"
	using:dir = SOUTHWEST
	using:icon_state = "equip"
	using:screen_loc = "1,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "mask"
	using:dir = NORTH
	using:icon_state = "equip"
	using:screen_loc = "2,3"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "back"
	using:dir = NORTHEAST
	using:icon_state = "equip"
	using:screen_loc = "3,3"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "storage1"
	using:icon_state = "block"
	using:screen_loc = "4,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "storage2"
	using:icon_state = "block"
	using:screen_loc = "5,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "resist"
	using:icon_state = "act_resist"
	using:screen_loc = "13,1"
	using:layer = 19
	adding += using

	using = new h_type(src)
	using:name = "other"
	using:icon_state = "other"
	using:screen_loc = "4,2"
	using:layer = 20
	adding += using

	using = new h_type(src)
	using:name = "intent"
	using:icon_state = "intent"
	using:screen_loc = "14,15"
	using:layer = 20
	adding += using

	using = new h_type(src)
	using:name = "m_intent"
	using:icon_state = "move"
	using:screen_loc = "14,14"
	using:layer = 20
	adding += using

	using = new h_type(src)
	using:name = "gloves"
	using:icon_state = "gloves"
	using:screen_loc = "4,2"
	using:layer = 19
	other += using

	using = new h_type(src)
	using:name = "eyes"
	using:icon_state = "glasses"
	using:screen_loc = "6,2"
	using:layer = 19
	other += using

	using = new h_type(src)
	using:name = "head"
	using:icon_state = "hair"
	using:screen_loc = "7,2"
	using:layer = 19
	other += using

	using = new h_type(src)
	using:name = "shoes"
	using:icon_state = "shoes"
	using:screen_loc = "5,2"
	using:layer = 19
	other += using

	using = new h_type(src)
	using:name = "belt"
	using:icon_state = "belt"
	using:screen_loc = "8,2"
	using:layer = 19
	other += using

	using = new h_type(src)
	using:name = "hurt"
	using:icon_state = "harm"
	using:screen_loc = "14,15"
	using:layer = 19
	intents += using
	m_ints += using

	using = new h_type(src)
	using:name = "disarm"
	using:icon_state = "disarm"
	using:screen_loc = "13,15"
	using:layer = 19
	intents += using

	using = new h_type(src)
	using:name = "help"
	using:icon_state = "help"
	using:screen_loc = "12,15"
	using:layer = 19
	intents += using
	m_ints += using

	using = new h_type(src)
	using:name = "face"
	using:icon_state = "facing"
	using:screen_loc = "14,14"
	using:layer = 19
	mov_int += using

	using = new h_type(src)
	using:name = "walk"
	using:icon_state = "walking"
	using:screen_loc = "13,14"
	using:layer = 19
	mov_int += using

	using = new h_type(src)
	using:name = "run"
	using:icon_state = "running"
	using:screen_loc = "12,14"
	using:layer = 19
	mov_int += using

	using = new h_type(src)
	using:name = "blocked"
	using:icon_state = "x"
	using:screen_loc = "2,2"
	using:layer = 19
	mon_blo += using

	using = new h_type(src)
	using:name = "blocked"
	using:icon_state = "x"
	using:screen_loc = "1,1"
	using:layer = 19
	mon_blo += using

	using = new h_type(src)
	using:name = "blocked"
	using:icon_state = "x"
	using:screen_loc = "2,1"
	using:layer = 19
	mon_blo += using

	using = new h_type(src)
	using:name = "blocked"
	using:icon_state = "x"
	using:screen_loc = "3,1"
	using:layer = 19
	mon_blo += using

	using = new h_type(src)
	using:name = "blocked"
	using:icon_state = "x"
	using:screen_loc = "4,1"
	using:layer = 19
	mon_blo += using

	using = new h_type(src)
	using:name = "blocked"
	using:icon_state = "x"
	using:screen_loc = "5,1"
	using:layer = 19
	mon_blo += using

	using = new h_type(src)
	using:name = null
	using:icon_state = "dither50"
	using:screen_loc = "1,1 to 5,15"
	using:layer = 17
	vimpaired += using

	using = new h_type(src)
	using:name = null
	using:icon_state = "dither50"
	using:screen_loc = "5,1 to 10,5"
	using:layer = 17
	vimpaired += using

	using = new h_type(src)
	using:name = null
	using:icon_state = "dither50"
	using:screen_loc = "6,11 to 10,15"
	using:layer = 17
	vimpaired += using

	using = new h_type(src)
	using:name = null
	using:icon_state = "dither50"
	using:screen_loc = "11,1 to 15,15"
	using:layer = 17
	vimpaired += using


/atom/movable/Move(NewLoc, direct)
	if(direct & direct - 1)
		if(direct & 1)
			if(direct & 4)
				if(step(src, NORTH))
					step(src, EAST)
				else if(step(src, EAST))
					step(src, NORTH)
			else if(direct & 8)
				if(step(src, NORTH))
					step(src, WEST)
				else if(step(src, WEST))
					step(src, NORTH)
		else if(direct & 2)
			if(direct & 4)
				if(step(src, SOUTH))
					step(src, EAST)
				else if(step(src, EAST))
					step(src, SOUTH)
			else if(direct & 8)
				if(step(src, SOUTH))
					step(src, WEST)
				else if(step(src, WEST))
					step(src, SOUTH)
	else ..()
/atom/verb/examine()
	set src in oview(1)
	if(!usr) return
	usr << desc

/atom/movable/verb/pull()
	set src in oview(1)
	if(!usr) return
	if(!anchored)
		usr.pulling = src

/obj/proc/alter_health()
	return 1
/obj/proc/relaymove()
/obj/screen
	icon = 'screen1.dmi'
	layer = 20


/obj/screen/Click()
	switch(name)
		if("other")
			usr.other = !usr.other
		if("intent")
			if(!usr.intent)
				switch(usr.a_intent)
					if("help")
						usr.intent = "12,15"
					if("disarm")
						usr.intent = "13,15"
					if("hurt")
						usr.intent = "14,15"
			else
				usr.intent = null
		if("m_intent")
			if(!usr.m_int)
				switch(usr.m_intent)
					if("run")
						usr.m_int = "12,14"
					if("walk")
						usr.m_int = "13,14"
					if("face")
						usr.m_int = "14,14"
			else
				usr.m_int = null
		if("walk")
			usr.m_intent = "walk"
			usr.m_int = "13,14"
		if("face")
			usr.m_intent = "face"
			usr.m_int = "14,14"
		if("run")
			usr.m_intent = "run"
			usr.m_int = "12,14"
		if("hurt")
			usr.a_intent = "hurt"
			usr.intent = "14,15"
		if("disarm")
			if(istype(usr, /mob/human))
				var/M = usr
				M:a_intent = "disarm"
				M:intent = "13,15"
		if("help")
			usr.a_intent = "help"
			usr.intent = "12,15"
		if("Reset Machine")
			usr.machine = null
		if("internal")
			if(istype(usr, /mob/human))
				var/M = usr
				if(M:stat == 0)
					M:removeinternal()
		if("pull")
			if(istype(usr, /mob/human))
				var/M = usr
				M:removepull()
		if("sleep")
			usr.sleeping = !usr.sleeping
		if("rest")
			usr.resting = !usr.resting
		if("throw")
			usr.throw_item_v()
		if("drop")
			usr.drop_item_v()
		if("swap")
			usr.swap_hand()
		if("resist")
			if(istype(usr, /mob/human))
				var/M = usr
				if(!M:stat && (M:canmove && (!M:restrained() && (M:requests && M:requests:len))))
					for(var/obj/O in M:requests)
						del(O)
					for(var/mob/O in view(usr))
						O:show_message("\red<B>[usr] resists!</B>", 1)
/obj/screen/attack_hand(mob/user, using)
	user:db_click(name, using)
/obj/screen/attack_paw(mob/user, using)
	user:db_click(name, using)
/mob/verb/mode()
	set src = usr
	var/W = equipped()
	if(W) W:attack_self(src)


/client/Northeast()
	mob:swap_hand()
/client/Southeast()
	var/W = mob:equipped()
	if(W) W:attack_self(mob)
/client/Northwest()
	mob:drop_item_v()
/client/Southwest()
	mob:throw_item_v()
/client
	var/move_delay = 1
/client/Center()
	if(isobj(mob:loc))
		var/O = mob:loc
		if(mob:canmove)
			return O:relaymove(mob, 16)
/client/Move(n, direct)
	if(moving) return 0
	if(world.time < move_delay) return
	if(!mob) return
	if(mob:stat == 2) return
	if(mob:canmove)
		var/j_pack = 0
		if(istype(mob:loc, /turf/space) && !(locate(/obj/move) in mob:loc))
			if(!mob:restrained())
				if(!((locate(/obj/grille) in oview(1, mob)) || (locate(/turf/station) in oview(1, mob))))
					if(istype(mob:back, /obj/item/weapon/tank/jetpack))
						var/J = mob:back
						j_pack = J:allow_thrust(100, mob)
						var/I = new /obj/effects/sparks/ion_trails(mob:loc)
						flick("ion_fade", I)
						I:icon_state = "blank"
						spawn(20) del(I)
						if(!j_pack) return 0
					else return 0
			else return 0
		if(isturf(mob:loc))




			move_delay = world.time
			if(j_pack && j_pack < 1)
				move_delay += 5
			switch(mob:m_intent)
				if("run")
					if(mob:drowsyness)
						move_delay += 6
					move_delay += 1
				if("face")
					mob:dir = direct
					return
				if("walk")
					move_delay += 7
			move_delay += mob:m_delay()
			move_delay += round((100 - mob:health) / 20)
			if(mob:restrained())
				for(var/mob/M in range(mob, 1))
					if(M:pulling == mob && (!M:restrained() && M:stat == 0))
						src << "\blue Your restrained! You can't move!"
						return 0
			moving = 1
			. = ..()
			moving = null
			return .
		else if(isobj(mob:loc))
			var/O = mob:loc
			if(mob:canmove)
				return O:relaymove(mob, direct)
	else return































/client
	var/moving
/mob
	var/sdisabilities = 0
	var/disabilities = 0
	var/pulling
	var/stat = 0
	var/next_move
	var/other = 0
	var/hand
	var/eye_blind
	var/eye_blurry
	var/ear_deaf
	var/ear_damage
	var/stuttering
	var/rname
	var/blinded
	var/rejuv
	var/r_epil
	var/r_ch_cou
	var/r_Tourette
	var/antitoxs
	var/plasma
	var/sleeping = 0
	var/resting = 0
	var/lying = 0
	var/canmove = 1
	var/eye_stat
	var/oxyloss = 0
	var/toxloss = 0
	var/fireloss = 0
	var/bruteloss = 0
	var/cpr_time = 1
	var/health = 100
	var/drowsyness = 0
	var/paralysis = 0
	var/stunned = 0
	var/weakened = 0
	var/muted
	var/intent
	var/a_intent = "disarm"
	var/m_int
	var/m_intent = "walk"
	var/buckled
	var/primary
	var/handcuffed
	var/l_hand
	var/r_hand
	var/back
	var/internal
	var/obj/item/weapon/storage/s_active
	var/wear_mask
	var/flash
	var/blind
	var/hands
	var/mach
	var/sleep
	var/rest
	var/pullin
	var/internals
	var/oxygen
	var/i_select
	var/m_select
	var/toxin
	var/fire
	var/healths
	var/hud_used
	var/start
	density = 1
/mob/verb/help()
	src << browse('help.htm', "window=help")
/mob/verb/changes()
	src << browse("<PRE>[changes]</PRE>", "window=changes")
/mob/verb/succumb()
	set hidden = 1
	if(health < 0 && health > -95)
		oxyloss += health + 99
		health = -99
		usr << "\blue You have given up life and succumbed to death."
/mob/verb/removepull()
	pulling = null
/mob/layer = 4







/mob/proc/show_message(msg, type, alt, alt_type)
	if(type)
		if(type & 1 && (sdisabilities & 1 || (blinded || paralysis)))
			if(!alt)
				return
			else
				msg = alt
				type = alt_type
		if(type & 2 && (sdisabilities & 4 || ear_deaf))
			if(!alt)
				return
			else
				msg = alt
				type = alt_type
				if(type & 1 && sdisabilities & 1) return
	src << msg
/mob/proc/findname(msg)
	for(var/mob/M in world)
		if(M:rname == "[msg]")
			return 1
	return 0
/mob/burn(fi_amount)
	for(var/atom/movable/A in src)
		A:burn(fi_amount)
/mob/Topic(href, href_list)
	if(href_list["mach_close"])
		var/t1 = "window=[href_list["mach_close"]]"
		machine = null
		src << browse(null, t1)
	..()

/mob
	var/requests = list()
/mob/MouseDrop(mob/M)
	..()
	if(M != usr || (usr == src || get_dist(usr, src) > 1)) return
	show_inv(usr)

/mob/proc/m_delay()
/mob/proc/Life()
/mob/proc/UpdateClothing()
/mob/proc/death()
/mob/proc/restrained()
	if(handcuffed)
		return 1

/mob/human/restrained()
	if(handcuffed)
		return 1
	if(istype(wear_suit, /obj/item/weapon/clothing/suit/straight_jacket))
		return 1
	return 0

/mob/proc/db_click(text, t1)
	var/W = equipped()
	switch(text)
		if("mask")
			if(wear_mask) return
			if(!istype(W, /obj/item/weapon/clothing/mask)) return
			u_equip(W)
			wear_mask = W
		if("back")
			if(back || !istype(W, /obj/item/weapon)) return
			if(!(W:flags & 1)) return
			u_equip(W)
			back = W
/mob/verb/say()
/mob/verb/observe()
	if(stat != 2)
		usr << "\blue You must be dead to use this!"
		return
	client:perspective = EYE_PERSPECTIVE
	client:eye = input("Please, select a player!", "Watch") as mob in world
/mob/verb/listen_ooc()
	if(client)
		client:listen_ooc = !client:listen_ooc
		if(client:listen_ooc)
			src << "\blue You are now listening to messages on the OOC channel. <B>Don't abuse this!</B>"
		else
			src << "\blue You are no longer listening to messages on the OOC channel."
/mob/verb/ooc(msg as text)
	msg = copytext(msg, 1, 128)
	if(ooc_allowed && !muted)
		for(var/mob/M in world)
			if(M:client && M:client:listen_ooc) M << "<B>OOC: [key]</B>: [msg]"
/mob/las_act(flag)
	if(flag)
		if(prob(75)) stunned = 10
		else
			weakened = 10
	else
		if(stat != 2)
			bruteloss += 20
			health -= 20
			if(prob(25)) stunned = 2
/mob/proc/throw_item()
	var/W = equipped()
	if(W)
		u_equip(W)
		if(client) client:screen -= W
		if(usr.stat) return
		W:loc = loc
		W:dropped(src)
		W:layer = initial(W:layer)
		for(var/mob/O in view(src))
			O:show_message("\red[src] has thrown [W].", 1)
		W:density = 1
		W:throwing = 1
		W:throwspeed = initial(W:throwspeed)
		spawn(0) W:throwing(dir)
/mob/proc/swap_hand()
	hand = !hand
	if(!hand)
		hands:dir = NORTH
	else
		hands:dir = SOUTH
/mob/proc/drop_item_v()
	if(stat == 0)
		drop_item()
/mob/proc/throw_item_v()
	if(stat == 0)
		throw_item()
/mob/proc/drop_item()
	var/W = equipped()
	if(W)
		u_equip(W)
		if(client) client:screen -= W
		if(W)
			W:loc = loc
			W:dropped(src)
			W:layer = initial(W:layer)
/mob/proc/reset_view(A as mob|obj)
	if(client)
		if(istype(A, /atom/movable))
			client:perspective = EYE_PERSPECTIVE
			client:eye = A
		else
			if(isturf(loc))
				client:eye = client:mob
				client:perspective = MOB_PERSPECTIVE
			else
				client:perspective = EYE_PERSPECTIVE
				client:eye = loc
/mob/proc/who()
	set category = "Admin"
	usr << "<B>Current Players:</B>"
	for(var/mob/M in world)
		if(M:client)
			usr << "\t [M] ([M:client])"
/mob/proc/list_dna()
	set category = "Admin"
	usr << "<B>Registered DNA sequences:</B>"
	for(var/M in reg_dna)
		usr << "\t [M] = [reg_dna["[M]"]]"
/mob/proc/equipped()
	if(hand)
		return l_hand
	else
		return r_hand
/mob/verb/countobj()
	var/total
	for(var/obj/O in world)
		total++
	usr << "There are [total] objects in the world!"
/mob/verb/switch_hud()
	client:screen -= main_hud:contents
	client:screen -= main_hud2:contents
	if(hud_used == main_hud)
		hud_used = main_hud2
		oxygen:icon = 'screen.dmi'
		toxin:icon = 'screen.dmi'
		internals:icon = 'screen.dmi'
		mach:icon = 'screen.dmi'
		fire:icon = 'screen.dmi'
		healths:icon = 'screen.dmi'
		pullin:icon = 'screen.dmi'
		blind:icon = 'screen.dmi'
		hands:icon = 'screen.dmi'
		flash:icon = 'screen.dmi'
		sleep:icon = 'screen.dmi'
		rest:icon = 'screen.dmi'
	else
		hud_used = main_hud
		oxygen:icon = 'screen1.dmi'
		toxin:icon = 'screen1.dmi'
		internals:icon = 'screen1.dmi'
		mach:icon = 'screen1.dmi'
		fire:icon = 'screen1.dmi'
		healths:icon = 'screen1.dmi'
		pullin:icon = 'screen1.dmi'
		blind:icon = 'screen1.dmi'
		hands:icon = 'screen1.dmi'
		flash:icon = 'screen1.dmi'
		sleep:icon = 'screen1.dmi'
		rest:icon = 'screen1.dmi'
	client:screen -= hud_used:adding
	client:screen += hud_used:adding
/mob/proc/show_inv(mob/user)
	user:machine = src
	var/dat = {"<TT>
<B><FONT size=3>[name]</FONT></B>
\t<B>Head(Mask):</B> <A href='?src=\ref[src];item=mask'>[wear_mask ? "[wear_mask]" : "Nothing"]</A>
\t<B>Left Hand:</B> <A href='?src=\ref[src];item=l_hand'>[l_hand ? "[l_hand]" : "Nothing"]</A>
\t<B>Right Hand:</B> <A href='?src=\ref[src];item=r_hand'>[r_hand ? "[r_hand]" : "Nothing"]</A>
\t<B>Back:</B> <A href='?src=\ref[src];item=back'>[back ? "[back]" : "Nothing"]</A>
\t[istype(wear_mask, /obj/item/weapon/clothing/mask) && (istype(back, /obj/item/weapon/tank) && !internal) ? " <A href='?src=\ref[src];item=internal'>Set Internal</A>" : ""]
\t[internal ? "<A href='?src=\ref[src];item=internal'>Remove Internal</A>" : ""]
\t[handcuffed ? "<A href='?src=\ref[src];item=handcuff'>Handcuffed</A>" : "<A href='?src=\ref[src];item=handcuff'>Not Handcuffed</A>"]
\t<A href='?src=\ref[src];item=pockets'>Empty Pockets</A>
<A href='?src=\ref[user];mach_close=mob[name]'>Close</A>
</TT>"}
	user << browse(dat, "window=mob[name]")
/mob/proc/u_equip(obj/W)
	if(W == r_hand)
		r_hand = null
	else if(W == l_hand)
		l_hand = null
	else if(W == handcuffed)
		handcuffed = null
	else if(W == back)
		back = null
	else if(W == wear_mask)
		wear_mask = null
/mob/proc/toggle_ooc()
	set category = "Admin"
	ooc_allowed = !ooc_allowed
	if(ooc_allowed)
		world << "<B>The OOC channel has been globally enabled!</B>"
	else
		world << "<B>The OOC channel has been globally disabled!</B>"
/mob/proc/toggle_abandon()
	set category = "Admin"
	abandon_allowed = !abandon_allowed
	if(abandon_allowed)
		world << "<B>You may now abandon mob.</B>"
	else
		world << "<B>Live or Die Mode Activated</B>"
/mob/proc/toggle_shuttle()
	set category = "Admin"
	shuttle_frozen = !shuttle_frozen
	if(shuttle_frozen)
		world << "<B>The shuttle count is now FROZEN!</B>"
	else
		world << "<B>The shuttle has been thawed.</B>"
/mob/proc/delay_start()
	set category = "Admin"
	if(ticker)
		usr << "Too late... The game has already started!"
		return
	else
		if(alert(usr, "Would you like to delay game start?", "Delay Start", "Yes", "No") == "Yes")
			going = null
			world << "<B>The game start has been delayed by [usr.key] (Administrator to SS13)</B>"
			usr << alert("Don't forgot to revoke the delay by selecting No!")
		else
			world << "<B>The game will now start thanks to [usr.key] (Administrator to SS13)</B>"
			going = 1
/mob/proc/mute(mob/M in world)
	set category = "Admin"
	M:muted = !M:muted
	usr << "[M]'s chat status is now [M:muted ? "muted" : "voiced"]."
/mob/proc/change_name(mob/M in world, t as text)
	set category = "Admin"
	usr << "[M]'s default name is now [t] !"
	M:rname = t
/mob/proc/show_help(mob/M in world)
	set category = "Admin"
	M << browse('help.htm', "window=help")
/mob/proc/changemessage(txt as text)
	set name = "Change Message"
	set category = "Admin"
	world_message = "[key]: [txt]"
	world << "\blue<B>[world_message]</B>"
/mob/proc/changemode()
	set name = "Set Game Mode"
	set category = "Admin"
	if(ticker)
		return
	var/temp = input("Please select a mode", "Game Mode") in list("secret", "traitor", "meteor", "extended", "monkey")
	master_mode = temp
/mob/proc/boot(mob/M in world, txt as text)
	set category = "Admin"
	if(M && (M:client && txt)) del(M:client)
/mob/proc/ban(mob/M in world, txt as text)
	set category = "Admin"
	if(M && (M:client && txt))
		banned += M:ckey
		del(M:client)
/mob/proc/unban()
	set category = "Admin"
	var/t = input(usr, "Unban who?") as null|anything in banned
	banned -= t
/mob/proc/make_gift()
	set category = "Admin"
	new /obj/item/weapon/a_gift(loc)
/mob/proc/make_pill()
	set category = "Admin"
	new /obj/item/weapon/m_pill/superpill(loc)
/mob/proc/restart()
	set category = "Admin"
	world << "\green<B> Restarting world!"
	sleep(50)
	world.Reboot()
/mob/proc/monkey(mob/M in world)
	set category = "Admin"
	set hidden = 1
	for(var/obj/O in M)
		del(O)
	var/O = new /mob/monkey(M:loc)
	M:client:mob = O
	O:loc = M:loc
	del(M)
/mob/proc/toggle_alter()
	set category = "Admin"
	if(verbs:Find(/mob/proc/carboncopy))
		verbs -= /mob/proc/carboncopy
	else
		verbs -= /mob/proc/carboncopy
		verbs += /mob/proc/carboncopy
/mob/proc/carboncopy(O as mob|obj in world)
	var/M = O
	if(istype(M, /mob) && M:key)
		usr << "You can't duplicate PCs' mobs."
		return
	var/new_O = new O:type(usr.loc)
	for(var/V in O:vars)
		if(issaved(O:vars[V])) new_O:vars[V] = O:vars[V]
/mob/proc/secrets(pass as text)
	set category = "Admin"
	switch(pass)
		if("sec_clothes")
			for(var/obj/item/weapon/clothing/under/O in world)
				del(O)
		if("sec_all_clothes")
			for(var/obj/item/weapon/clothing/O in world)
				del(O)
		if("sec_classic1")
			for(var/obj/item/weapon/clothing/suit/firesuit/O in world)
				del(O)
			for(var/obj/grille/O in world)
				del(O)
			for(var/obj/machinery/pod/O in world)
				del(O)
		if("clear_bombs")
			for(var/obj/item/weapon/assembly/r_i_ptank/O in world)
				del(O)
		if("list_bombers")
			usr << "\blue<B>Don't be insane about this lsit</B> Get the facts."
			for(var/l in bombers)
				usr << "[l] 'made' a bomb."
		if("check_antagonist")
			if(ticker)
				if(ticker:killer)
					if(ticker:killer:ckey)
						usr << "<B>The traitor's key is [ticker:killer:ckey].</B>"
					else
						usr << "<B>It seems like the traitor logged out...</B>"
				else
					usr << "<B>There is no traitor.</B>"
			else
				usr << "<B>The game has not started yet.</B>"
/mob/monkey
	var/t_plasma
	var/t_oxygen
	var/t_sl_gas
	var/t_n2
	var/now_pushing
	icon = 'monkey.dmi'
/mob/monkey/New()
	spawn(50)
		if(!primary)
			var/t1 = rand(1000, 1500)
			dna_ident += t1
			if(dna_ident > 65536)
				dna_ident = rand(1, 1500)
			primary = new /obj/dna(null)
			primary:uni_identity = "[dna_ident]"
			while(length(primary:uni_identity) < 4)
				primary:uni_identity = "0[primary:uni_identity]"
			var/t2 = "[rand(1, 256)]"
			if(length(t2) < 2)
				primary:uni_identity = "[primary:uni_identity]0[t2]"
			else
				primary:uni_identity = "[primary:uni_identity][t2]"
			t2 = "[rand(1, 256)]"
			if(length(t2) < 2)
				primary:uni_identity = "[primary:uni_identity]0[t2]"
			else
				primary:uni_identity = "[primary:uni_identity][t2]"
			t2 = "[rand(1, 256)]"
			if(length(t2) < 2)
				primary:uni_identity = "[primary:uni_identity]0[t2]"
			else
				primary:uni_identity = "[primary:uni_identity][t2]"
			t2 = "[rand(1, 256)]"
			if(length(t2) < 2)
				primary:uni_identity = "[primary:uni_identity]0[t2]"
			else
				primary:uni_identity = "[primary:uni_identity][t2]"
			t2 = gender == "male" ? "[rand(1, 124)]" : "[rand(127, 250)]"
			if(length(t2) < 2)
				primary:uni_identity = "[primary:uni_identity]0[t2]"
			else
				primary:uni_identity = "[primary:uni_identity][t2]"
			primary:spec_identity = "2B6696D2B127E5A4"
			primary:struc_enzyme = "CDEAF5B90AADBC6BA8033DB0A7FD613FA"
			primary:use_enzyme = "C8FFFE7EC09D80AEDEDB9A5A0B4085B61"
			primary:n_chromo = 16
	..()
/mob/monkey/Bump(AM as mob|obj, yes)
	if(!yes || now_pushing) return
	..()
	if(!istype(AM, /atom/movable)) return
	if(!now_pushing)
		now_pushing = 1
		if(!AM:anchored)
			var/t = get_dir(src, AM)
			step(AM, t)
		now_pushing = null
/mob/monkey
	icon_state = "monkey1"
/mob/monkey/Topic(href, href_list)
	if(href_list["mach_close"])
		var/t1 = "window=[href_list["mach_close"]]"
		machine = null
		src << browse(null, t1)
	if(href_list["item"] && (!usr.stat && (!usr.restrained() && get_dist(src, usr) <= 1)))
		var/O = new /obj/equip_e/monkey()
		O:source = usr
		O:target = src
		O:item = usr.equipped()
		O:s_loc = usr.loc
		O:t_loc = loc
		O:place = href_list["item"]
		requests += O
		spawn(0) O:process()
	..()
/mob/monkey/flags = 2
/mob/monkey/meteorhit(obj/O)
	for(var/mob/M in view(src))
		M:show_message("\red[src] has been hit with by [O]", 1)
	if(health > 0)
		var/shielded = 0
		for(var/obj/item/weapon/shield/S in src)
			if(S:active)
				shielded = 1
				break
		health -= 30
		bruteloss += 30
		if(O:icon_state == "flaming" && !shielded)
			health -= 40
			fireloss += 40
/mob/monkey/las_act(flag)
	if(flag)
		paralysis = 15
	else
		if(stat != 2)
			bruteloss += 20
			health -= 20
			paralysis = 5
/mob/monkey/hand_p(mob/M)
	if(M:a_intent == "hurt" && !istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle))
		if(prob(75) && health > 0)
			for(var/mob/O in view(src))
				O:show_message("\red<B>The monkey has bit [src]!</B>", 1)
			var/damage = rand(1, 5)
			health -= damage
			bruteloss += damage
		else
			for(var/mob/O in view(src))
				O:show_message("\red<B>The monkey has attempted to bite [src]!</B>", 1)
/mob/monkey/attack_paw(mob/M)
	if(M:a_intent == "help")
		sleeping = 0
		resting = 0
		for(var/mob/O in view(src))
			O:show_message("\blue The monkey shakes the monkey trying to wake him up!", 1)
	else if(M:a_intent == "hurt" && !istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle))
		if(prob(75) && health > 0)
			for(var/mob/O in view(src))
				O:show_message("\red<B>The monkey has bit the monkey!</B>", 1)
			var/damage = rand(1, 5)
			health -= damage
			bruteloss += damage
		else
			for(var/mob/O in view(src))
				O:show_message("\red<B>The monkey has attempted to bite the monkey!</B>", 1)

/mob/monkey/attack_hand(M as mob)
	if(M:a_intent == "help")
		sleeping = 0
		resting = 0
		for(var/mob/O in view(src))
			if(O:client && !O:blinded)
				O:show_message("\blue[M] shakes the monkey trying to wake him up!", 1)
	else if(M:a_intent == "hurt")
		if(prob(75) && health > 0)
			for(var/mob/O in view(src))
				if(O:client && !O:blinded)
					O:show_message("\red<B>[M] has punched the monkey!</B>", 1)
			var/damage = rand(5, 10)
			if(prob(40))
				damage = rand(10, 15)
				if(paralysis < 5)
					paralysis = rand(10, 15)
					spawn(0)
						for(var/mob/O in view(src))
							if(O:client && !O:blinded)
								O:show_message("\red<B>[M] has knocked out the monkey!</B>", 1)
			health -= damage
			bruteloss += damage
		else
			for(var/mob/O in view(src))
				if(O:client && !O:blinded)
					O:show_message("\red<B>[M] has attempted to punch the monkey!</B>", 1)
	else if(!paralysis)
		if(prob(25))
			paralysis = 2
			for(var/mob/O in view(src))
				if(O:client && !O:blinded)
					O:show_message("\red<B>[M] has pushed down the monkey!</B>", 1)
		else
			drop_item()
			for(var/mob/O in view(src))
				if(O:client && !O:blinded)
					O:show_message("\red<B>[M] has disarmed the monkey!</B>", 1)
/mob/monkey/Stat()
	..()
	statpanel("Status")
	stat(, "Intent: [a_intent]")
	stat(, "Move Mode: [m_intent]")
/mob/monkey/UpdateClothing()
	..()
	for(var/i in overlays)
		overlays -= i
	if(!lying)
		icon_state = "monkey1"
	else
		icon_state = "monkey0"
	if(wear_mask)
		if(istype(wear_mask, /obj/item/weapon/clothing/mask))
			var/t1 = wear_mask:s_istate
			if(!t1) t1 = wear_mask:icon_state
			src.overlays += image(icon = 'monkey.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = layer)
		wear_mask:screen_loc = "2,3"
	if(r_hand)
		var/t1 = r_hand:s_istate
		if(!t1) t1 = r_hand:icon_state
		src.overlays += image(icon = 'r_items.dmi', icon_state = t1, layer = layer)
		r_hand:screen_loc = "1,2"
	if(l_hand)
		var/t1 = l_hand:s_istate
		if(!t1) t1 = l_hand:icon_state
		src.overlays += image(icon = 'l_items.dmi', icon_state = t1, layer = layer)
		l_hand:screen_loc = "3,2"
	if(back)
		if(!lying)
			overlays += image(icon = 'monkey.dmi', icon_state = "back", layer = src.layer)
		else
			overlays += image(icon = 'monkey.dmi', icon_state = "back2", layer = src.layer)
		back:screen_loc = "3,3"
	if(handcuffed)
		pulling = null
		if(!lying)
			overlays += image(icon = 'monkey.dmi', icon_state = "handcuff1", layer = src.layer)
		else
			overlays += image(icon = 'monkey.dmi', icon_state = "handcuff2", layer = src.layer)
	if(client)
		client:screen -= contents
		client:screen += contents
		client:screen -= hud_used:m_ints
		client:screen -= hud_used:mov_int
		if(i_select)
			if(intent)
				client:screen += hud_used:m_ints
				i_select:screen_loc = intent
			else
				i_select:screen_loc = null
		if(m_select)
			if(m_int)
				client:screen += hud_used:mov_int
				m_select:screen_loc = m_int
			else
				m_select:screen_loc = null
	for(var/mob/M in view(1, src))
		if(M:client && M:machine == src)
			spawn(0) show_inv(M)
/mob/monkey/Login()
	if(banned:Find(ckey))
		del(client)
	client:screen -= main_hud:contents
	client:screen -= main_hud2:contents
	if(!hud_used) hud_used = main_hud
	next_move = 1
	if(!rname) rname = key
	oxygen = new /obj/screen(null)
	i_select = new /obj/screen(null)
	m_select = new /obj/screen(null)
	toxin = new /obj/screen(null)
	internals = new /obj/screen(null)
	mach = new /obj/screen(null)
	fire = new /obj/screen(null)
	healths = new /obj/screen(null)
	pullin = new /obj/screen(null)
	blind = new /obj/screen(null)
	flash = new /obj/screen(null)
	hands = new /obj/screen(null)
	sleep = new /obj/screen(null)
	rest = new /obj/screen(null)
	..()
	UpdateClothing()


	oxygen:icon_state = "oxy0"
	i_select:icon_state = "selector"
	m_select:icon_state = "selector"
	toxin:icon_state = "toxin0"
	internals:icon_state = "internal0"
	mach:icon_state = null
	fire:icon_state = "fire0"
	healths:icon_state = "health0"
	pullin:icon_state = "pull0"
	blind:icon_state = "black"
	hands:icon_state = "hand"
	flash:icon_state = "blank"
	sleep:icon_state = "sleep0"
	rest:icon_state = "rest0"
	hands:dir = NORTH

	oxygen:name = "oxygen"
	i_select:name = "intent"
	m_select:name = "move"
	toxin:name = "toxin"
	internals:name = "internal"
	mach:name = "Reset Machine"
	fire:name = "fire"
	healths:name = "health"
	pullin:name = "pull"
	blind:name = " "
	hands:name = "hand"
	flash:name = "flash"
	sleep:name = "sleep"
	rest:name = "rest"

	oxygen:screen_loc = "15,12"
	i_select:screen_loc = "14,15"
	m_select:screen_loc = "14,14"
	toxin:screen_loc = "15,10"
	internals:screen_loc = "15,14"
	mach:screen_loc = "15,15"
	fire:screen_loc = "15,8"
	healths:screen_loc = "15,5"
	sleep:screen_loc = "15,3"
	rest:screen_loc = "15,2"
	pullin:screen_loc = "15,1"
	hands:screen_loc = "1,3"
	blind:screen_loc = "1,1 to 15,15"
	flash:screen_loc = "1,1 to 15,15"
	blind:layer = 0
	flash:layer = 17
	sleep:layer = 20
	rest:layer = 20



	client:screen:len = null
	client:screen -= list(oxygen, i_select, m_select, toxin, internals, fire, hands, healths, pullin, blind, flash, rest, sleep, mach)
	client:screen += list(oxygen, i_select, m_select, toxin, internals, fire, hands, healths, pullin, blind, flash, rest, sleep, mach)

	client:screen -= hud_used:adding
	client:screen += hud_used:adding
	client:screen -= hud_used:mon_blo
	client:screen += hud_used:mon_blo
	if(!primary)
		var/t1 = rand(1000, 1500)
		dna_ident += t1
		if(dna_ident > 65536)
			dna_ident = rand(1, 1500)
		primary = new /obj/dna(null)
		primary:uni_identity = "[dna_ident]"
		while(length(primary:uni_identity) < 4)
			primary:uni_identity = "0[primary:uni_identity]"
		var/t2 = "[rand(1, 256)]"
		if(length(t2) < 2)
			primary:uni_identity = "[primary:uni_identity]0[t2]"
		else
			primary:uni_identity = "[primary:uni_identity][t2]"
		t2 = "[rand(1, 256)]"
		if(length(t2) < 2)
			primary:uni_identity = "[primary:uni_identity]0[t2]"
		else
			primary:uni_identity = "[primary:uni_identity][t2]"
		t2 = "[rand(1, 256)]"
		if(length(t2) < 2)
			primary:uni_identity = "[primary:uni_identity]0[t2]"
		else
			primary:uni_identity = "[primary:uni_identity][t2]"
		t2 = "[rand(1, 256)]"
		if(length(t2) < 2)
			primary:uni_identity = "[primary:uni_identity]0[t2]"
		else
			primary:uni_identity = "[primary:uni_identity][t2]"
		t2 = gender == "male" ? "[rand(1, 124)]" : "[rand(127, 250)]"
		if(length(t2) < 2)
			primary:uni_identity = "[primary:uni_identity]0[t2]"
		else
			primary:uni_identity = "[primary:uni_identity][t2]"
		primary:spec_identity = "2B6696D2B127E5A4"
		primary:struc_enzyme = "CDEAF5B90AADBC6BA8033DB0A7FD613FA"
		primary:use_enzyme = "C8FFFE7EC09D80AEDEDB9A5A0B4085B61"
		primary:n_chromo = 16
	if(!start)
		if(key in list("Thief jack", "Link43130", "Hutchy2k1", "Easty", "Exadv1"))
			start = 1
			loc = locate(36, 67, 10)
		else
			start = 1
			var/A = locate(/area/start)
			var/L = list()
			for(var/T as turf in A)
				L += T
			loc = pick(L)
	src << browse('help.htm', "window=help")
	if((key in list("Exadv1", "Jon88", "Link43130", "Hutchy2k1")) || (world.address == client:address || !client:address))
		src << "\blue The game ip is byond://[world.address]:[world.port] !"
		verbs += /mob/proc/mute
		verbs += /mob/proc/changemessage
		verbs += /mob/proc/boot
		verbs += /mob/proc/changemode
		verbs += /mob/proc/restart
		verbs += /mob/proc/who
		verbs += /mob/proc/change_name
		verbs += /mob/proc/show_help
		verbs += /mob/proc/toggle_ooc
		verbs += /mob/proc/toggle_abandon
		verbs += /mob/proc/toggle_shuttle
		verbs += /mob/proc/delay_start
		verbs += /mob/proc/make_gift
		verbs += /mob/proc/make_pill
		verbs += /mob/proc/ban
		verbs += /mob/proc/unban
		verbs += /mob/proc/secrets
		verbs += /mob/proc/toggle_alter
		verbs += /mob/proc/carboncopy
		verbs += /mob/proc/list_dna
	src << "\blue<B>[world_message]</B>"
	if(!isturf(loc))
		client:eye = loc
		client:perspective = EYE_PERSPECTIVE
	name = "monkey"
/mob/monkey/Move()
	if(!buckled || buckled:loc != loc)
		buckled = null
	if(buckled) return
	if(restrained()) pulling = null
	var/t7 = 1
	if(restrained())
		for(var/mob/M in range(src, 1))
			if(M:pulling == src && (M:stat == 0 && !M:restrained()))
				t7 = null
	if(t7 && (pulling && get_dist(src, pulling) <= 1))
		var/T = loc
		. = ..()
		if(!isturf(pulling:loc))
			pulling = null
			return
		if(!handcuffed)
			var/diag = get_dir(src, pulling)
			if(diag - 1 & diag)
			else diag = null
			if(ismob(pulling) && (get_dist(src, pulling) > 1 || diag))
				if(istype(pulling, type))
					var/M = pulling
					var/t = M:pulling
					M:pulling = null
					step(pulling, get_dir(pulling:loc, T))
					M:pulling = t
			else
				step(pulling, get_dir(pulling:loc, T))
	else
		pulling = null
		. = ..()
	if(s_active && !contents:Find(s_active))
		s_active:close(src)
/mob/monkey/death()
	if(healths) healths:icon_state = "health5"
	stat = 2
	canmove = 0
	lying = 1
	if(blind) blind:layer = 0
	icon_state = "dead"
	var/cancel
	for(var/mob/human/M in world)
		if(M:client && !M:stat)
			cancel = 1
	if(!cancel)
		world << "<B>Everyone is dead! Resetting in 30 seconds!</B>"
		if(ticker && ticker:timing)
			ticker:shuttle_entered = 1
			ticker:timeleft = 1
		else spawn(300) world.Reboot()
	return
/mob/monkey/Life()
	set background = 1
	var/T = loc
	var/plcheck
	var/oxcheck
	var/ficheck
	if(!(locate(/obj/table) in loc))
		layer = MOB_LAYER
	if(internal && !contents:Find(internal)) internal = null
	if(istype(T, /turf))
		if(locate(/obj/move) in T)
			T = locate(/obj/move) in T
		if(internal)
			internal:process(src)
			plcheck = t_plasma
			oxcheck = t_oxygen
			paralysis += min(t_sl_gas, 5)
		if(!internal || (!wear_mask || wear_mask:flags & 4))
			if(!plcheck) plcheck = poisoncheck(T)
			oxcheck += oxycheck(T)
		ficheck = firecheck(T)
	else
		if(istype(T, /obj))
			var/O = T
			O:alter_health(src)
	if(istype(loc, /turf/space) && !(locate(/obj/move) in loc))
		var/layers = 1
		if(istype(wear_mask, /obj/item/weapon/clothing/mask/gasmask))
			layers -= 0.25
		if(layers < oxcheck)
			oxcheck = layers
	if(plcheck && health >= 0)
		if(paralysis <= 0 || weakened <= 0)
			health -= plcheck * 5
			toxloss += plcheck * 5
		else
			health -= plcheck
			toxloss += plcheck

	if(oxcheck && health >= 0)
		if(paralysis <= 0 || weakened <= 0)
			health -= oxcheck * 5
			oxyloss += oxcheck * 5
		else
			health -= oxcheck
			oxyloss += oxcheck
	else if(health >= 0)
		if(oxyloss >= 10)
			var/amount = max(0.15, 1)
			health += amount
			oxyloss -= amount
		else
			health += oxyloss
			oxyloss = 0

	if(ficheck)
		health -= ficheck * 10
		fireloss += ficheck * 10

	if(health <= -100)
		if(stat != 2)
			death()
	else if(health <= 20 || sleeping)
		if(health < 0)
			if(rejuv <= 0)
				health--
				oxyloss++
		stat = 1
		if(paralysis < 2) paralysis = 2
	else if(resting)
		if(weakened < 2) weakened = 2
	if(rejuv > 0)
		rejuv--
	blinded = null
	if(paralysis + stunned + weakened > 0)
		if(stunned > 0)
			stunned--
			stat = 0
		if(weakened > 0)
			weakened--
			lying = 1
			stat = 0
		if(paralysis > 0)
			paralysis--
			blinded = 1
			lying = 1
			stat = 1
		canmove = 0
		var/h = hand
		hand = 0
		drop_item()
		hand = 1
		drop_item()
		hand = h
	else
		canmove = 1
		lying = 0
	density = !lying
	if(client)
		if(mach)
			if(machine)
				mach:icon_state = "mach1"
			else
				mach:icon_state = null
		if(sleep)
			sleep:icon_state = "sleep[sleeping]"
		if(rest)
			rest:icon_state = "rest[resting]"
		if(healths)
			if(stat < 2)
				if(health >= 100) healths:icon_state = "health0"
				else if(health >= 75) healths:icon_state = "health1"
				else if(health >= 50) healths:icon_state = "health2"
				else if(health > 20) healths:icon_state = "health3"
				else healths:icon_state = "health4"
			else
				healths:icon_state = "health5"
		if(pullin)
			if(pulling)
				pullin:icon_state = "pull1"
			else
				pullin:icon_state = "pull0"
		if(fire)
			if(ficheck)
				fire:icon_state = "fire1"
			else
				fire:icon_state = "fire0"
		if(toxin)
			if(plcheck)
				toxin:icon_state = "toxin1"
			else
				toxin:icon_state = "toxin0"
		if(oxygen)
			if(oxcheck)
				oxygen:icon_state = "oxy1"
			else
				oxygen:icon_state = "oxy0"
		if(blind)
			if(blinded)
				blind:layer = 18
			else
				blind:layer = 0
		if(stat != 2)
			if(machine)
				if(!machine:check_eye(src))
					reset_view(null)
			else
				reset_view(null)
	else if(stat == 0 && isturf(loc))
		step_rand(src)
		intent = "hurt"
		if(prob(90))
			var/H = locate(/mob/human) in oview(1)
			if(H) H:hand_p(src)
	if(primary) primary:cleanup()
	UpdateClothing()

/mob/monkey/proc/firecheck(turf/T)
	if(T:firelevel > 100)
		return 1
	return 0
/mob/monkey/proc/poisoncheck(turf/T)
	if(T:poison <= 150)
		return 0
	if(T:poison <= 1000 && istype(wear_mask, /obj/item/weapon/clothing/mask/gasmask))
		return 0.9
	else
		return 1

/mob/monkey/proc/oxycheck(turf/T)
	if(T:oxygen <= 900)
		return 1
	else
		T:oxygen -= 20
		T:co2 += 10
		if(T:co2 >= 200)
			return 1
		else
			return 0
/mob/monkey/say(message as text)
	message = copytext(message, 1, 128)
	if(stat >= 1)
		for(var/mob/M in world)
			if(M:stat > 1)
				M << "<B>[rname]</B> [stat > 1 ? "\[<I>dead</I> \]" : ""]: [message]"
				return
	if(copytext(message, 1, 2) == "*" && !stat)
		emote(copytext(message, 2, length(message) + 1))
		return
	if(stat == 1)
		if(sleeping)
			message = "*snores*"
		else
			message = "*gasp*"
	if(!message || istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle)) return
	if(!muted)
		if(stat < 2)
			var/L = view()
			for(var/mob/M in L)
				if(istype(M, type))
					M:show_message("<B>The monkey</B>: [message]", 2)
				else
					M:show_message("<B>The monkey</B> chimpers.", 2)
			for(var/obj/O in L)
				spawn(0) if(O) O:hear_talk(usr, "chimpering")
		for(var/mob/M in world)
			if(M:stat > 1)
				M << "<B>[src]</B> [stat > 1 ? "\[<I>dead</I> \]" : ""]: [message]"
	else
		src.show_message("<B>[src]</B>: [message]", 2)

/mob/monkey/examine()
	set src in oview()
	usr << "\blue*---------*"
	usr << "\blue This is \icon[src] <B>[name]</B>!"
	if(handcuffed) usr << "\blue\t[name] is handcuffed! \icon[handcuffed]"
	if(wear_mask) usr << "\blue\t[name] has a \icon[wear_mask] [wear_mask:name] on \his[src] head!"
	if(l_hand) usr << "\blue\t[name] has a \icon[l_hand] [l_hand:name] in \his[src] left hand!"
	if(r_hand) usr << "\blue[name] has a \icon[r_hand] [r_hand:name] in \his[src] right hand!"
	if(back) usr << "\blue[name] has a \icon[back] [back:name] on \his[src] back!"
	if(bruteloss)
		if(bruteloss < 30) usr << "\red[name] looks slightly bruised!"
		else usr << "\red<B>[name] looks severely bruised!</B>"
	if(fireloss)
		if(fireloss < 30) usr << "\red[name] looks slightly burnt!"
		else usr << "\red<B>[name] looks severely burnt!</B>"
/mob/monkey/proc/emote(act)
	var/param = null
	if(findtext(act, "-"))
		var/t1 = findtext(act, "-")
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)
	var/muzzled = istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle)
	var/message
	var/m_type = 1
	switch(act)
		if("sign")
			if(!handcuffed)
				message = "The monkey signs[text2num(param) ? " the number [text2num(param)]" : null]."
				m_type = 1
		if("scratch")
			if(!handcuffed)
				message = "The monkey scratches."
				m_type = 1
		if("whimper")
			if(!muzzled)
				message = "The monkey whimpers."
				m_type = 2
		if("roar")
			if(!muzzled)
				message = "The monkey roars."
				m_type = 2
		if("tail")
			message = "The monkey waves his tail."
			m_type = 1
		if("paw")
			if(!handcuffed)
				message = "The monkey flails his paw."
				m_type = 1
		if("scretch")
			if(!muzzled)
				message = "The monkey scretches."
				m_type = 2
		if("choke")
			message = "The monkey chokes."
			m_type = 2
		if("nod")
			message = "The monkey nods his head."
			m_type = 1
		if("sit")
			message = "The monkey sits down."
			m_type = 1
		if("sway")
			message = "The monkey sways around dizzily."
			m_type = 1
		if("sulk")
			message = "The monkey sulks down sadly."
			m_type = 1
		if("dance")
			if(!handcuffed)
				message = "The monkey dances around happily."
				m_type = 1
		if("roll")
			if(!handcuffed)
				message = "The monkey rolls."
				m_type = 1
		if("shake")
			message = "The monkey shakes his head."
			m_type = 1
		if("gnarl")
			if(!muzzled)
				message = "The monkey gnarls and shows his teeth.."
				m_type = 2
		if("jump")
			message = "The monkey jumps!"
			m_type = 1
		if("help")
			src << "choke, dance, gnarl, jump, paw, nod, roar, roll, scratch, scretch, shake, sign-#,\nsit, sulk, sway, tail, whimper"
		else

			src << "Invalid Emote: [act]"
	if(message && stat == 0)
		for(var/mob/O in view(src))
			O:show_message(message, m_type)
/mob/monkey/ex_act(severity)
	flick("flash", flash)
	switch(severity)
		if(1)
			if(stat != 2)
				bruteloss += 200
				health -= 200
		if(2)
			if(stat != 2)
				bruteloss += 60
				health -= 60
				fireloss += 60
				health -= 60
		if(3)
			if(stat != 2)
				bruteloss += 30
				health -= 30
			if(prob(50))
				paralysis += 10

/mob/human/ex_act(severity)
	flick("flash", flash)
	var/shielded = 0
	for(var/obj/item/weapon/shield/S in src)
		if(S:active)
			shielded = 1
			break
	switch(severity)
		if(1)
			if(stat != 2)
				bruteloss += 200
				health -= 200
		if(2)
			if(stat != 2)
				if(!shielded)
					bruteloss += 60
					health -= 60
				fireloss += 60
				health -= 60
		if(3)
			if(stat != 2)
				bruteloss += 30
				health -= 30
			if(prob(50) && !shielded)
				paralysis += 10



/mob/human
	var/obj/item/weapon/clothing/suit/wear_suit
	var/obj/item/weapon/clothing/under/w_uniform
	var/w_radio
	var/shoes
	var/belt
	var/gloves
	var/glasses
	var/head
	var/obj/item/weapon/card/id/wear_id
	var/r_store
	var/l_store
	var/special
/mob/human/u_equip(obj/W)
	if(W == wear_suit)
		wear_suit = null
	else if(W == w_uniform)
		W = r_store
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		W = l_store
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		W = wear_id
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		W = belt
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		w_uniform = null
	else if(W == gloves)
		gloves = null
	else if(W == glasses)
		glasses = null
	else if(W == head)
		head = null
	else if(W == shoes)
		shoes = null
	else if(W == belt)
		belt = null
	else if(W == wear_mask)
		wear_mask = null
	else if(W == w_radio)
		w_radio = null
	else if(W == wear_id)
		wear_id = null
	else if(W == r_store)
		r_store = null
	else if(W == l_store)
		l_store = null
	else if(W == back)
		back = null
	else if(W == handcuffed)
		handcuffed = null
	else if(W == r_hand)
		r_hand = null
	else if(W == l_hand)
		l_hand = null
/mob/human/db_click(text, t1)
	var/W = equipped()
	if(!istype(W, /obj/item/weapon)) return
	switch(text)
		if("mask")
			if(wear_mask) return
			if(!istype(W, /obj/item/weapon/clothing/mask)) return
			u_equip(W)
			wear_mask = W
		if("back")
			if(back || !istype(W, /obj/item/weapon)) return
			if(!(W:flags & 1)) return
			u_equip(W)
			back = W
		if("headset")
			if(w_radio) return
			if(!istype(W, /obj/item/weapon/radio/headset)) return
			u_equip(W)
			w_radio = W
		if("o_clothing")
			if(wear_suit) return
			if(!istype(W, /obj/item/weapon/clothing/suit)) return
			u_equip(W)
			wear_suit = W
		if("gloves")
			if(gloves) return
			if(!istype(W, /obj/item/weapon/clothing/gloves)) return
			u_equip(W)
			gloves = W
		if("shoes")
			if(shoes) return
			if(!istype(W, /obj/item/weapon/clothing/shoes)) return
			u_equip(W)
			shoes = W
		if("belt")
			if(belt || !istype(W, /obj/item/weapon)) return
			if(!(W:flags & 128)) return
			u_equip(W)
			belt = W
		if("eyes")
			if(glasses) return
			if(!istype(W, /obj/item/weapon/clothing/glasses)) return
			u_equip(W)
			glasses = W
		if("head")
			if(head) return
			if(!istype(W, /obj/item/weapon/clothing/head)) return
			u_equip(W)
			head = W
		if("i_clothing")
			if(w_uniform) return
			if(!istype(W, /obj/item/weapon/clothing/under)) return
			u_equip(W)
			w_uniform = W
		if("id")
			if(wear_id || !w_uniform) return
			if(!istype(W, /obj/item/weapon/card/id)) return
			u_equip(W)
			wear_id = W
		if("storage1")
			if(l_store) return
			if(!istype(W, /obj/item/weapon) || (W:w_class >= 3 || !w_uniform)) return
			u_equip(W)
			l_store = W
		if("storage2")
			if(r_store) return
			if(!istype(W, /obj/item/weapon) || (W:w_class >= 3 || !w_uniform)) return
			u_equip(W)
			r_store = W

/mob/human/meteorhit(obj/O)
	for(var/mob/M in view(src))
		if(M:client && !M:blinded)
			M:show_message("\red[src] has been hit with by [O]", 1)
	if(health > 0)
		var/shielded = 0
		for(var/obj/item/weapon/shield/S in src)
			if(S:active)
				shielded = 1
				break
		health -= 30
		bruteloss += 30
		if(O:icon_state == "flaming" && !shielded)
			health -= 40
			fireloss += 40
	if(prob(30))
		var/t = pick(1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 3, 5, 6)
		sdisabilities |= t
		if(t & 1)
			src.show_message("\red You go blind!")
		if(t & 2)
			show_message("\red You go mute!")
		if(t & 4)
			show_message("\red You go deaf!")
/mob/human/Move()
	if(buckled) return
	if(handcuffed) pulling = null
	var/t7 = 1
	if(handcuffed)
		for(var/mob/M in range(src, 1))
			if(M:pulling == src && (M:stat == 0 && !M:handcuffed))
				t7 = null
	if(t7 && (pulling && ((get_dist(src, pulling) <= 1 || pulling:loc == loc) && (client && client:moving))))
		var/T = loc
		. = ..()
		if(!isturf(pulling:loc))
			pulling = null
			return
		if(!handcuffed)
			var/diag = get_dir(src, pulling)
			if(diag - 1 & diag)
			else diag = null
			if(get_dist(src, pulling) > 1 || diag)
				if(ismob(pulling))
					var/M = pulling
					var/t = M:pulling
					M:pulling = null
					step(pulling, get_dir(pulling:loc, T))
					M:pulling = t
				else
					step(pulling, get_dir(pulling:loc, T))
	else
		pulling = null
		. = ..()
	if(s_active && !contents:Find(s_active))
		s_active:close(src)
/mob/human/examine()
	set src in oview()
	usr << "\blue*---------*"
	usr << "\blue This is \icon[src] <B>[name]</B>!"
	if(w_uniform) usr << "\blue\t[name] is wearing \icon[w_uniform] [w_uniform:name]."
	if(handcuffed) usr << "\blue\t[name] is handcuffed! \icon[handcuffed]"
	if(wear_suit) usr << "\blue\t[name] has a \icon[wear_suit] [wear_suit:name] on!"
	if(w_radio) usr << "\blue\t[name] has a \icon[w_radio] [w_radio:name] by \his[src] mouth!"
	if(wear_mask) usr << "\blue\t[name] has a \icon[wear_mask] [wear_mask:name] on \his[src] head!"
	if(l_hand) usr << "\blue\t[name] has a \icon[l_hand] [l_hand:name] in \his[src] left hand!"
	if(r_hand) usr << "\blue[name] has a \icon[r_hand] [r_hand:name] in \his[src] right hand!"
	if(back) usr << "\blue[name] has a \icon[back] [back:name] on \his[src] back!"
	if(wear_id)
		if(wear_id:registered != rname && (get_dist(src, usr) <= 1 && prob(50)))
			usr << "\blue[name] is wearing \icon[wear_id] [wear_id:name] yet doesn't seem to be that person!!!"
		else usr << "\blue[name] is wearing \icon[wear_id] [wear_id:name]!"
	if(bruteloss)
		if(bruteloss < 30) usr << "\red[name] looks slightly bruised!"
		else usr << "\red<B>[name] looks severely bruised!</B>"
	if(fireloss)
		if(fireloss < 30) usr << "\red[name] looks slightly burnt!"
		else usr << "\red<B>[name] looks severely burnt!</B>"
	usr << "\blue*---------*"
/mob/human/Logout()
	if(!start)
		del(src)
	else ..()
/mob/human/Login()
	client:screen -= main_hud:contents
	client:screen -= main_hud2:contents
	if(!hud_used) hud_used = main_hud
	next_move = 1
	if(!rname) rname = key
	oxygen = new /obj/screen(null)
	i_select = new /obj/screen(null)
	m_select = new /obj/screen(null)
	toxin = new /obj/screen(null)
	internals = new /obj/screen(null)
	mach = new /obj/screen(null)
	fire = new /obj/screen(null)
	healths = new /obj/screen(null)
	pullin = new /obj/screen(null)
	blind = new /obj/screen(null)
	flash = new /obj/screen(null)
	hands = new /obj/screen(null)
	sleep = new /obj/screen(null)
	rest = new /obj/screen(null)
	..()
	UpdateClothing()


	oxygen:icon_state = "oxy0"
	i_select:icon_state = "selector"
	m_select:icon_state = "selector"
	toxin:icon_state = "toxin0"
	internals:icon_state = "internal0"
	mach:icon_state = null
	fire:icon_state = "fire0"
	healths:icon_state = "health0"
	pullin:icon_state = "pull0"
	blind:icon_state = "black"
	hands:icon_state = "hand"
	flash:icon_state = "blank"
	sleep:icon_state = "sleep0"
	rest:icon_state = "rest0"
	hands:dir = NORTH

	oxygen:name = "oxygen"
	i_select:name = "intent"
	m_select:name = "moving"
	toxin:name = "toxin"
	internals:name = "internal"
	mach:name = "Reset Machine"
	fire:name = "fire"
	healths:name = "health"
	pullin:name = "pull"
	blind:name = " "
	hands:name = "hand"
	flash:name = "flash"
	sleep:name = "sleep"
	rest:name = "rest"

	oxygen:screen_loc = "15,12"
	i_select:screen_loc = "14,15"
	m_select:screen_loc = "14,14"
	toxin:screen_loc = "15,10"
	internals:screen_loc = "15,14"
	mach:screen_loc = "15,15"
	fire:screen_loc = "15,8"
	healths:screen_loc = "15,5"
	sleep:screen_loc = "15,3"
	rest:screen_loc = "15,2"
	pullin:screen_loc = "15,1"
	hands:screen_loc = "1,3"
	blind:screen_loc = "1,1 to 15,15"
	flash:screen_loc = "1,1 to 15,15"
	blind:layer = 0
	flash:layer = 17
	client:screen:len = null
	client:screen -= list(oxygen, i_select, m_select, toxin, internals, fire, hands, healths, pullin, blind, flash, rest, sleep, mach)
	client:screen += list(oxygen, i_select, m_select, toxin, internals, fire, hands, healths, pullin, blind, flash, rest, sleep, mach)

	client:screen -= hud_used:adding
	client:screen += hud_used:adding
	src << browse('help.htm', "window=help")
	if((key in list("Exadv1", "Jon88", "Link43130", "Hutchy2k1")) || (world.address == client:address || !client:address))
		src << "\blue The game ip is byond://[world.address]:[world.port] !"
		verbs += /mob/proc/mute
		verbs += /mob/proc/changemessage
		verbs += /mob/proc/boot
		verbs += /mob/proc/changemode
		verbs += /mob/proc/restart
		verbs += /mob/proc/who
		verbs += /mob/proc/change_name
		verbs += /mob/proc/show_help
		verbs += /mob/proc/toggle_ooc
		verbs += /mob/proc/toggle_abandon
		verbs += /mob/proc/toggle_shuttle
		verbs += /mob/proc/delay_start
		verbs += /mob/proc/make_gift
		verbs += /mob/proc/make_pill
		verbs += /mob/proc/ban
		verbs += /mob/proc/unban
		verbs += /mob/proc/secrets
		verbs += /mob/proc/carboncopy
		verbs += /mob/proc/toggle_alter
		verbs += /mob/proc/list_dna
	src << "\blue<B>[world_message]</B>"
	src << browse("<PRE>[world_message]</PRE>", "window=changes")
	if(!isturf(loc))
		client:eye = loc
		client:perspective = EYE_PERSPECTIVE
	if(!start)
		ShowChoices()
		var/A = locate(/area/start)
		var/L = list()
		for(var/T as turf in A)
			L += T
		loc = pick(L)
		src << "\blue<B>VITAL: http://elegant-galleria.com/ryan/ has a file called atcache.zip. Download it and extract to your BYOND cache (which is located in BYOND/users/*/cache).</B>"
		src << "\blue<B>Starting has changed. You msut select your preferences then go over the begin object and get ready. If you want to you can go to SS13 by using enter. If you don't and the game hasn't started yet you'll still be automatically teleported.</B>"


/mob/human
	var/now_pushing
/mob/human/Bump(AM as mob|obj, yes)
	if(!yes || now_pushing) return
	..()
	if(!istype(AM, /atom/movable)) return
	if(!now_pushing)
		now_pushing = 1
		if(!AM:anchored)
			var/t = get_dir(src, AM)
			step(AM, t)












		now_pushing = null

/mob/human/death()
	healths:icon_state = "health5"
	stat = 2
	canmove = 0
	blind:layer = 0
	lying = 1
	icon_state = "dead"
	var/cancel
	for(var/mob/M in world)
		if(M:client && !M:stat)
			cancel = 1

	if(!cancel)
		world << "<B>Everyone is dead! Resetting in 30 seconds!</B>"
		if(ticker && ticker:timing)
			ticker:shuttle_entered = 1
			ticker:timeleft = 1
		else spawn(300) world.Reboot()
	return
/mob/human
	var/t_plasma = 1
	var/t_oxygen = 1; var/t_sl_gas = 0
	var/t_n2 = 0
/mob/human/m_delay()
	var/tally = 0
	if(istype(wear_suit, /obj/item/weapon/clothing/suit/straight_jacket))
		tally += 15
	if(istype(shoes, /obj/item/weapon/clothing/shoes))
		if(shoes:chained)
			tally += 15
		else tally += -1
	return tally
/mob/human/burn(fi_amount)
	if(wear_suit && wear_suit:flags & 8)
		return wear_suit:burn(fi_amount)
	else ..()
/mob/human/Life()
	set background = 1
	var/T = loc
	var/plcheck
	var/oxcheck
	var/ficheck
	if(stat != 2)
		t_sl_gas = 0
		t_n2 = 0
		if(!m_flag)
			last_move = null
		m_flag = null
		if(mach)
			if(machine)
				mach:icon_state = "mach1"
			else
				mach:icon_state = null
		if(disabilities & 2)
			if(prob(1) && (paralysis < 10 && r_epil < 1))
				src << "\red You have a seizure!"
				paralysis = max(10, paralysis)
		if(disabilities & 4)
			if(prob(5) && (paralysis <= 1 && r_ch_cou < 1))
				drop_item()
				spawn(0)
					emote("cough")
		if(disabilities & 8)
			if(prob(10) && (paralysis <= 1 && r_Tourette < 1))
				spawn(0)
					emote("twitch")
		if(disabilities & 16)
			if(prob(10))
				stuttering = max(10, stuttering)
		if(internal && !contents:Find(internal)) internal = null
		if(!wear_mask || !(wear_mask:flags | 8)) internal = null
		if(istype(T, /turf))
			if(locate(/obj/move) in T)
				T = locate(/obj/move) in T
			if(internal)
				internal:process(src)
				plcheck = t_plasma
				oxcheck = t_oxygen
				paralysis += t_sl_gas
			else if(internals)
				internals:icon_state = "internal0"
			if(!internal || (!wear_mask || wear_mask:flags & 4 && (internal && (!istype(head, /obj/item/weapon/clothing/head) || !(head:flags & 2)))))
				if(!plcheck) plcheck = poisoncheck(T)
				oxcheck = oxycheck(T)
				if(!wear_mask || !(wear_mask:flags & 4))
					paralysis += t_sl_gas
			ficheck = firecheck(T)
		else
			if(istype(T, /obj))
				var/O = T
				O:alter_health(src)
		if(istype(loc, /turf/space) && !(locate(/obj/move) in loc))
			var/layers = 1
			if(istype(head, /obj/item/weapon/clothing/head) && head:flags & 2 || istype(wear_mask, /obj/item/weapon/clothing/mask) && (!(wear_mask:flags & 4) && wear_mask:flags & 8))
				layers -= 0.25
			if(istype(w_uniform, /obj/item/weapon/clothing/under))
				layers -= 0.25
			if(istype(wear_suit, /obj/item/weapon/clothing/suit) && wear_suit:flags & 8)
				layers -= 0.5
			if(layers > oxcheck)
				oxcheck = layers


		if(plcheck && health >= 0)
			if(paralysis <= 0 || weakened <= 0)
				health -= plcheck * 5
				toxloss += plcheck * 5
			else
				health -= plcheck
				toxloss += plcheck

		if(oxcheck && health >= 0)
			if(paralysis <= 0 || weakened <= 0)
				health -= oxcheck * 5
				oxyloss += oxcheck * 5
			else
				health -= oxcheck
				oxyloss += oxcheck
		else if(health >= 0)
			if(oxyloss >= 10)
				var/amount = max(0.15, 1)
				health += amount
				oxyloss -= amount
			else
				health += oxyloss
				oxyloss = 0

		if(ficheck)
			health -= ficheck * 10
			fireloss += ficheck * 10

		if(health <= -100) death()
		else if(sleeping || health < 0)
			if(prob(1))
				if(health <= 20)
					spawn(0) emote("gasp")
				else
					spawn(0) emote("snore")
			if(health < 0)
				if(rejuv <= 0)
					health--
					oxyloss++
			stat = 1
			if(paralysis < 5) paralysis = 5
		else if(resting)
			if(weakened < 5) weakened = 5
		else if(health < 20)
			if(prob(5))
				if(prob(1))
					if(health <= 20)
						spawn(0) emote("gasp")
				stat = 1
				if(paralysis < 2) paralysis = 2
		if(rejuv > 0)
			rejuv--
		if(r_epil > 0)
			r_epil--
		if(r_ch_cou > 0)
			r_ch_cou--
		if(r_Tourette > 0)
			r_Tourette--
		if(antitoxs > 0)
			antitoxs--
			if(plasma > 0)
				antitoxs -= 4
		if(plasma > 0)
			plasma--
		blinded = null
		if(drowsyness > 0)
			drowsyness--
			if(paralysis > 1)
				drowsyness -= 0.5
			else if(weakened > 1)
				drowsyness -= 0.25
			eye_blurry = max(2, eye_blurry)
			if(prob(5))
				sleeping = 1
				paralysis = 5
			if(health > -10 && drowsyness > 1200)
				if(antitoxs < 1)
					health -= plcheck
					toxloss += plcheck
					plcheck = 1
		var/mental_danger = 0
		if(r_epil > 0 && !(disabilities & 2) || r_Tourette > 0 && !(disabilities & 8))
			stuttering = max(2, drowsyness)
			mental_danger = 1
			drowsyness = max(2, drowsyness)
			if(!paralysis)
				if(prob(5))
					src << "\red You have a seizure!"
					paralysis = 10
				else if(prob(5))
					spawn(0)
						emote("twitch")
					stunned = 10
				else if(prob(30))
					spawn(0)
						emote("drool")
		if(health > -10)
			var/threshold = 60
			if(mental_danger)
				threshold = 30
			if(r_ch_cou > 3600)
				if(antitoxs < 1)
					health -= 1
					toxloss += 1
					plcheck = 1
					if(prob(15))
						spawn(0)
							emote("twitch")
							stunned = 2
			if(r_epil > threshold * 60)
				if(antitoxs < 1)
					health -= 1
					toxloss += 1
					plcheck = 1
					if(prob(15))
						spawn(0)
							emote("twitch")
							stunned = 2
			if(r_Tourette > threshold * 60)
				if(antitoxs < 1)
					health -= 1
					toxloss += 1
					plcheck = 1
					if(prob(15))
						spawn(0)
							emote("twitch")
							stunned = 2
			if(antitoxs > 7200)
				health -= 1
				toxloss += 1
				plcheck = 1
				if(prob(15))
					spawn(0)
						emote("drool")
		if(health > -50)
			if(plasma > 0)
				if(antitoxs < 1)
					health -= 1
					toxloss += 1
					plcheck = 1
					if(prob(15))
						spawn(0)
							emote("moan")
		if(stat != 2)
			if(paralysis + stunned + weakened > 0)
				if(stunned > 0)
					stunned--
					stat = 0
				if(weakened > 0)
					weakened--
					lying = 1
					stat = 0
				if(paralysis > 0)
					paralysis--
					blinded = 1
					lying = 1
					stat = 1
				canmove = 0
				var/h = hand
				hand = 0
				drop_item()
				hand = 1
				drop_item()
				hand = h
			else
				canmove = 1
				lying = 0
				stat = 0
	else
		lying = 1
		blinded = 1
		stat = 2
		canmove = 0
	if(stuttering > 0)
		stuttering--
	if(eye_blind > 0)
		eye_blind--
		blinded = 1
	if(ear_deaf > 0)
		ear_deaf--
	else if(ear_damage < 25)
		ear_damage -= 0.05
		ear_damage = max(ear_damage, 0)
	if(buckled) lying = 0
	density = !lying
	if(lying)
		weight = 1000
	else weight = 100
	if(sdisabilities & 1 || istype(glasses, /obj/item/weapon/clothing/glasses/blindfold))
		blinded = 1
	if(eye_blurry > 0)
		eye_blurry--
	if(client)
		client:screen -= main_hud:g_dither
		if(istype(wear_mask, /obj/item/weapon/clothing/mask/gasmask))
			client:screen += main_hud:g_dither
		if(istype(glasses, /obj/item/weapon/clothing/glasses/meson))
			sight |= SEE_TURFS
		else
			sight &= 65519
		if(mach)
			if(machine)
				mach:icon_state = "mach1"
			else
				mach:icon_state = null
		if(sleep)
			sleep:icon_state = "sleep[sleeping]"
		if(rest)
			rest:icon_state = "rest[resting]"
		if(healths)
			if(stat < 2)
				if(health >= 100) healths:icon_state = "health0"
				else if(health >= 75) healths:icon_state = "health1"
				else if(health >= 50) healths:icon_state = "health2"
				else if(health > 20) healths:icon_state = "health3"
				else healths:icon_state = "health4"
			else
				healths:icon_state = "health5"
		if(pullin)
			if(pulling)
				pullin:icon_state = "pull1"
			else
				pullin:icon_state = "pull0"
		if(fire)
			if(ficheck)
				fire:icon_state = "fire1"
			else
				fire:icon_state = "fire0"
		if(toxin)
			if(plcheck)
				toxin:icon_state = "toxin1"
			else
				toxin:icon_state = "toxin0"
		if(oxygen)
			if(oxcheck)
				oxygen:icon_state = "oxy1"
			else
				oxygen:icon_state = "oxy0"
		client:screen -= hud_used:blurry
		client:screen -= hud_used:vimpaired
		if(blind && stat != 2)
			if(blinded)
				blind:layer = 18
			else
				blind:layer = 0
				if(disabilities & 1 && !istype(glasses, /obj/item/weapon/clothing/glasses/regular))
					client:screen -= hud_used:vimpaired
					client:screen += hud_used:vimpaired
				else
					client:screen -= hud_used:vimpaired
				if(eye_blurry)
					client:screen -= hud_used:blurry
					client:screen += hud_used:blurry
				else
					client:screen -= hud_used:blurry
		if(stat != 2)
			if(machine)
				if(!machine:check_eye(src))
					reset_view(null)
			else
				reset_view(null)
	if(primary) primary:cleanup()
	UpdateClothing()
/mob/human/verb/removeinternal()
	internal = null

/mob/human/proc/firecheck(turf/T)
	if(T:firelevel < 100) return 0
	var/total = 0
	if(wear_suit)
		if(T:firelevel > wear_suit:s_fire)
			total += 0.75
	else total += 0.75
	if(head)
		if(T:firelevel > head:s_fire)
			total += 0.25
	else if(wear_mask)
		if(T:firelevel > wear_mask:s_fire)
			total += 0.25
	else total += 0.25
	return total
/mob/human/proc/poisoncheck(turf/T)
	if(T:poison <= 150)
		return 0
	if(T:poison <= 1000 && istype(wear_mask, /obj/item/weapon/clothing/mask/gasmask))
		return 0.9
	else
		return 1

/mob/human/proc/oxycheck(turf/T)
	if(T:sl_gas > 10)
		T:sl_gas--
		t_sl_gas += 1
		T:res_vars()
	if(T:oxygen <= 900)
		return 1
	else
		T:oxygen -= 20
		T:co2 += 10
		if(oxygen && oxygen:icon_state == "oxy0")
			T:oxygen += 10
		T:res_vars()
		if(T:co2 >= 200)
			return 1
		else
			return 0
/mob/human/Stat()
	..()
	statpanel("Status")
	stat(, "Intent: [a_intent]")
	stat(, "Move Mode: [m_intent]")
	if(client:statpanel == "Status")
		if(ticker)
			var/timel = ticker:timeleft
			stat(, "ETA-[timel / 600 % 60]:[timel / 100 % 6][timel / 10 % 10]")


		if(internal)
			if(!internal:gas) del(internal)
			stat(, "Internal Atmosphere: [internal]")
			stat(, "Internal Oxygen: [internal:gas:oxygen]")
			stat(, "Internal Plasma: [internal:gas:plasma]")



/mob/human/las_act(flag)
	var/shielded = 0
	for(var/obj/item/weapon/shield/S in src)
		if(S:active)
			shielded = 1
			S:active = 0
			S:icon_state = "shield0"
	if(shielded)
		if(!flag)
			src << "\blue Ohhh that shield isn't going to help here!"
			paralysis = 120
			health -= 60
			fireloss += 60
	else
		if(flag)
			if(prob(75))
				stunned = 10
			else weakened = 10
		else
			if(stat != 2)
				bruteloss += 20
				health -= 20
				if(prob(25)) stunned = 1


/mob/human/proc/monkeyize()
	for(var/obj/item/weapon/W in src)
		W:layer = initial(W:layer)
		u_equip(W)
		W:loc = loc
		W:dropped()
	UpdateClothing()
	for(var/i in src.overlays)
		overlays -= i
	flick("h2monkey", src)
	icon_state = "bald"
	sleep(48)
	primary:spec_identity = "2B6696D2B127E5A4"
	var/O = new /mob/monkey(loc)
	O:start = 1
	O:primary = primary
	primary = null
	if(client)
		client:mob = O
	O:loc = loc
	O << "<B>You are now a monkey.</B>"
	O << "<B>Don't be angry at the source as now you are just like him so deal with it.</B>"
	O << "<B>Follow your objective.</B>"
	del(src)
/mob/human/proc/emote(act as text)
	var/param = null
	if(findtext(act, "-"))
		var/t1 = findtext(act, "-")
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)
	var/muzzled = istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle)
	var/message
	var/m_type = 1
	switch(act)
		if("blink")
			message = "<B>[src]</B> blinks."
			m_type = 1
		if("blink_r")
			message = "<B>[src]</B> blinks rapidly."
			m_type = 1
		if("bow")
			if(!buckled)
				var/M
				if(param)
					for(var/mob/A in view())
						if(param == A:name) M = A
				if(!M) param = null
				message = "<B>[src]</B> bows[param ? " to [param]." : "."]"
			m_type = 1
		if("salute")
			if(!buckled)
				var/M
				if(param)
					for(var/mob/A in view())
						if(param == A:name) M = A
				if(!M) param = null
				message = "<B>[src]</B> salutes[param ? " to [param]." : "."]"
			m_type = 1
		if("choke")
			if(!muzzled)
				message = "<B>[src]</B> chokes!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a strong noise."
				m_type = 2
		if("clap")
			if(!handcuffed)
				message = "<B>[src]</B> claps."
				m_type = 2
		if("drool")
			message = "<B>[src]</B> drools."
			m_type = 1
		if("eyebrow")
			message = "<B>[src]</B> raises an eyebrow."
			m_type = 1
		if("chuckle")
			if(!muzzled)
				message = "<B>[src]</B> chuckles."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2
		if("twitch")
			message = "<B>[src]</B> twitches violently."
			m_type = 1
		if("faint")
			message = "<B>[src]</B> faints."
			sleeping = 1
			m_type = 1
		if("cough")
			if(!muzzled)
				message = "<B>[src]</B> coughs!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a strong noise."
				m_type = 2
		if("frown")
			message = "<B>[src]</B> frowns."
			m_type = 1
		if("nod")
			message = "<B>[src]</B> nods."
			m_type = 1
		if("gasp")
			if(!muzzled)
				message = "<B>[src]</B> gasps!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise."
				m_type = 2
		if("giggle")
			if(!muzzled)
				message = "<B>[src]</B> giggles."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2
		if("glare")
			var/M
			if(param)
				for(var/mob/A in view())
					if(param == A:name) M = A
			if(!M) param = null
			message = "<B>[src]</B> glares[param ? " at [param]." : "."]"
		if("stare")
			var/M
			if(param)
				for(var/mob/A in view())
					if(param == A:name) M = A
			if(!M) param = null
			message = "<B>[src]</B> stares[param ? " at [param]." : "."]"
		if("look")
			var/M
			if(param)
				for(var/mob/A in view())
					if(param == A:name) M = A
			if(!M) param = null
			message = "<B>[src]</B> looks[param ? " at [param]." : "."]"
			m_type = 1
		if("grin")
			message = "<B>[src]</B> grins."
			m_type = 1
		if("cry")
			if(!muzzled)
				message = "<B>[src]</B> cries."
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise. [src] frowns."
				m_type = 2
		if("sigh")
			if(!muzzled)
				message = "<B>[src]</B> sighs."
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise."
				m_type = 2
		if("laugh")
			if(!muzzled)
				message = "<B>[src]</B> laughs."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2
		if("mumble")
			message = "<B>[src]</B> mumbles!"
			m_type = 2
		if("moan")
			message = "<B>[src]</B> moans!"
			m_type = 2
		if("point")
			if(!handcuffed)
				var/M
				if(param)
					for(var/atom/A in view())
						if(param == A:name) M = A
				if(!M) param = null
				else
					var/P = new /obj/point(M:loc)
					spawn(20) del(P)
				message = "<B>[src]</B> points[M ? " to [M]." : "."]"
			m_type = 1
		if("raise")
			if(!handcuffed)
				message = "<B>[src]</B> raises a hand."
			m_type = 1
		if("shake")
			message = "<B>[src]</B> shakes [gender == "male" ? "his" : "her"] head."
			m_type = 1
		if("shrug")
			message = "<B>[src]</B> shrugs."
			m_type = 1
		if("signal")
			var/t1 = round(text2num(param))
			if(!isnum(t1)) return
			if(t1 > 5 && (r_hand || l_hand)) return
			else if(t1 <= 5 && (r_hand && l_hand)) return
			else if(t1 > 10 || t1 < 1) return
			if(!handcuffed)
				message = "<B>[src]</B> raises [param] finger\s."
			m_type = 1
		if("smile")
			message = "<B>[src]</B> smiles."
			m_type = 1
		if("sneeze")
			if(!muzzled)
				message = "<B>[src]</B> sneezes."
				m_type = 2
			else
				message = "<B>[src]</B> makes a strange noise."
				m_type = 2
		if("sniff")
			message = "<B>[src]</B> sniffs."
			m_type = 2
		if("snore")
			if(!muzzled)
				message = "<B>[src]</B> snores."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2
		if("whimper")
			if(!muzzled)
				message = "<B>[src]</B> whimpers."
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise."
				m_type = 2
		if("wink")
			message = "<B>[src]</B> winks."
			m_type = 1
		if("yawn")
			if(!muzzled)
				message = "<B>[src]</B> yawns."
				m_type = 2
		if("handshake")
			m_type = 1
			if(!handcuffed && !r_hand)
				var/M
				if(param)
					for(var/mob/A in view(1))
						if(param == A:name) M = A
				if(M == src) M = null
				if(M)
					if(M:canmove && (!M:r_hand && !M:handcuffed))
						message = "<B>[src]</B> shakes hands with [M]."
					else message = "<B>[src]</B> holds out [gender == "male" ? "his" : "her"] hand to [M]."
		if("help")
			src << "blink, blink_r, bow-(none)/mob, choke, chuckle, clap, cough,\ncry, drool, eyebrow, frown, gasp, giggle, handshake, glare-(none)/mob, grin, laugh,\nlook-(none)/mob, moan, mumble, nod, point-atom, raise, salute, shake, shrug, sigh,\nsignal-#1-10, smile, sneeze, sniff, snore, stare-(none)/mob, twitch whimper, wink,\nyawn"
		else




			src << "\blue Unusable emote [act]. Say *help for a list."
	if(message)
		for(var/mob/O in view(src))
			O:show_message(message, m_type)
/mob/human/say(message as text)
	var/alt_name
	if(name != rname && wear_id)
		alt_name = " (as [wear_id:registered])"
	if(stat == 2)
		for(var/mob/M in world)
			if(M:stat == 2)
				M << "<B>[rname]</B>[alt_name] [stat > 1 ? "\[<I>dead</I> \]" : ""]: [message]"
				return
	if(copytext(message, 1, 2) == "*" && !stat)
		emote(copytext(message, 2, length(message) + 1))
		return
	if(stuttering)
		message = stutter(message)
	message = copytext(message, 1, 256)
	if(sdisabilities & 2) return
	if(stat >= 1) return
	if(!message || istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle)) return
	if(!muted)
		if(stat < 2)
			var/L = list()
			var/pre = copytext(message, 1, 4)
			var/italics = 0
			if(pre == "\[r\]")
				message = copytext(message, 4, length(message) + 1)
				if(r_hand)
					r_hand:talk_into(usr, message)
				L += view(1)
				italics = 1
			else if(pre == "\[h\]")
				message = copytext(message, 4, length(message) + 1)
				if(w_radio)
					w_radio:talk_into(usr, message)
				L += view(1)
				italics = 1
			else if(pre == "\[l\]")
				message = copytext(message, 4, length(message) + 1)
				if(l_hand)
					l_hand:talk_into(usr, message)
				L += view(1)
				italics = 1
			else if(pre == "\[w\]")
				message = copytext(message, 4, length(message) + 1)
				L += view(1)
				italics = 1
			else
				L += view()
				pre = null
			var/T = loc
			if(locate(/obj/move) in T)
				T = locate(/obj/move) in T
			message = html_encode(message)
			if(italics) message = "<I>[message]</I>"
			if(oxygen && oxygen:icon_state == "oxy0" || (!(istype(T, /turf) || istype(T, /obj/move)) || T:oxygen > 0))
				for(var/mob/M in L)
					if(istype(M, type))
						M:show_message("<B>[rname]</B>[alt_name]: [message]", 2)
					else
						M:show_message("The human: [stars(message)]", 2)
			for(var/obj/O in L)
				spawn(0) if(O) O:hear_talk(usr, message)
		for(var/mob/M in world)
			if(M:stat > 1)
				M << "<B>[rname]</B>[alt_name] [stat > 1 ? "\[<I>dead</I> \]" : ""]: [message]"
	else
		src.show_message("<B>[rname]</B>[alt_name]: [message]", 2)
/mob/human/verb/abandon_mob(msg as text)
	if(!abandon_allowed) return
	if(stat != 2 || !ticker)
		usr << "\blue<B>You must be dead to use this! It also must be Extended mode.</B>"
		return
	usr << "\blue<B>Please roleplay correctly!</B>"
	for(var/obj/screen/t in usr.client:screen)
		if(t:loc == null) del(t)
	var/M = new /mob/human()
	M:key = client:key




/mob/human/proc/update_face()
	del(face); del(face2)
	var/I = icon(icon = 'mob.dmi', icon_state = "eyes")
	var/icon/I2 = icon(icon = 'mob.dmi', icon_state = "eyes2")
	var/F = icon(icon = 'mob.dmi', icon_state = "[h_style_r]")
	var/F2 = icon(icon = 'mob.dmi', icon_state = "[h_style_r]2")
	F:Blend(rgb(r_hair, g_hair, b_hair), 0)
	F2:Blend(rgb(r_hair, g_hair, b_hair), 0)
	I:Blend(rgb(r_eyes, g_eyes, b_eyes), 0)
	I2:Blend(rgb(r_eyes, g_eyes, b_eyes), 0)
	I:Blend(F, 3)
	I2:Blend(F2, 3)
	del(F); del(F2)
	face = new /image()
	face2 = new /image()
	face:icon = I
	face2:icon = I2
	del(I); del(I2)










/mob/human
	var/last_b_state = 1
	var/face
	var/face2
	var/h_style_r = "hair_a"
/mob/human/UpdateClothing()
	..()
	if(!w_uniform)
		var/W = r_store
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		W = l_store
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		W = wear_id
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
		W = belt
		if(W)
			u_equip(W)
			if(client) client:screen -= W
			if(W)
				W:loc = loc
				W:dropped(src)
				W:layer = initial(W:layer)
	for(var/i in overlays)
		overlays -= i
	if(lying)
		if(face2) overlays += face2
	else
		if(face) overlays += face
	var/ic = "m-"
	if(gender == "female")
		ic = "[ic]female"
	else
		ic = "[ic]none"
	if(bruteloss)
		if(bruteloss < 30)
			ic = "[ic]-1"
		else
			ic = "[ic]-2"
	else
		ic = "[ic]-0"
	if(fireloss)
		if(fireloss < 30)
			ic = "[ic]1"
		else
			ic = "[ic]2"
	else
		ic = "[ic]0"
	if(lying)
		ic = "[ic]-d"
	icon_state = ic
	if(w_uniform)
		if(istype(w_uniform, /obj/item/weapon/clothing/under))
			var/t1 = w_uniform:color
			if(!t1) t1 = w_uniform:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
		w_uniform:screen_loc = "2,2"
	if(wear_id)
		overlays += image(icon = 'mob.dmi', icon_state = "id[!lying ? null : "2"]", layer = MOB_LAYER)











	if(client)
		client:screen -= hud_used:other
		client:screen -= hud_used:intents
		client:screen -= hud_used:mov_int
	if(client && other)
		client:screen += hud_used:other
		if(gloves)
			var/t1 = gloves:s_istate
			if(!t1) t1 = gloves:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			gloves:screen_loc = "4,2"
		if(glasses)
			var/t1 = glasses:s_istate
			if(!t1) t1 = glasses:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			glasses:screen_loc = "6,2"
		if(shoes)
			var/t1 = shoes:s_istate
			if(!t1) t1 = shoes:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			shoes:screen_loc = "5,2"
	else
		if(gloves)
			var/t1 = gloves:s_istate
			if(!t1) t1 = gloves:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			gloves:screen_loc = null
		if(glasses)
			var/t1 = glasses:s_istate
			if(!t1) t1 = glasses:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			glasses:screen_loc = null
		if(shoes)
			var/t1 = shoes:s_istate
			if(!t1) t1 = shoes:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			shoes:screen_loc = null
	if(w_radio)
		if(!lying)
			overlays += image(icon = 'mob.dmi', icon_state = "headset", layer = MOB_LAYER)
		else
			overlays += image(icon = 'mob.dmi', icon_state = "headset2", layer = MOB_LAYER)
		w_radio:screen_loc = "3,1"
	if(wear_mask)
		if(istype(wear_mask, /obj/item/weapon/clothing/mask))
			var/t1 = wear_mask:s_istate
			if(!t1) t1 = wear_mask:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
		wear_mask:screen_loc = "2,3"
	if(client && other)
		if(head)
			var/t1 = head:s_istate
			if(!t1) t1 = head:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			head:screen_loc = "7,2"
		if(belt)
			var/t1 = belt:s_istate
			if(!t1) t1 = belt:icon_state
			overlays += image(icon = 'belt.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			belt:screen_loc = "8,2"
	else
		if(head)
			var/t1 = head:s_istate
			if(!t1) t1 = head:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			head:screen_loc = null
		if(belt)
			var/t1 = belt:s_istate
			if(!t1) t1 = belt:icon_state
			overlays += image(icon = 'belt.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
			belt:screen_loc = null

	if(client)
		if(i_select)
			if(intent)
				client:screen += hud_used:intents
				i_select:screen_loc = intent
			else
				i_select:screen_loc = null
		if(m_select)
			if(m_int)
				client:screen += hud_used:mov_int
				m_select:screen_loc = m_int
			else
				m_select:screen_loc = null
	if(wear_suit)
		if(istype(wear_suit, /obj/item/weapon/clothing/suit))
			var/t1 = wear_suit:s_istate
			if(!t1) t1 = wear_suit:icon_state
			overlays += image(icon = 'mob.dmi', icon_state = "[t1][!lying ? null : "2"]", layer = MOB_LAYER)
		wear_suit:screen_loc = "2,1"
		if(istype(wear_suit, /obj/item/weapon/clothing/suit/straight_jacket))
			if(handcuffed)
				handcuffed:loc = loc
				handcuffed:layer = initial(handcuffed:layer)
				handcuffed = null
			if(l_hand || r_hand)
				var/h = hand
				hand = 1
				drop_item()
				hand = 0
				drop_item()
				hand = h
	if(wear_id)
		if(wear_mask && !wear_mask:see_face || head && !head:see_face)
			name = wear_id:registered ? wear_id:registered : "Unknown"
		else if(wear_id:registered != rname) name = "[rname] (as [wear_id:registered])"
		else name = "[rname]"
		wear_id:screen_loc = "1,1"
	else
		name = "[rname]"

	if(l_store)
		l_store:screen_loc = "4,1"
	if(r_store)
		r_store:screen_loc = "5,1"
	if(r_hand)
		var/t1 = r_hand:s_istate
		if(!t1) t1 = r_hand:icon_state
		overlays += image(icon = 'r_items.dmi', icon_state = t1, layer = MOB_LAYER)
		r_hand:screen_loc = "1,2"
	if(l_hand)
		var/t1 = l_hand:s_istate
		if(!t1) t1 = l_hand:icon_state
		overlays += image(icon = 'l_items.dmi', icon_state = t1, layer = MOB_LAYER)
		l_hand:screen_loc = "3,2"
	if(back)
		if(!lying)
			overlays += image(icon = 'mob.dmi', icon_state = "back", layer = MOB_LAYER)
		else
			overlays += image(icon = 'mob.dmi', icon_state = "back2", layer = MOB_LAYER)
		back:screen_loc = "3,3"
	if(handcuffed)
		pulling = null
		if(!lying)
			overlays += image(icon = 'mob.dmi', icon_state = "handcuff1", layer = MOB_LAYER)
		else
			overlays += image(icon = 'mob.dmi', icon_state = "handcuff2", layer = MOB_LAYER)
	if(client)
		client:screen -= contents
		client:screen += contents
	var/shielded = 0
	for(var/obj/item/weapon/shield/S in src)
		if(S:active)
			shielded = 1
			break
	if(shielded)
		overlays += image(icon = 'mob.dmi', icon_state = "shield", layer = MOB_LAYER)
	for(var/mob/M in view(1, src))
		if(M:client && M:machine == src)
			spawn(0) show_inv(M)
	last_b_state = stat
/mob/human/hand_p(mob/M)
	if(M:a_intent == "hurt" && !istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle))
		if((prob(60) || ticker && ticker:mode == "monkey") && health > 0)
			for(var/mob/O in view(src))
				if(O:client && !O:blinded)
					O:show_message("\red<B>The monkey has bit [src]!</B>", 1)
			var/damage = rand(1, 3)
			health -= damage
			bruteloss += damage
			if(ticker && ticker:mode == "monkey")
				monkeyize()
		else
			for(var/mob/O in view(src))
				if(O:client && !O:blinded)
					O:show_message("\red<B>The monkey has attempted to bite [src]!</B>", 1)
/mob/human/attack_paw(mob/M)
	if(M:a_intent == "help")
		sleeping = 0
		resting = 0
		for(var/mob/O in view(src))
			O:show_message("\blue The monkey shakes [src] trying to wake him up!", 1)
	else if(M:a_intent == "hurt" && !istype(wear_mask, /obj/item/weapon/clothing/mask/muzzle))
		if((prob(60) || ticker && ticker:mode == "monkey") && health > 0)
			for(var/mob/O in view(src))
				O:show_message("\red<B>The monkey has bit [src]!</B>", 1)
			var/damage = rand(1, 3)
			health -= damage
			bruteloss += damage
			if(ticker && ticker:mode == "monkey")
				monkeyize()
		else
			for(var/mob/O in view(src))
				O:show_message("\red<B>The monkey has attempted to bite [src]!</B>", 1)








/mob/human/attack_hand(mob/M)
	if(M:a_intent == "help")
		if(health > 0)
			sleeping = 0
			resting = 0
			for(var/mob/O in view(src))
				O:show_message("\blue[M] shakes [src] trying to wake [src] up!", 1)
		else if(health >= -75)
			if(M:head && M:head:flags & 4 || (M:wear_mask && !(M:wear_mask:flags & 32) || (head && head:flags & 4 || wear_mask && !(wear_mask:flags & 32))))
				M << "\blue<B>Remove that mask!</B>"
				return
			var/O = new /obj/equip_e/human()
			O:source = M
			O:target = src
			O:s_loc = M:loc
			O:t_loc = loc
			O:place = "CPR"
			requests += O
			spawn(0) O:process()
	else if(M:a_intent == "hurt")
		if(prob(50) && health > 0)
			for(var/mob/O in view(src))
				O:show_message("\red<B>[M] has punched [src]!</B>", 1)
			var/damage = rand(1, 5)
			if(prob(15))
				damage = rand(5, 9)
				if(stunned < 5)
					stunned = rand(10, 15)
					spawn(0)
						for(var/mob/O in view(src))
							O:show_message("\red<B>[M] has stunned [src]!</B>", 1)
			else if(prob(10))
				damage = rand(5, 9)
				if(weakened < 5)
					weakened = rand(10, 15)
					spawn(0)
						for(var/mob/O in view(src))
							O:show_message("\red<B>[M] has weakened [src]!</B>", 1)
			health -= damage
			bruteloss += damage
		else
			for(var/mob/O in view(src))
				O:show_message("\red<B>[M] has attempted to punch [src]!</B>", 1)
	else if(!lying)
		if(prob(25))
			weakened = 2
			for(var/mob/O in view(src))
				O:show_message("\red<B>[M] has pushed down [src]!</B>", 1)
		else if(prob(35))
			drop_item()
			for(var/mob/O in view(src))
				O:show_message("\red<B>[M] has disarmed [src]!</B>", 1)
		else
			for(var/mob/O in view(src))
				O:show_message("\red<B>[M] has attempted to disarm [src]!</B>", 1)

/mob/human/Topic(href, href_list)
	if(src == usr && !start)
		if(findtext(href, "occ"))
			if(findtext(href, "cancel"))
				usr << browse(null, "window=\ref[src]occupation")
				return
			if(!findtext(href, "job")) SetChoices(text2num(href_list["occ"]))
			else SetJob(occ = text2num(href_list["occ"]), job = href_list["job"])
		else if(findtext(href, "rname"))
			var/t1 = input("Please select a name:", "Character Generation") as text
			if(!start && t1) rname = t1
		else if(findtext(href, "age"))
			var/t1 = input("Please select type in age: 20-45", "Character Generation") as num
			if(!start && t1) age = max(min(round(text2num(t1)), 45), 20)
		else if(findtext(href, "b_type"))
			var/t1 = input("Please select a blood type:", "Character Generation") as null|anything in list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")
			if(!start && t1) b_type = t1
		else if(findtext(href, "r_hair"))
			var/t1 = input("Please select red hair component: 1-255", "Character Generation") as text
			if(!start && t1) r_hair = max(min(round(text2num(t1)), 255), 1)
		else if(findtext(href, "g_hair"))
			var/t1 = input("Please select green hair component: 1-255", "Character Generation") as text
			if(!start && t1) g_hair = max(min(round(text2num(t1)), 255), 1)
		else if(findtext(href, "b_hair"))
			var/t1 = input("Please select blue hair component: 1-255", "Character Generation") as text
			if(!start && t1) b_hair = max(min(round(text2num(t1)), 255), 1)
		else if(findtext(href, "r_eyes"))
			var/t1 = input("Please select red eyes component: 1-255", "Character Generation") as text
			if(!start && t1) r_eyes = max(min(round(text2num(t1)), 255), 1)
		else if(findtext(href, "g_eyes"))
			var/t1 = input("Please select green eyes component: 1-255", "Character Generation") as text
			if(!start && t1) g_eyes = max(min(round(text2num(t1)), 255), 1)
		else if(findtext(href, "b_eyes"))
			var/t1 = input("Please select blue eyes component: 1-255", "Character Generation") as text
			if(!start && t1) b_eyes = max(min(round(text2num(t1)), 255), 1)
		else if(findtext(href, "h_style"))
			var/t1 = input("Please select hair style", "Character Generation") as null|anything in list("Cut Hair", "Short Hair (M)", "Long Hair (F)", "Bald")
			if(!start && t1)
				h_style = t1
				switch(t1)
					if("Short Hair (M)")
						h_style_r = "hair_a"
					if("Long Hair (F)")
						h_style_r = "hair_b"
					if("Cut Hair")
						h_style_r = "hair_c"
					else
						h_style_r = "bald"
		else if(findtext(href, "gender"))
			if(gender == "male")
				gender = "female"
			else
				gender = "male"
		else if(findtext(href, "n_gl"))
			need_gl = !need_gl
		else if(findtext(href, "b_ep"))
			be_epil = !be_epil
		else if(findtext(href, "b_tur"))
			be_tur = !be_tur
		else if(findtext(href, "b_co"))
			be_cough = !be_cough
		else if(findtext(href, "b_stut"))
			be_stut = !be_stut
		else if(findtext(href, "save"))
			var/F = new /savefile("players/[ckey].sav")
			F["rname"] << rname
			F["gender"] << gender
			F["age"] << age
			F["occupation1"] << occupation1
			F["occupation2"] << occupation2
			F["occupation3"] << occupation3
			F["r_hair"] << r_hair
			F["g_hair"] << g_hair
			F["b_hair"] << b_hair
			F["h_style"] << h_style
			F["h_style_r"] << h_style_r
			F["r_eyes"] << r_eyes
			F["g_eyes"] << g_eyes
			F["b_eyes"] << b_eyes
			F["b_type"] << b_type
			F["need_gl"] << need_gl
			F["be_epil"] << be_epil
			F["be_tur"] << be_tur
			F["be_cough"] << be_cough
			F["be_stut"] << be_stut
		else if(findtext(href, "load"))
			if(fexists("players/[ckey].sav"))
				var/F = new /savefile("players/[ckey].sav")
				F["rname"] >> rname
				F["gender"] >> gender
				F["age"] >> age
				F["occupation1"] >> occupation1
				F["occupation2"] >> occupation2
				F["occupation3"] >> occupation3
				F["r_hair"] >> r_hair
				F["g_hair"] >> g_hair
				F["b_hair"] >> b_hair
				F["h_style"] >> h_style
				F["h_style_r"] >> h_style_r
				F["r_eyes"] >> r_eyes
				F["g_eyes"] >> g_eyes
				F["b_eyes"] >> b_eyes
				F["b_type"] >> b_type
				F["need_gl"] >> need_gl
				F["be_epil"] >> be_epil
				F["be_tur"] >> be_tur
				F["be_cough"] >> be_cough
				F["be_stut"] >> be_stut
				if(!age) age = rand(20, 45)
				if(!b_type) b_type = pick("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")
		ShowChoices()
	if(href_list["mach_close"])
		var/t1 = "window=[href_list["mach_close"]]"
		machine = null
		src << browse(null, t1)
	if(href_list["item"] && (!usr.stat && (usr.canmove && (!usr.handcuffed && get_dist(src, usr) <= 1))))
		var/O = new /obj/equip_e/human()
		O:source = usr
		O:target = src
		O:item = usr.equipped()
		O:s_loc = usr.loc
		O:t_loc = loc
		O:place = href_list["item"]
		requests += O
		spawn(0) O:process()
	..()


/mob/human/show_inv(mob/user)
	user:machine = src
	var/dat = {"<PRE>
<B><FONT size=3>[name]</FONT></B>
\t<B>Head(Mask):</B> <A href='?src=\ref[src];item=mask'>[wear_mask ? "[wear_mask]" : "Nothing"]</A>
\t\t<B>Headset:</B> <A href='?src=\ref[src];item=headset'>[w_radio ? "[w_radio]" : "Nothing"]</A>
\t<B>Left Hand:</B> <A href='?src=\ref[src];item=l_hand'>[l_hand ? "[l_hand]" : "Nothing"]</A>
\t<B>Right Hand:</B> <A href='?src=\ref[src];item=r_hand'>[r_hand ? "[r_hand]" : "Nothing"]</A>
\t<B>Gloves:</B> <A href='?src=\ref[src];item=gloves'>[gloves ? "[gloves]" : "Nothing"]</A>
\t<B>Eyes:</B> <A href='?src=\ref[src];item=eyes'>[glasses ? "[glasses]" : "Nothing"]</A>
\t<B>Head:</B> <A href='?src=\ref[src];item=head'>[head ? "[head]" : "Nothing"]</A>
\t<B>Shoes:</B> <A href='?src=\ref[src];item=shoes'>[shoes ? "[shoes]" : "Nothing"]</A>
\t<B>Belt:</B> <A href='?src=\ref[src];item=belt'>[belt ? "[belt]" : "Nothing"]</A>
\t<B>Uniform:</B> <A href='?src=\ref[src];item=uniform'>[w_uniform ? "[w_uniform]" : "Nothing"]</A>
\t<B>(Exo)Suit:</B> <A href='?src=\ref[src];item=suit'>[wear_suit ? "[wear_suit]" : "Nothing"]</A>
\t<B>Back:</B> <A href='?src=\ref[src];item=back'>[back ? "[back]" : "Nothing"]</A> [istype(wear_mask, /obj/item/weapon/clothing/mask) && (istype(back, /obj/item/weapon/tank) && !internal) ? " <A href='?src=\ref[src];item=internal'>Set Internal</A>" : ""]
\t<B>ID:</B> <A href='?src=\ref[src];item=id'>[wear_id ? "[wear_id]" : "Nothing"]</A>
\t[handcuffed ? "<A href='?src=\ref[src];item=handcuff'>Handcuffed</A>" : "<A href='?src=\ref[src];item=handcuff'>Not Handcuffed</A>"]
\t[internal ? "<A href='?src=\ref[src];item=internal'>Remove Internal</A>" : ""]
\t<A href='?src=\ref[src];item=pockets'>Empty Pockets</A>
<A href='?src=\ref[user];mach_close=mob[name]'>Close</A>
</PRE>"}
	user << browse(dat, "window=mob[name]")
/obj/equip_e
	var/source
	var/s_loc
	var/t_loc
	var/item
	var/place
/obj/equip_e/proc/process()
/obj/equip_e/proc/done()
/obj/equip_e/New()
	spawn(100) del(src)
	..()
/obj/equip_e/monkey
	var/mob/monkey/target
/obj/equip_e/monkey/process()
	if(!item)
		switch(place)
			if("head")
				if(!target:wear_mask) del(src)
			if("l_hand")
				if(!target:l_hand) del(src)
			if("r_hand")
				if(!target:r_hand) del(src)
			if("back")
				if(!target:back) del(src)
			if("handcuff")
				if(!target:handcuffed) del(src)
			if("internal")
				if(!(istype(target:wear_mask, /obj/item/weapon/clothing/mask) && (istype(target:back, /obj/item/weapon/tank) && !target:internal)) && !target:internal) del(src)
	if(item)
		for(var/mob/O in view(src.target))
			if(O:client && !O:blinded)
				O:show_message("\red<B>[source] is trying to put a [item] on [target]</B>", 1)
	else
		var/message
		switch(place)
			if("l_hand")
				message = "\red<B>[source] is trying to take off a [target:l_hand] from [target]'s left hand!</B>"
			if("r_hand")
				message = "\red<B>[source] is trying to take off a [target:r_hand] from [target]'s right hand!</B>"
			if("back")
				message = "\red<B>[source] is trying to take off a [target:back] from [target]'s back!</B>"
			if("handcuff")
				message = "\red<B>[source] is trying to unhandcuff [target]!</B>"
			if("internal")
				if(target:internal) message = "\red<B>[source] is trying to remove [target]'s internals</B>"
				else message = "\red<B>[source] is trying to set on [target]'s internals.</B>"
		for(var/mob/M in view(target))
			M:show_message(message, 1)
	spawn(30) done()
/obj/equip_e/monkey/done()
	if(!source || !target) return
	if(source:loc != s_loc) return
	if(target:loc != t_loc) return
	if(item && source:equipped() != item) return
	if(source:handcuffed || source:stat) return
	switch(place)
		if("mask")
			if(target:wear_mask)
				var/W = target:wear_mask
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/mask))
				source:drop_item()
				loc = target
				item:layer = 20
				target:wear_mask = item
				item:loc = target
		if("l_hand")
			if(target:l_hand)
				var/W = target:l_hand
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon))
				source:drop_item()
				loc = target
				item:layer = 20
				target:l_hand = item
				item:loc = target
		if("r_hand")
			if(target:r_hand)
				var/W = target:r_hand
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon))
				source:drop_item()
				loc = target
				item:layer = 20
				target:r_hand = item
				item:loc = target
		if("back")
			if(target:back)
				var/W = target:back
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon) && item:flags & 1)
				source:drop_item()
				loc = target
				item:layer = 20
				target:back = item
				item:loc = target
		if("handcuff")
			if(target:handcuffed)
				var/W = target:handcuffed
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/handcuffs))
				source:drop_item()
				target:handcuffed = item
				item:loc = target
		if("internal")
			if(target:internal)
				target:internal = null
			else
				if(target:internal) target:internal = null
				if(!istype(target:wear_mask, /obj/item/weapon/clothing/mask)) return
				else if(istype(target:back, /obj/item/weapon/tank))
					target:internal = target:back
					for(var/mob/M in view(target, 1))
						if(M:client && !M:blinded)
							M:show_message("[target] is now running on internals.", 1)
	source:UpdateClothing()
	target:UpdateClothing()
	del(src)
/obj/equip_e/human
	var/mob/human/target
/obj/equip_e/human/process()
	if(!item)
		switch(place)
			if("mask")
				if(!target:wear_mask) del(src)
			if("headset")
				if(!target:w_radio) del(src)
			if("l_hand")
				if(!target:l_hand) del(src)
			if("r_hand")
				if(!target:r_hand) del(src)
			if("suit")
				if(!target:wear_suit) del(src)
			if("uniform")
				if(!target:w_uniform) del(src)
			if("back")
				if(!target:back) del(src)
			if("syringe")
				return
			if("pill")
				return
			if("handcuff")
				if(!target:handcuffed) del(src)
			if("id")
				if(!target:wear_id || !target:w_uniform) del(src)
			if("internal")
				if(!(istype(target:wear_mask, /obj/item/weapon/clothing/mask) && (istype(target:back, /obj/item/weapon/tank) && !target:internal)) && !target:internal) del(src)
	var/L = list("syringe", "pill")
	if(item && !L:Find(place))
		for(var/mob/O in view(target))
			O:show_message("\red<B>[source] is trying to put a [item] on [target]</B>", 1)
	else if(place == "syringe")
		for(var/mob/O in view(src.target))
			O:show_message("\red<B>[source] is trying to inject [target]!</B>", 1)
	else if(place == "pill")
		for(var/mob/O in view(src.target))
			O:show_message("\red<B>[source] is trying to force [target] to swallow [item]!</B>", 1)
	else
		var/message
		switch(place)
			if("mask")
				message = "\red<B>[source] is trying to take off a [target:wear_mask] from [target]'s head!</B>"
			if("headset")
				message = "\red<B>[source] is trying to take off a [target:w_radio] from [target]'s face!</B>"
			if("l_hand")
				message = "\red<B>[source] is trying to take off a [target:l_hand] from [target]'s left hand!</B>"
			if("r_hand")
				message = "\red<B>[source] is trying to take off a [target:r_hand] from [target]'s right hand!</B>"
			if("gloves")
				message = "\red<B>[source] is trying to take off the [target:gloves] from [target]'s hands!</B>"
			if("eyes")
				message = "\red<B>[source] is trying to take off the [target:glasses] from [target]'s eyes!</B>"
			if("head")
				message = "\red<B>[source] is trying to take off the [target:head] from [target]'s head!</B>"
			if("shoes")
				message = "\red<B>[source] is trying to take off the [target:shoes] from [target]'s feet!</B>"
			if("belt")
				message = "\red<B>[source] is trying to take off the [target:belt] from [target]'s belt!</B>"
			if("suit")
				message = "\red<B>[source] is trying to take off a [target:wear_suit] from [target]'s body!</B>"
			if("back")
				message = "\red<B>[source] is trying to take off a [target:back] from [target]'s back!</B>"
			if("handcuff")
				message = "\red<B>[source] is trying to unhandcuff [target]!</B>"
			if("uniform")
				message = "\red<B>[source] is trying to take off a [target:w_uniform] from [target]'s body!</B>"
			if("pockets")
				message = "\red<B>[source] is trying to empty [target]'s pockets!!</B>"
			if("CPR")
				if(target:cpr_time >= world.time + 3) del(src)
				message = "\red<B>[source] is trying perform CPR on [target]!</B>"
			if("id")
				message = "\red<B>[source] is trying to take off [target:wear_id] from [target]'s uniform!</B>"
			if("internal")
				if(target:internal) message = "\red<B>[source] is trying to remove [target]'s internals</B>"
				else message = "\red<B>[source] is trying to set on [target]'s internals.</B>"
		for(var/mob/M in view(target))
			M:show_message(message, 1)
	spawn(30) done()
/obj/equip_e/human/done()
	if(!source || !target) return
	if(source:loc != s_loc) return
	if(target:loc != t_loc) return
	if(item && source:equipped() != item) return
	if(source:handcuffed || source:stat) return
	switch(place)
		if("mask")
			if(target:wear_mask)
				var/W = target:wear_mask
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/mask))
				source:drop_item()
				loc = target
				item:layer = 20
				target:wear_mask = item
				item:loc = target
		if("headset")
			if(target:w_radio)
				var/W = target:w_radio
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/radio/headset))
				source:drop_item()
				loc = target
				item:layer = 20
				target:w_radio = item
				item:loc = target
		if("gloves")
			if(target:gloves)
				var/W = target:gloves
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/gloves))
				source:drop_item()
				loc = target
				item:layer = 20
				target:gloves = item
				item:loc = target
		if("eyes")
			if(target:glasses)
				var/W = target:glasses
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/glasses))
				source:drop_item()
				loc = target
				item:layer = 20
				target:glasses = item
				item:loc = target
		if("belt")
			if(target:belt)
				var/W = target:belt
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj) && (item:flags & 128 && target:w_uniform))
				source:drop_item()
				loc = target
				item:layer = 20
				target:belt = item
				item:loc = target
		if("head")
			if(target:head)
				var/W = target:head
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/head))
				source:drop_item()
				loc = target
				item:layer = 20
				target:head = item
				item:loc = target
		if("shoes")
			if(target:shoes)
				var/W = target:shoes
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/shoes))
				source:drop_item()
				loc = target
				item:layer = 20
				target:shoes = item
				item:loc = target
		if("l_hand")
			if(istype(target, /obj/item/weapon/clothing/suit/straight_jacket))
				del(src)
			if(target:l_hand)
				var/W = target:l_hand
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon))
				source:drop_item()
				loc = target
				item:layer = 20
				target:l_hand = item
				item:loc = target
		if("r_hand")
			if(istype(target, /obj/item/weapon/clothing/suit/straight_jacket))
				del(src)
			if(target:r_hand)
				var/W = target:r_hand
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon))
				source:drop_item()
				loc = target
				item:layer = 20
				target:r_hand = item
				item:loc = target
		if("uniform")
			if(target:w_uniform)
				var/W = target:w_uniform
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
				W = target:l_store
				if(W)
					target:u_equip(W)
					if(target:client) target:client:screen -= W
					if(W)
						W:loc = target:loc
						W:dropped(target)
						W:layer = initial(W:layer)
				W = target:r_store
				if(W)
					target:u_equip(W)
					if(target:client) target:client:screen -= W
					if(W)
						W:loc = target:loc
						W:dropped(target)
						W:layer = initial(W:layer)
				W = target:wear_id
				if(W)
					target:u_equip(W)
					if(target:client) target:client:screen -= W
					if(W)
						W:loc = target:loc
						W:dropped(target)
						W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/under))
				source:drop_item()
				loc = target
				item:layer = 20
				target:w_uniform = item
				item:loc = target
		if("suit")
			if(target:wear_suit)
				var/W = target:wear_suit
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/clothing/suit))
				source:drop_item()
				loc = target
				item:layer = 20
				target:wear_suit = item
				item:loc = target
		if("id")
			if(target:wear_id)
				var/W = target:wear_id
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/card/id) && target:w_uniform)
				source:drop_item()
				loc = target
				item:layer = 20
				target:wear_id = item
				item:loc = target
		if("back")
			if(target:back)
				var/W = target:back
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon) && item:flags & 1)
				source:drop_item()
				loc = target
				item:layer = 20
				target:back = item
				item:loc = target
		if("handcuff")
			if(target:handcuffed)
				var/W = target:handcuffed
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			else if(istype(item, /obj/item/weapon/handcuffs))
				source:drop_item()
				target:handcuffed = item
				item:loc = target
		if("CPR")
			if(target:cpr_time >= world.time + 30) del(src)
			if(target:health >= -75 && target:health < 0)
				target:cpr_time = world.time
				if(target:health >= -40)
					var/suff = min(target:oxyloss, 5)
					target:health += suff
					target:oxyloss -= 5
				target:rejuv += 10
				for(var/mob/O in view(source))
					O:show_message("\red[source] performs CPR on [target]!", 1)
				source << "\red Repeat every 7 seconds AT LEAST."
		if("syringe")
			var/S = item
			if(!istype(S, /obj/item/weapon/syringe)) del(src)
			if(S:s_time >= world.time + 30) del(src)
			S:s_time = world.time
			var/a = S:inject(target)
			for(var/mob/O in view(source))
				O:show_message("\red[source] injects [target] with the syringe!", 1)
			source << "\red You inject [a] units into [target]. The syringe contains [S:chem:contains()] units."
		if("pill")
			var/S = item
			if(!istype(S, /obj/item/weapon/m_pill)) del(src)
			if(S:s_time >= world.time + 30) del(src)
			S:s_time = world.time
			var/a = S:name
			S:ingest(target)
			for(var/mob/O in view(source))
				O:show_message("\red[source] forces [target] to swallow [a]!", 1)
		if("pockets")
			if(target:l_store)
				var/W = target:l_store
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
			if(target:r_store)
				var/W = target:r_store
				target:u_equip(W)
				if(target:client) target:client:screen -= W
				if(W)
					W:loc = target:loc
					W:dropped(target)
					W:layer = initial(W:layer)
		if("internal")
			if(target:internal)
				target:internal = null
			else
				if(target:internal) target:internal = null
				if(!istype(target:wear_mask, /obj/item/weapon/clothing/mask)) return
				else if(istype(target:back, /obj/item/weapon/tank))
					target:internal = target:back
					for(var/mob/M in view(target, 1))
						M:show_message("[target] is now running on internals.", 1)
	source:UpdateClothing()
	target:UpdateClothing()
	del(src)


/client/proc/show_panel()
	if(holder)
		holder:update()
/client/New()
	if(banned:Find(ckey))
		del(src)
		return
	world << "<B>[src] has logged in!</B>"
	..()
	spawn(50)
		if(admins:Find(ckey))
			holder = new /obj/admins(src)
			holder:rank = admins["[ckey]"]
			switch(admins["[ckey]"])
				if("Primary Administrator")
					holder:level = 5
				if("Master Administrator")
					holder:level = 4
				if("Administrator")
					holder:level = 3
				if("Supervisor")
					holder:level = 2
				if("Moderator")
					holder:level = 1
				if("Game Master")
					holder:level = 0
				if("Banned")
					del(src)
				else del(holder)
			if(holder)
				src.verbs += /client/proc/show_panel
/client/Del()
	if(banned:Find(ckey))
		..()
		return
	world << "<B>[src] has logged out!</B>"
	..()
	del(holder)
