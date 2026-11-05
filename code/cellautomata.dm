
/atom/proc/check_eye(mob/user)
/atom/verb/point()
	set src in oview()
	if(!usr) return
	if(usr.stat == 0 && !usr.restrained())
		var/P = new /obj/point(isturf(src) ? src : loc)
		spawn(20) del(P)
		for(var/mob/M in view(usr))
			M:show_message("<B>[usr]</B> points to [src]", 1)
/atom/movable/Bump(A as mob|obj|turf|area, yes)
	spawn(0) if(A && yes) A:Bumped(src)
	..()

/atom/proc/Bumped(AM as mob|obj)
/obj/start
	icon_state = "x"
	icon = 'screen1.dmi'
	anchored = 1
/atom
	layer = 2





/obj/start/New()
	..()
	tag = "start*[name]"
	invisibility = 100
/obj/sp_start
	icon_state = "m-none"
	icon = 'mob.dmi'
	anchored = 1
	var/special
/obj/sp_start/New()
	tag = "spstart[name]"
	invisibility = 100
var/going = 1
var/master_mode = "secret"
/turf/proc/updatecell()
/turf/proc/cachecell()
/world/name = "Space Station 13"
/world/hub = "Exadv1.spacestation13"
var/admins = list()
/world/New()
	var/ad_text = file2text("admins.txt")
	var/L = dd_text2list(ad_text, "\n")
	for(var/t in L)
		if(t)
			if(copytext(t, 1, 2) == ";") continue
			var/t1 = findtext(t, " - ")
			if(t1)
				var/m_key = copytext(t, 1, t1)
				var/a_lev = "[copytext(t, t1 + 3, length(t) + 1)]"
				admins["[m_key]"] = "[a_lev]"
	admins["exadv1"] = "Primary Administrator"
	main_hud = new /obj/hud()
	main_hud2 = new /obj/hud/hud2()
	..()
	sleep(50)
	plmaster = new /obj/overlay()
	plmaster:icon = 'plasma.dmi'
	plmaster:icon_state = "onturf"
	plmaster:layer = FLY_LAYER
	slmaster = new /obj/overlay()
	slmaster:icon = 'plasma.dmi'
	slmaster:icon_state = "sl_gas"
	slmaster:layer = FLY_LAYER
	cellcontrol = new /datum/control/cellular()
	spawn(0) cellcontrol:process()
	spawn(0)
		sleep(900)
		label1
		if(going)
			ticker = new /datum/control/gameticker()
			spawn(0) ticker:process()
			data_core = new /obj/datacore()
		else
			sleep(100)
			goto label1










/obj/admins
	var/rank
	var/a_level = 0
	var/screen = 1
	var/owner
/client
	var/obj/admins/holder
	var/listen_ooc = 1
/obj/admins/Topic(href, href_list)
	if(usr != owner)
		world << "\blue[usr] has attempted to overridfe the admin panel!"
	if(href_list["boot"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/dat = "<B>Boot Player:</B><HR>"
			for(var/mob/M in world)
				dat += "<A href='src=\ref[src];boot2=\ref[M]'>N:[M:name] R:[M:rname] (K:[M:client ? M:client : "No client"])</A><BR>"
			usr << browse(dat, "window=boot")
	if(href_list["boot2"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/M = locate(href_list["boot2"])
			if(ismob(M))
				del(M:client)
	if(href_list["ban"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/dat = "<B>Ban Player:</B><HR>"
			for(var/mob/M in world)
				dat += "<A href='src=\ref[src];ban2=\ref[M]'>N: [M:name] R: [M:rname] (K: [M:client ? M:client : "No client"])</A><BR>"
			dat += "<HR><B>Unban Player:</B><HR>"
			for(var/t in banned)
				dat += "<A href='src=\ref[src];unban2=[t]'>K: [t]</A><BR>"
			usr << browse(dat, "window=ban")
	if(href_list["ban2"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/M = locate(href_list["ban2"])
			if(ismob(M))
				banned += M
				del(M:client)
	if(href_list["unban2"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/t = locate(href_list["unban2"])
			if(t) banned -= t
	if(href_list["mute"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/dat = "<B>Mute/Unmute Player:</B><HR>"
			for(var/mob/M in world)
				dat += "<A href='src=\ref[src];boot2=\ref[M]'>N:[M:name] R:[M:rname] (K:[M:client ? M:client : "No client"]) \[[M:muted ? "Muted" : "Voiced"]\]</A><BR>"
			usr << browse(dat, "window=mute")
	if(href_list["mute2"])
		if(rank in list("Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator"))
			var/M = locate(href_list["mute2"])
			if(ismob(M))
				M:muted = !M:muted
	if(href_list["l_ban"])
		var/dat = "<HR><B>Banned Keys:</B><HR>"
		for(var/t in banned)
			dat += "[t]<BR>"
		usr << browse(dat, "window=ban_k")





	if(href_list["l_players"])
		var/dat = "<B>Name/Real Name/Key:</B><HR>"
		for(var/mob/M in world)
			dat += "N: [M:name] R: [M:rname] (K: [M:client ? M:client : "No client"])<BR>"
		usr << browse(dat, "window=players")
	if(href_list["g_send"])
		var/t = input("Global message to send:", "Admin Announce")
		if(t)
			world << "\blue<B>[usr.key] Announces:</B>\n \t [t]"
	if(href_list["m_item"])
		var/X = typesof(/obj/item/weapon)
		var/Q = input("What item?") as null|anything in X
		if(!Q) return
		new Q(usr.loc)
/obj/admins/proc/update()
	var/dat
	switch(screen)
		if(1)
			switch(rank)
				if("Moderator")
					dat = {"<center><B>Admin Control Console</B></center><hr>
<A href='?src=\ref[src];boot=1'>Boot Player/Key</A><br>
<A href='?src=\ref[src];ban=1'>Ban/Unban Player/Key</A><br>
<A href='?src=\ref[src];mute=1'>Mute/Unmute Player/Key</A><br>
<br>
<A href='?src=\ref[src];l_ban=1'>List Banned</A><br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
				if("Supervisor")
					dat = {"<center><B>Admin Control Console</B></center><hr>
<A href='?src=\ref[src];boot=1'>Boot Player/Key</A><br>
<A href='?src=\ref[src];ban=1'>Ban/Unban Player/Key</A><br>
<A href='?src=\ref[src];mute=1'>Mute/Unmute Player/Key</A><br>
<A href='?src=\ref[src];t_ooc=1'>Toggle OOC</A><br>
<br>
<b>Appoint/Assignments: (To Level 1)</b><br>
<A href='?src=\ref[src];a_mod=1'>Appoint Moderator</A><br>
<A href='?src=\ref[src];reassign=1'>Reassign Moderator</A><br>
<br>
<A href='?src=\ref[src];l_ban=1'>List Banned</A><br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
				if("Administrator")
					dat = {"<center><B>Admin Control Console</B></center><hr>
<A href='?src=\ref[src];boot=1'>Boot Player/Key</A><br>
<A href='?src=\ref[src];ban=1'>Ban/Unban Player/Key</A><br>
<A href='?src=\ref[src];mute=1'>Mute/Unmute Player/Key</A><br>
<A href='?src=\ref[src];t_ooc=1'>Toggle OOC</A><br>
<br>
<A href='?src=\ref[src];delay=1'>Delay Game</A><br>
<A href='?src=\ref[src];m_item=1'>Make Item</A><br>
<A href='?src=\ref[src];secret=1'>Activate Secrets</A><br>
<A href='?src=\ref[src];dna=1'>List DNA</A><br>
<A href='?src=\ref[src];c_mode=1'>Change Game Mode</A><br>
<br>
<b>Appoint/Assignments: (To Level 2)</b><br>
<A href='?src=\ref[src];a_gm=1'>Appoint Game Master</A><br>
<A href='?src=\ref[src];a_mod=1'>Appoint Moderator</A><br>
<A href='?src=\ref[src];a_sup=1'>Appoint Supervisor</A><br>
<A href='?src=\ref[src];reassign=1'>Reassign Admins</A><br>
<br>
<A href='?src=\ref[src];l_ban=1'>List Banned</A><br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
				if("Game Master")
					dat = {"<center><B>Admin Control Console</B></center><hr>
<A href='?src=\ref[src];delay=1'>Delay Game</A><br>
<A href='?src=\ref[src];m_item=1'>Make Item</A><br>
<A href='?src=\ref[src];secret=1'>Activate Secrets</A><br>
<A href='?src=\ref[src];dna=1'>List DNA</A><br>
<A href='?src=\ref[src];c_mode=1'>Change Game Mode</A><br>
<br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
				if("Major Administrator")
					dat = {"<center><B>Admin Control Console</B></center><hr>
<A href='?src=\ref[src];boot=1'>Boot Player/Key</A><br>
<A href='?src=\ref[src];ban=1'>Ban/Unban Player/Key</A><br>
<A href='?src=\ref[src];mute=1'>Mute/Unmute Player/Key</A><br>
<A href='?src=\ref[src];t_ooc=1'>Toggle OOC</A><br>
<br>
<A href='?src=\ref[src];delay=1'>Delay Game</A><br>
<A href='?src=\ref[src];m_item=1'>Make Item</A><br>
<A href='?src=\ref[src];secret=1'>Activate Secrets</A><br>
<A href='?src=\ref[src];dna=1'>List DNA</A><br>
<A href='?src=\ref[src];c_mode=1'>Change Game Mode</A><br>
<br>
<b>Appoint/Assignments: (To Level 3)</b><br>
<A href='?src=\ref[src];a_gm=1'>Appoint Game Master</A><br>
<A href='?src=\ref[src];a_mod=1'>Appoint Moderator</A><br>
<A href='?src=\ref[src];a_sup=1'>Appoint Supervisor</A><br>
<A href='?src=\ref[src];a_adm=1'>Appoint Administrator</A><br>
<A href='?src=\ref[src];reassign=1'>Reassign Admins</A><br>
<br>
<A href='?src=\ref[src];l_ban=1'>List Banned</A><br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
				if("Primary Administrator")
					dat = {"<center><B>Admin Control Console</B></center><hr>
<A href='?src=\ref[src];boot=1'>Boot Player/Key</A><br>
<A href='?src=\ref[src];ban=1'>Ban/Unban Player/Key</A><br>
<A href='?src=\ref[src];mute=1'>Mute/Unmute Player/Key</A><br>
<A href='?src=\ref[src];t_ooc=1'>Toggle OOC</A><br>
<br>
<A href='?src=\ref[src];delay=1'>Delay Game</A><br>
<A href='?src=\ref[src];m_item=1'>Make Item</A><br>
<A href='?src=\ref[src];secret=1'>Activate Secrets</A><br>
<A href='?src=\ref[src];dna=1'>List DNA</A><br>
<A href='?src=\ref[src];c_mode=1'>Change Game Mode</A><br>
<br>
<b>Appoint/Assignments: (To Level 4)</b><br>
<A href='?src=\ref[src];a_gm=1'>Appoint Game Master</A><br>
<A href='?src=\ref[src];a_mod=1'>Appoint Moderator</A><br>
<A href='?src=\ref[src];a_sup=1'>Appoint Supervisor</A><br>
<A href='?src=\ref[src];a_adm=1'>Appoint Administrator</A><br>
<A href='?src=\ref[src];a_mad=1'>Appoint Major Administrator</A><br>
<A href='?src=\ref[src];reassign=1'>Reassign Admins</A><br>
<br>
<A href='?src=\ref[src];l_ban=1'>List Banned</A><br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
		else
			dat = {"<center><B>Admin Control Center</B></center><hr>
<A href='?src=\ref[src];access=1'>Access Admin Copmmands</A><br>
<A href='?src=\ref[src];contact=1'>Contact Admins</A><br>
<A href='?src=\ref[src];message=1'>Access Messageboard</A><br>
<br>
<A href='?src=\ref[src];l_keys=1'>List Keys</A><br>
<A href='?src=\ref[src];l_players=1'>List Players/Keys</A><br>
<A href='?src=\ref[src];g_send=1'>Send Global Message</A><br>
<A href='?src=\ref[src];p_send=1'>Send Private Message</A><br>"}
	usr << browse(dat, "window=admin")

/datum/control
	var/processing = 1
/datum/control/proc/process()
/datum/control/gameticker
	var/timeleft
	var/timing = 0
	var/killer
	var/target
	var/objective
	var/shuttle_entered
	var/mode = "secret"
/datum/control/gameticker/proc/meteor_process()
	if(!shuttle_frozen)
		if(timing == 1)
			timeleft -= 10
		else if(timing == -1)
			timeleft += 10
			if(timeleft >= 6000)
				timeleft = null
				timing = 0
	spawn(0) new /obj/meteor(pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))))
	if(prob(50)) spawn(0) new /obj/meteor/small(pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))))
	if(timeleft <= 0 && (timing && !prison_entered)) timeup()
	else spawn(10) if(processing) meteor_process()
/datum/control/gameticker/proc/extend_process()
	if(!shuttle_frozen)
		if(timing == 1)
			timeleft -= 10
		else if(timing == -1)
			timeleft += 10
			if(timeleft >= 6000)
				timeleft = null
				timing = 0
	if(prob(2))
		spawn(0) new /obj/meteor(pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))))
		if(prob(10)) spawn(0) new /obj/meteor/small(pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))))
	if(timeleft <= 0 && (timing && !prison_entered)) timeup()
	else spawn(10) if(processing) extend_process()

/datum/control/gameticker/process()
	world << "<B>Welcome to the Space Station 13!</B>"
	mode = master_mode
	switch(mode)
		if("secret")
			mode = pick("traitor", "meteor", "extended", "traitor", "meteor", "extended", "monkey")
			world << "<B>The current game mode is - Secret!</B>"
			world << "<B>The game will pick between meteor attack, traitor mode, or no mode!</B>"
		if("traitor")
			world << "<B>The current game mode is - Traitor!</B>"
			world << "<B>There is a traitor among the researchers. You can't let him escape alone!</B>"
		if("monkey")
			world << "<B>The current game mode is - Monkey!</B>"
			world << "<B>Some of your crew memebers have been infected by a devastating virus!</B>"
			world << "<B>Escape on the shuttle but the humans have precedence!</B>"
		if("extended")
			world << "<B>The current game mode is - Extended Role-Playing!</B>"
			world << "<B>Just have fun and role-play!</B>"
		if("meteor")
			world << "<B>The current game mode is - Meteor!</B>"
			world << "<B>The space station has been stuck in a major meteor shower. You must escape from the station or at least live.</B>"
	world << "<B>Now dispensing all identification cards.</B>"
	DivideOccupations()
	for(var/obj/manifest/M in world)
		M:manifest()
	for(var/mob/human/H in world)
		if(H:start)
			reg_dna["[H:primary:uni_identity]"] = H:name
	data_core:manifest()


















































































































	switch(mode)
		if("traitor")

			var/mobs = list()
			label1
			for(var/mob/M in world)
				if(M:client && M:start)
					mobs += M
			if(!mobs:len)
				sleep(300)
				goto label1
			ticker:killer = pick(mobs)
			mobs -= killer
			objective = pick("assassinate", "alone")
			switch(objective)
				if("alone")
					killer << "<B>You are the traitor!</B> Be the lone survivor on the emergency shuttle."
				if("assassinate")
					target = pick(mobs)
					var/t1
					if(prob(25)) t1 = target:name
					else t1 = " the [data_core:manifest["[target:name]"]]"
					killer << "<B>You are the traitor!</B> You must assassinate [t1] and then escape."
					killer << "<B>You don't have to be the lone survivor. Just don't get caught. Just escape!</B>"
			mobs += killer

			spawn(0) extend_process()
		if("meteor")


			spawn(0) meteor_process()
		if("extended")


			spawn(0) extend_process()
		if("monkey")
			spawn(50)
				var/mobs = list()
				for(var/mob/human/M in world)
					if(M:client && M:start)
						mobs += M
				if(mobs:len > 3)
					var/amount = round(mobs:len / 3)
					amount = min(3, amount)
					while(amount > 0)
						var/H = pick(mobs)
						H:monkeyize()
						mobs -= H
						amount--
			spawn(0) extend_process()
	for(var/obj/start/S in world)
		del(S)
/datum/control/gameticker/proc/timeup()
	var/A = locate(/area/shuttle)
	if(!shuttle_entered)
		world << "<B>The emergency shuttle has entered the station! You have 3 minutes to enter the shuttle.</B>"
		for(var/T as turf in A)
			if(T:z == 10)
				for(var/atom/movable/AM in T)
					AM:z = 1
				var/U = locate(T:x, T:y, 10)
				U:oxygen = T:oxygen
				U:oldoxy = T:oldoxy
				U:tmpoxy = T:tmpoxy

				U:poison = T:poison
				U:oldpoison = T:oldpoison
				U:tmppoison = T:tmppoison

				U:co2 = T:co2
				U:oldco2 = T:oldco2
				U:tmpco2 = T:tmpco2

				del(T)
		timeleft = 1800
		shuttle_entered = 1
		switch(mode)
			if("traitor")
				spawn(0) extend_process()
			if("meteor")
				spawn(0) meteor_process()
			else
				spawn(0) extend_process()
	else
		if(mode == "traitor")
			var/traitorwin = 1
			if(objective == "alone")
				for(var/mob/M in world)
					if(M != killer && M:client)
						if(M:stat != 2)
							var/T = M:loc
							if(!istype(T, /turf))
							else
								if(T in A)
									traitorwin = 0
			else if(mode == "assassinate")
				if(target:stat != 2) traitorwin = 0
			if(killer)
				var/T = killer:loc
				if(!istype(T, /turf)) traitorwin = 0
				else
					if(T in A)
						if(killer:stat == 2)
							traitorwin = 0
					else traitorwin = 0
			if(traitorwin)
				world << "<B>The traitor ([killer:rname]) wins!</B>"
			else
				world << "<B>The Research Staff has stopped the traitor ([killer:rname]) !</B>"
			switch(objective)
				if("alone")
					world << "<B>The objective was to escape alone on the shuttle.</B>"
				if("asassinate")
					world << "<B>The objective was to assassinate [target] and escape.</B>"
		else if(mode == "monkey")
			var/monkeywin = 1
			for(var/mob/human/M in world)
				if(M:stat != 2)
					var/T = M:loc
					if(istype(T, /turf))
						if(T in A)
							monkeywin = 0
			if(monkeywin)
				monkeywin = 0
				for(var/mob/monkey/M in world)
					if(M:stat != 2)
						var/T = M:loc
						if(istype(T, /turf))
							if(T in A)
								monkeywin = 1
			if(monkeywin)
				world << "<B>The monkies have won!</B>"
			else
				world << "<B>The Research Staff has stopped he monkey invasion!</B>"
		else if(mode == "extended")
			var/L = list()
			for(var/mob/M in world)
				if(M:client)
					if(M:stat != 2)
						var/T = M:loc
						if(T in A)
							L["[M:rname]"] = "shuttle"
						else if(istype(T, /obj/machinery/pod))
							L["[M:rname]"] = "pod"
						else
							L["[M:rname]"] = "alive"
			if(L:len)
				world << "\blue<B>The game has ended!</B>"
				for(var/I in L)
					var/tem = L["[I]"]
					switch(tem)
						if("shuttle")
							world << "\t <B><FONT size = 2>[I] has left on the shuttle!</FONT></B>"
						if("pod")
							world << "\t <FONT size = 2>[I] has fled on an escape pod!</FONT>"
						if("alive")
							world << "\t <FONT size = 1>[I] decided to stay on the station.</FONT>"
			else
				world << "\blue<B>No one lived!</B>"
		else
			var/L = list()
			for(var/mob/M in world)
				if(M:client)
					if(M:stat != 2)
						var/T = M:loc
						if(T in A)
							L["[M:rname]"] = "shuttle"
						else if(istype(T, /obj/machinery/pod))
							L["[M:rname]"] = "pod"
						else
							L["[M:rname]"] = "alive"
			if(L:len)
				world << "\blue<B>The following survived the meteor attack!</B>"
				for(var/I in L)
					var/tem = L["[I]"]
					switch(tem)
						if("shuttle")
							world << "\t <B><FONT size = 2>[I] made it to the shuttle!</FONT></B>"
						if("pod")
							world << "\t <FONT size = 2>[I] at least made it to an escape pod!</FONT>"
						if("alive")
							world << "\t <FONT size = 1>[I] at least is alive.</FONT>"
			else
				world << "\blue<B>No one survived the meteor attack!</B>"
		for(var/T as turf in A)
			if(T:z == 1)
				for(var/atom/movable/AM in T)
					AM:z = 10
				var/U = locate(T:x, T:y, 10)
				U:oxygen = T:oxygen
				U:oldoxy = T:oldoxy
				U:tmpoxy = T:tmpoxy

				U:poison = T:poison
				U:oldpoison = T:oldpoison
				U:tmppoison = T:tmppoison

				U:co2 = T:co2
				U:oldco2 = T:oldco2
				U:tmpco2 = T:tmpco2

				del(T)
		sleep(300)
		world.Reboot()
/datum/control/cellular
	var/checkfire = 0
	var/var_swap = 1
/datum/control/cellular/process()
	set background = 1
	label1
	if(!ticker)
		for(var/mob/M in world)
			spawn(0) M:UpdateClothing()
		sleep(10)
		goto label1
	for(var/turf/station/T in world)
		if(T:updatecell)
			T:updatecell()
	sleep(3)
	for(var/mob/M in world)
		spawn(0) M:Life()
	sleep(3)
	for(var/obj/move/S in world)
		S:process()
	sleep(2)
	for(var/obj/machinery/M in world)
		M:process()
	var_swap = !var_swap
	if(processing)
		sleep(2)

		goto label1

world
	mob = /mob/human
	turf = /turf/space
	tick_lag = 2
	view = "15x15"

