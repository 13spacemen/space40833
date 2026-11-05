


/datum/data
	var/size = 1
	var/name
/datum/data/record
	var/fields = list()
	size = 5
/datum/data/text{var/data; size = 1}
/datum/data/function
	size = 2
/datum/data/function/id_changer
/datum/data/function/data_control
/datum/data/function/proc/reset()
/datum/data/function/proc/r_input(href, href_list, mob/user)
/datum/data/function/proc/display()
/obj/machinery/computer/med_data
	var/scan
	var/authenticated
	var/screen
	icon_state = "computer"
	var/active
	var/a_id
	var/temp
	icon = 'weap_sat.dmi'
	density = 1
	anchored = 1








































































































/obj/machinery/computer/med_data/attack_hand(mob/user)
	var/dat
	if(temp)
		dat = "<TT>[temp]</TT><BR><BR><A href='?src=\ref[src];temp=1'>Clear Screen</A>"
	else
		dat = "Confirm Identity: <A href='?src=\ref[src];scan=1'>[scan ? "[scan:name]" : "----------"]</A><HR>"
		if(authenticated)
			switch(screen)
				if(1)
					dat += {"<A href='?src=\ref[src];search=1'>Search Records</A><BR>
<A href='?src=\ref[src];list=1'>List Records</A><BR>
<A href='?src=\ref[src];new=1'>New Record</A><BR>
<BR>
<A href='?src=\ref[src];rec_m=1'>Record Maintenance</A><BR>
<A href='?src=\ref[src];logout=1'>{Log Out}</A><BR>
"}
				if(2)
					dat += "<B>Record List</B>:<HR>"
					for(var/datum/data/record/R in data_core:medical)
						dat += "<A href='?src=\ref[src];d_rec=\ref[R]'>[R:fields["id"]]: [R:fields["name"]]<BR>"
					dat += "<HR><A href='?src=\ref[src];main=1'>Back</A>"
				if(3)
					dat += {"<B>Records Maintenance</B><HR>
<A href='?src=\ref[src];back=1'>Backup To Disk</A>
<A href='?src=\ref[src];u_load=1'>Upload From disk</A>
<A href='?src=\ref[src];del_all=1'>Delete All Records</A>

<A href='?src=\ref[src];main=1'>Back</A>"}
				if(4)
					if(istype(active, /datum/data/record) && data_core:medical:Find(active))
						dat += {"<CENTER><B>Medical Record</B></CENTER><BR>
Name: <A href='?src=\ref[src];field=name'>[active:fields["name"]]</A> ID: <A href='?src=\ref[src];field=id'>[active:fields["id"]]</A><BR>
Sex: <A href='?src=\ref[src];field=sex'>[active:fields["sex"]]</A><BR>
Age: <A href='?src=\ref[src];field=age'>[active:fields["age"]]</A><BR>
Physical Status: <A href='?src=\ref[src];field=p_stat'>[active:fields["p_stat"]]</A><BR>
Mental Status: <A href='?src=\ref[src];field=m_stat'>[active:fields["m_stat"]]</A><BR>
<BR>
<CENTER><B>Medical Data</B></CENTER><BR>
Blood Type: <A href='?src=\ref[src];field=b_type'>[active:fields["b_type"]]</A><BR>
<BR>
Minor Disabilities: <A href='?src=\ref[src];field=mi_dis'>[active:fields["mi_dis"]]</A><BR>
Details: <A href='?src=\ref[src];field=mi_dis_d'>[active:fields["mi_dis_d"]]</A><BR>
<BR>
Major Disabilities: <A href='?src=\ref[src];field=ma_dis'>[active:fields["ma_dis"]]</A><BR>
Details: <A href='?src=\ref[src];field=ma_dis_d'>[active:fields["ma_dis_d"]]</A><BR>
<BR>
Allergies: <A href='?src=\ref[src];field=alg'>[active:fields["alg"]]</A><BR>
Details: <A href='?src=\ref[src];field=alg_d'>[active:fields["alg_d"]]</A><BR>
<BR>
Current Diseases: <A href='?src=\ref[src];field=cdi'>[active:fields["cdi"]]</A> (per disease info placed in log/comment section)<BR>
Details: <A href='?src=\ref[src];field=cdi_d'>[active:fields["cdi_d"]]</A><BR>
<BR>
Important Notes:<BR>
\t<A href='?src=\ref[src];field=notes'>[active:fields["notes"]]</A><BR>
<BR>
<CENTER><B>Comments/Log</B></CENTER><BR>"}
						var/counter = 1
						while(active:fields["com_[counter]"])
							dat += "[active:fields["com_[counter]"]]<BR><A href='?src=\ref[src];del_c=[counter]'>Delete Entry</A><BR><BR>"
							counter++
						dat += {"<A href='?src=\ref[src];add_c=1'>Add Entry</A><BR>
<BR>
<A href='?src=\ref[src];del_r=1'>Delete Record</A><BR>
<A href='?src=\ref[src];print_p=1'>Print Record</A><BR>
<A href='?src=\ref[src];list=1'>Back</A><BR>"}
					else








						active = null
						temp = "Error: Record Lost!"
						screen = 2
		else
			dat += "<A href='?src=\ref[src];login=1'>{Log In}</A>"
	user << browse("<HEAD><TITLE>Medical Records</TITLE></HEAD><TT>[dat]</TT>", "window=med_rec")
/obj/machinery/computer/med_data/Topic(href, href_list)
	if(!data_core:medical:Find(active)) active = null
	if(usr.stat || usr.restrained()) return
	if(usr.contents:Find(src) || get_dist(src, usr) <= 1 && istype(loc, /turf))
		usr.machine = src
		if(href_list["temp"])
			temp = null
		if(href_list["scan"])
			if(scan)
				scan:loc = loc
				scan = null
			else
				var/I = usr.equipped()
				if(istype(I, /obj/item/weapon/card/id))
					usr.drop_item()
					I:loc = src
					scan = I
		else if(href_list["logout"])
			authenticated = null
			screen = null
			active = null
		else if(href_list["login"])
			if(istype(scan, /obj/item/weapon/card/id))
				active = null
				var/L = list("Medical Researcher", "Medical Doctor", "Head of Personell", "Captain")
				if(L:Find(scan:assignment))
					authenticated = scan:registered
					screen = 1
		if(authenticated)
			if(href_list["list"])
				screen = 2
				active = null
			else if(href_list["rec_m"])
				screen = 3
				active = null
			else if(href_list["del_all"])
				temp = {"Are you sure you wish to delete all records?<br>
\t<A href='?src=\ref[src];temp=1;del_all2=1'>Yes</A><br>
\t<A href='?src=\ref[src];temp=1'>No</A><br>"}
			else if(href_list["del_all2"])
				for(var/datum/data/record/R in data_core:medical)
					del(R)
				temp = "All records deleted."
			else if(href_list["main"])
				screen = 1
				active = null
			else if(href_list["field"] && istype(active, /datum/data/record))
				var/datum/data/record/a = active
				switch(href_list["field"])
					if("name")
						var/t1 = input("Please input name:", "Med. records", active:fields["name"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["name"] = t1
					if("id")
						var/t1 = input("Please input id code:", "Med. records", active:fields["id"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["id"] = t1
					if("sex")
						if(active:fields["sex"] == "Male")
							active:fields["sex"] = "Female"
						else
							active:fields["sex"] = "Male"
					if("age")
						var/t1 = input("Please input age:", "Med. records", active:fields["age"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["age"] = t1
					if("mi_dis")
						var/t1 = input("Please input minor disabilities list:", "Med. records", active:fields["mi_dis"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["mi_dis"] = t1
					if("mi_dis_d")
						var/t1 = input("Please summarize minor dis.:", "Med. records", active:fields["mi_dis_d"]) as message
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["mi_dis_d"] = t1
					if("ma_dis")
						var/t1 = input("Please input major diabilities list:", "Med. records", active:fields["ma_dis"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["ma_dis"] = t1
					if("ma_dis_d")
						var/t1 = input("Please summarize major dis.:", "Med. records", active:fields["ma_dis_d"]) as message
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["ma_dis_d"] = t1
					if("alg")
						var/t1 = input("Please state allergies:", "Med. records", active:fields["alg"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["alg"] = t1
					if("alg_d")
						var/t1 = input("Please summarize allergies:", "Med. records", active:fields["alg_d"]) as message
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["alg_d"] = t1
					if("cdi")
						var/t1 = input("Please state diseases:", "Med. records", active:fields["cdi"]) as text
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["cdi"] = t1
					if("cdi_d")
						var/t1 = input("Please summarize diseases:", "Med. records", active:fields["cdi_d"]) as message
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["cdi_d"] = t1
					if("notes")
						var/t1 = input("Please summarize notes:", "Med. records", active:fields["notes"]) as message
						if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
						active:fields["notes"] = t1
					if("p_stat")
						temp = {"<B>Physical Condition:</B><BR>
\t<A href='?src=\ref[src];temp=1;p_stat=deceased'>*Deceased*</A><BR>
\t<A href='?src=\ref[src];temp=1;p_stat=unconscious'>*Unconscious*</A><BR>
\t<A href='?src=\ref[src];temp=1;p_stat=active'>Active</A><BR>
\t<A href='?src=\ref[src];temp=1;p_stat=unfit'>Physically Unfit</A><BR>"}
					if("m_stat")
						temp = {"<B>Mental Condition:</B><BR>
\t<A href='?src=\ref[src];temp=1;m_stat=insane'>*Insane*</A><BR>
\t<A href='?src=\ref[src];temp=1;m_stat=unstable'>*Unstable*</A><BR>
\t<A href='?src=\ref[src];temp=1;m_stat=watch'>*Watch*</A><BR>
\t<A href='?src=\ref[src];temp=1;m_stat=stable'>Stable</A><BR>"}
					if("b_type")
						temp = {"<B>Blood Type:</B><BR>
\t<A href='?src=\ref[src];temp=1;b_type=an'>A-</A> <A href='?src=\ref[src];temp=1;b_type=ap'>A+</A><BR>
\t<A href='?src=\ref[src];temp=1;b_type=bn'>B-</A> <A href='?src=\ref[src];temp=1;b_type=bp'>B+</A><BR>
\t<A href='?src=\ref[src];temp=1;b_type=abn'>AB-</A> <A href='?src=\ref[src];temp=1;b_type=abp'>AB+</A><BR>
\t<A href='?src=\ref[src];temp=1;b_type=on'>O-</A> <A href='?src=\ref[src];temp=1;b_type=op'>O+</A><BR>"}
			else if(href_list["p_stat"])
				if(active)
					switch(href_list["p_stat"])
						if("deceased") active:fields["p_stat"] = "*Deceased*"
						if("unconscious") active:fields["p_stat"] = "*Unconscious*"
						if("active") active:fields["p_stat"] = "Active"
						if("unfit") active:fields["p_stat"] = "Physically Unfit"
			else if(href_list["m_stat"])
				if(active)
					switch(href_list["m_stat"])
						if("insane") active:fields["m_stat"] = "*Insane*"
						if("unstable") active:fields["m_stat"] = "*Unstable*"
						if("watch") active:fields["m_stat"] = "*Watch*"
						if("stable") active:fields["m_stat"] = "Stable"
			else if(href_list["b_type"])
				if(active)
					switch(href_list["b_type"])
						if("an") active:fields["b_type"] = "A-"
						if("bn") active:fields["b_type"] = "B-"
						if("abn") active:fields["b_type"] = "AB-"
						if("on") active:fields["b_type"] = "O-"
						if("ap") active:fields["b_type"] = "A+"
						if("bp") active:fields["b_type"] = "B+"
						if("abp") active:fields["b_type"] = "AB+"
						if("op") active:fields["b_type"] = "O+"
			else if(href_list["del_r"])
				if(active)
					temp = {"Are you sure you wish to delete the record?<br>
\t<A href='?src=\ref[src];temp=1;del_r2=1'>Yes</A><br>
\t<A href='?src=\ref[src];temp=1'>No</A><br>"}
			else if(href_list["del_r2"])
				if(active)
					del(active)
			else if(href_list["d_rec"])
				var/R = locate(href_list["d_rec"])
				if(!data_core:medical:Find(R))
					temp = "Record Not Found!"
					return
				active = R
				screen = 4
			else if(href_list["new"])
				var/R = new /datum/data/record()
				R:fields["name"] = "New Record"
				R:fields["id"] = "[add_zero(num2hex(rand(1, 16777215)), 6)]"
				R:name = "Medical Record #[R:fields["id"]]"
				R:fields["sex"] = "Unknown"
				R:fields["age"] = "Unknown"
				R:fields["p_stat"] = "Active"
				R:fields["m_stat"] = "Stable"
				R:fields["b_type"] = "Unknown"
				R:fields["mi_dis"] = "None"
				R:fields["mi_dis_d"] = "No minor disabilities have been declared."
				R:fields["ma_dis"] = "None"
				R:fields["ma_dis_d"] = "No major disabilities have been diagnosed."
				R:fields["alg"] = "None"
				R:fields["alg_d"] = "No allergies have been detected in this patient."
				R:fields["cdi"] = "None"
				R:fields["cdi_d"] = "No diseases have been diagnosed at the moment."
				R:fields["notes"] = "No notes."
				data_core:medical += R
				active = R
				screen = 4
			else if(href_list["add_c"])
				if(!istype(active, /datum/data/record)) return
				var/datum/data/record/a = active
				var/t1 = input("Add Comment:", "Med. records") as message
				if(!t1 || (!authenticated || (usr.stat || (usr.restrained() || (get_dist(src, usr) > 1 || active != a))))) return
				var/counter = 1
				while(active:fields["com_[counter]"])
					counter++
				active:fields["com_[counter]"] = "Made by [authenticated] on [time2text(world.realtime, "DDD MMM DD hh:mm:ss")], 2053<BR>[t1]"
			else if(href_list["del_c"])
				if(istype(active, /datum/data/record) && active:fields["com_[href_list["del_c"]]"])
					active:fields["com_[href_list["del_c"]]"] = "<B>Deleted</B>"
			else if(href_list["search"])
				var/t1 = input("Search String: (Name or ID)", "Med. records") as text
				if(!t1 || (usr.stat || (!authenticated || (usr.restrained() || get_dist(src, usr) > 1)))) return
				active = null
				t1 = lowertext(t1)
				for(var/datum/data/record/R in data_core:medical)
					if(lowertext(R:fields["name"]) == t1 || t1 == lowertext(R:fields["id"]))
						active = R
						break
				if(!active)
					temp = "Could not locate record [t1]."
				else
					screen = 4
			else if(href_list["print_p"])
				if(!printing && (istype(active, /datum/data/record) && data_core:medical:Find(active)))
					printing = 1
					sleep(50)
					var/P = new /obj/item/weapon/paper(loc)
					lbl1
























					P:info = "<TT><CENTER><B>Medical Record</B></CENTER><BR>\nName: [active:fields["name"]] ID: [active:fields["id"]]<BR>\nSex: [active:fields["sex"]]<BR>\nAge: [active:fields["age"]]<BR>\nPhysical Status: [active:fields["p_stat"]]<BR>\nMental Status: [active:fields["m_stat"]]<BR>\n<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: [active:fields["b_type"]]<BR>\n<BR>\nMinor Disabilities: [active:fields["mi_dis"]]<BR>\nDetails: [active:fields["mi_dis_d"]]<BR>\n<BR>\nMajor Disabilities: [active:fields["ma_dis"]]<BR>\nDetails: [active:fields["ma_dis_d"]]<BR>\n<BR>\nAllergies: [active:fields["alg"]]<BR>\nDetails: [active:fields["alg_d"]]<BR>\n\nCurrent Diseases: [active:fields["cdi"]] (per disease info placed in log/comment section)<BR>\nDetails: [active:fields["cdi_d"]]<BR>\n<BR>\nImportant Notes:<BR>\n\t[active:fields["notes"]]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>"
					var/counter = 1
					while(active:fields["com_[counter]"])
						P:info += "[active:fields["com_[counter]"]]<BR><BR>"
						counter++
					P:info += "</TT>"
					P:name = "paper- 'Medical Record'"
					printing = null
	for(var/mob/M in view(1, src))
		if(M:client && M:machine == src) attack_hand(M)
/obj/machinery/computer/med_data{var/printing = null}
/obj/machinery/computer/sleep_console
	var/obj/machinery/sleeper/connected
	icon = 'Cryogenic2.dmi'
	icon_state = "sleeperconsole"
	density = 1
	anchored = 1
/obj/machinery/computer/sleep_console/ex_act(severity)
	switch(severity)
		if(1)
			del(src)
		if(2)
			if(prob(50)) del(src)
/obj/overlay
/obj/machinery/computer/sleep_console/New()
	..()
	spawn(5)
		connected = locate(/obj/machinery/sleeper) in get_step(src, WEST)
/obj/machinery/computer/sleep_console/attack_hand(mob/user)
	if(connected)
		var/occupant = connected:occupant
		var/dat = "<font color='blue'><B>Occupant Statistics:</B></FONT><BR>"
		if(occupant)
			var/t1
			switch(occupant:stat)
				if(0)
					t1 = "Conscious"
				if(1)
					t1 = "Unconscious"
				if(2)
					t1 = "*dead*"
			dat += "[occupant:health > 50 ? "<font color='blue'>" : "<font color='red'>"]\tHealth %: [occupant:health] ([t1])</FONT><BR>"
			dat += "[occupant:oxyloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t-Respiratory Damage %: [occupant:oxyloss]</FONT><BR>"
			dat += "[occupant:toxloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t-Toxin Content %: [occupant:toxloss]</FONT><BR>"
			dat += "[occupant:fireloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t-Burn Severity %: [occupant:fireloss]</FONT><BR>"
			dat += "<BR>Paralysis Summary %: [occupant:paralysis] ([round(occupant:paralysis / 4)] seconds left!)</FONT><BR>"
			dat += "<HR><A href='?src=\ref[src];refresh=1'>Refresh</A><BR><A href='?src=\ref[src];rejuv=1'>Inject Rejuvenators</A>"
		else
			dat += "The sleeper is empty."
		dat += "<BR><BR><A href='?src=\ref[user];mach_close=sleeper'>Close</A>"
		user << browse(dat, "window=sleeper;size=400x500")
/obj/machinery/computer/sleep_console/Topic(href, href_list)
	if(usr.stat || usr.restrained()) return
	if(usr.contents:Find(src) || get_dist(src, usr) <= 1 && istype(loc, /turf))
		usr.machine = src
		if(href_list["rejuv"])
			if(connected)
				connected:inject(usr)
		if(href_list["refresh"])
			for(var/mob/M in view(1, src))
				if(M:client && M:machine == src) attack_hand(M)
/obj/machinery/computer/sleep_console/process()
	for(var/mob/M in view(1, src))
		if(M:client && M:machine == src) attack_hand(M)
/obj/item/weapon/flasks
	var/oxygen = 0
	var/plasma = 0
	name = "flask"
	var/coolant = 0
	icon = 'Cryogenic2.dmi'
/obj/item/weapon/flasks/examine()
	usr << "The flask is [(oxygen + plasma + coolant) * 100 / 500]% full"
	usr << "The flask can ONLY store liquids."

























































































/obj/machinery/freezer
	var/connector
	icon_state = "freezer_0"
	var/line_out
	var/c_used = 1
	var/status = 0
	var/t_flags = 3
	var/transfer = 0
	var/temperature = 60
	icon = 'Cryogenic2.dmi'
	density = 1
	p_dir = 4
	anchored = 1
/obj/item/weapon/flasks/oxygen
	icon_state = "oxygen-c"
	name = "blue flask"
	oxygen = 500
/obj/item/weapon/flasks/plasma
	icon_state = "plasma-c"
	name = "orange flask"
	plasma = 500
/obj/item/weapon/flasks/coolant
	icon_state = "coolant-c"
	name = "light blue flask"
	coolant = 1000
/obj/machinery/freezer/attack_paw(mob/user)
	return attack_hand(user)
/obj/machinery/freezer/attack_hand(mob/user)
	user:machine = src
	if(istype(user, /mob/human))
		var/d1
		if(locate(/obj/item/weapon/flasks) in src)
			var/counter = 1
			for(var/obj/item/weapon/flasks/F in src)
				d1 += "<A href = '?src=\ref[src];flask=[counter]'><B>Flask [counter]</B></A>: [F:oxygen] / [F:plasma] / [F:coolant]<BR>"
				counter++
			d1 += "Key:    Oxygen / Plasma / Coolant<BR>"
		else
			d1 = "<B>No flasks!</B>"
		var/t1
		switch(t_flags)
			if(0)
				t1 = "<A href = '?src=\ref[src];oxygen=1'>Oxygen-No</A> <A href = '?src=\ref[src];plasma=1'>Plasma-No</A>"
			if(1)
				t1 = "<A href = '?src=\ref[src];oxygen=0'>Oxygen-Yes</A> <A href = '?src=\ref[src];plasma=1'>Plasma-No</A>"
			if(2)
				t1 = "<A href = '?src=\ref[src];oxygen=1'>Oxygen-No</A> <A href = '?src=\ref[src];plasma=0'>Plasma-Yes</A>"
			if(3)
				t1 = "<A href = '?src=\ref[src];oxygen=0'>Oxygen-Yes</A> <A href = '?src=\ref[src];plasma=0'>Plasma-Yes</A>"
		var/t2
		if(status) t2 = "Cooling-[c_used] <A href = '?src=\ref[src];cool=0'>Stop</A>"
		else t2 = "<A href = '?src=\ref[src];cool=1'>Cool</A> Stopped"
		var/dat = {"<HTML><HEAD></HEAD><BODY><TT><BR>
\t\t<B>Temperature</B>: [temperature]<BR>
\t\t<B>Transfer Status</B>: [transfer ? "Transfering <A href='?src=\ref[src];transfer=0'>Stop</A>" : "<A href='?src=\ref[src];transfer=1'>Transfer</A> Stopped"]<BR>
\t\t   <B>Chemicals Used</B>: [t1]<BR>
\t\t<B>Freezer status</B>: [t2]<BR>
\t\t   <A href='?src=\ref[src];cp=-5'>-</A> <A href='?src=\ref[src];cp=-1'>-</A> [c_used] <A href='?src=\ref[src];cp=1'>+</A> <A href='?src=\ref[src];cp=5'>+</A><BR>
<BR>
\t[d1]<BR>
<BR>
<BR>
\t<A href='?src=\ref[user];mach_close=freezer'>Close</A><BR>
\t</TT></BODY></HTML>"}
		user << browse(dat, "window=freezer;size=400x500")
	else
		var/d1
		if(locate(/obj/item/weapon/flasks) in src)
			var/counter = 1
			for(var/obj/item/weapon/flasks/F in src)
				d1 += "<A href = '?src=\ref[src];flask=[counter]'><B>[stars("Flask")] [counter]</B></A>: [stars("[F:oxygen] / [F:plasma] / [F:coolant]")]<BR>"
				counter++
			d1 += "Key:    Oxygen / Plasma / Coolant<BR>"
		else
			d1 = "<B>No flasks!</B>"
		var/t1
		switch(t_flags)
			if(0)
				t1 = "<A href = '?src=\ref[src];oxygen=1'>[stars("Oxygen-No")]</A> <A href = '?src=\ref[src];plasma=1'>[stars("Plasma-No")]</A>"
			if(1)
				t1 = "<A href = '?src=\ref[src];oxygen=0'>[stars("Oxygen-Yes")]</A> <A href = '?src=\ref[src];plasma=1'>[stars("Plasma-No")]</A>"
			if(2)
				t1 = "<A href = '?src=\ref[src];oxygen=1'>[stars("Oxygen-No")]</A> <A href = '?src=\ref[src];plasma=0'>[stars("Plasma-Yes")]</A>"
			if(3)
				t1 = "<A href = '?src=\ref[src];oxygen=0'>[stars("Oxygen-Yes")]</A> <A href = '?src=\ref[src];plasma=0'>[stars("Plasma-Yes")]</A>"
		var/t2
		if(status) t2 = "Cooling-[c_used] <A href = '?src=\ref[src];cool=0'>[stars("Stop")]</A>"
		else t2 = "<A href = '?src=\ref[src];cool=1'>Cool</A> [stars("Stopped")]"
		var/dat = {"<HTML><HEAD></HEAD><BODY><TT><BR>
\t\t<B>[stars("Temperature")]</B>: [temperature]<BR>
\t\t<B>[stars("Transfer Status")]</B>: [transfer ? "Transfering <A href='?src=\ref[src];transfer=0'>Stop</A>" : "<A href='?src=\ref[src];transfer=1'>Transfer</A> Stopped"]<BR>
\t\t   <B>[stars("Chemicals Used")]</B>: [t1]<BR>
\t\t<B>[stars("Freezer status")]</B>: [t2]<BR>
\t\t   <A href='?src=\ref[src];cp=-5'>-</A> <A href='?src=\ref[src];cp=-1'>-</A> [c_used] <A href='?src=\ref[src];cp=1'>+</A> <A href='?src=\ref[src];cp=5'>+</A><BR>
<BR>
\t[d1]<BR>
<BR>
<BR>
\t<A href='?src=\ref[user];mach_close=freezer'>Close</A>
\t</TT></BODY></HTML>"}
		user << browse(dat, "window=freezer;size=400x500")
/obj/machinery/freezer/Topic(href, href_list)
	if(!istype(usr, /mob/human))
		usr << "\red You don't have the dexterity to do this!"
		return
	if(usr.stat || usr.restrained()) return
	if(usr.contents:Find(src) || get_dist(src, usr) <= 1 && istype(loc, /turf))
		usr.machine = src
		if(href_list["cp"])
			var/cp = text2num(href_list["cp"])
			c_used += cp
			c_used = min(max(round(c_used), 0), 10)
		if(href_list["oxygen"])
			var/t1 = text2num(href_list["oxygen"])
			if(t1) t_flags |= 1
			else t_flags &= 65534
		if(href_list["plasma"])
			var/t1 = text2num(href_list["plasma"])
			if(t1) t_flags |= 2
			else t_flags &= 65533
		if(href_list["cool"])
			status = text2num(href_list["cool"])
			icon_state = "freezer_[status]"
		if(href_list["transfer"])
			transfer = text2num(href_list["transfer"])
		if(href_list["flask"])
			var/t1 = text2num(href_list["flask"])
			if(t1 <= contents:len)
				var/F = contents[t1]
				F:loc = loc
				rebuild_overlay()
/obj/machinery/freezer/process()
	var/F1
	var/F2
	var/F3
	if(contents:len >= 3)
		F3 = contents[3]
	if(contents:len >= 2)
		F2 = contents[2]
	if(contents:len >= 1)
		F1 = contents[1]
	var/u_cool = 0
	if(status)
		u_cool = c_used
		if(F2 && F2:coolant)
			if(F2:coolant >= u_cool)
				F2:coolant -= u_cool
			else
				u_cool = F2:coolant
				F2:coolant = 0
		else if(F1 && F1:coolant)
			if(F1:coolant >= u_cool)
				F1:coolant -= u_cool
			else
				u_cool = F1:coolant
				F1:coolant = 0
		else if(F3 && F3:coolant)
			if(F3:coolant >= u_cool)
				F3:coolant -= u_cool
			else
				u_cool = F3:coolant
				F3:coolant = 0
		else u_cool = 0
	if(u_cool)
		temperature = max(-100, temperature - u_cool * 5)
	temperature = min(temperature + 5, 10)
	if(transfer)
		var/u_oxy = 0
		var/u_pla = 0
		if(t_flags & 1)
			u_oxy = 1
			if(F1 && F1:oxygen)
				if(F1:oxygen >= u_oxy)
					F1:oxygen -= u_oxy
				else
					u_oxy = F1:oxygen
					F1:oxygen = 0
			else if(F2 && F2:oxygen)
				if(F2:oxygen >= u_oxy)
					F2:oxygen -= u_oxy
				else
					u_oxy = F2:oxygen
					F2:oxygen = 0
			else if(F3 && F3:oxygen)
				if(F3:oxygen >= u_oxy)
					F3:oxygen -= u_oxy
				else
					u_oxy = F3:oxygen
					F3:oxygen = 0
			else u_oxy = 0
		if(t_flags & 2)
			u_pla = 1
			if(F3 && F3:plasma)
				if(F3:plasma >= u_pla)
					F3:plasma -= u_pla
				else
					u_pla = F3:plasma
					F3:plasma = 0
			else
				if(F2 && F2:plasma)
					if(F2:plasma >= u_pla)
						F2:plasma -= u_pla
					else
						u_pla = F2:plasma
						F2:plasma = 0
				else if(F1 && F1:plasma)
					if(F1:plasma >= u_pla)
						F1:plasma -= u_pla
					else
						u_pla = F1:plasma
						F1:plasma = 0
				else u_pla = 0
		if(u_oxy + u_pla > 0)
			var/G = new /obj/substance/gas(null)
			G:oxygen = u_oxy
			G:plasma = u_pla
			G:temperature = temperature
			spawn(3)
				if(line_out) line_out:receive_gas(G, src)
	for(var/mob/M in view(1, src))
		if(M:client && M:machine == src) attack_hand(M)
/obj/machinery/freezer/receive_gas(obj/S, obj/source)
	del(S)
/obj/machinery/freezer/orient_pipe(obj/P)
	if(!line_out) line_out = P
	else
		return 0
	return 1
/obj/machinery/freezer/New()
	..()
	var/O1 = new /obj/overlay()
	O1:icon = 'Cryogenic2.dmi'
	O1:icon_state = "canister connector_0"
	O1:pixel_y = -16
	overlays += O1
	connector = O1
	new /obj/item/weapon/flasks/oxygen(src)
	new /obj/item/weapon/flasks/coolant(src)
	new /obj/item/weapon/flasks/plasma(src)
	rebuild_overlay()
	spawn(50)
		for(var/obj/machinery/M in orange(src, 1))
			if(M:level == level && (p_dir & get_dir(src, M) && M:p_dir & get_dir(M, src)))
				if(!line_out)
					line_out = M
/obj/machinery/freezer/attackby(obj/F, mob/user)
	if(!istype(F, /obj/item/weapon/flasks)) return
	if(contents:len >= 3)
		user << "\blue All slots are full!"
		return
	else
		user:drop_item()
		F:loc = src
		rebuild_overlay()
/obj/machinery/freezer/proc/rebuild_overlay()
	for(var/x in overlays)
		overlays -= x
	overlays += connector
	var/counter = 0
	for(var/obj/item/weapon/flasks/F in src.contents)
		var/O = new /obj/overlay()
		O:icon = F:icon
		O:icon_state = F:icon_state
		O:pixel_y = -17
		O:pixel_x = counter * 12
		overlays += O
		counter++
		if(counter >= 3) return
/obj/machinery/sleeper
	icon_state = "sleeper_0"
	icon = 'Cryogenic2.dmi'
	density = 1
/obj/machinery/sleeper/allow_drop()
	return 0
/obj/machinery/sleeper/ex_act(severity)
	switch(severity)
		if(1)
			for(var/atom/movable/A in src)
				A:loc = loc
				A:ex_act(severity)
			del(src)
		if(2)
			if(prob(50))
				for(var/atom/movable/A in src)
					A:loc = loc
					A:ex_act(severity)
				del(src)
/obj/machinery/sleeper/verb/eject()
	set src in oview(1)
	if(usr.stat != 0) return
	go_out()
/obj/machinery/sleeper/verb/place_inside()
	set src in oview(1)
	if(usr.stat != 0) return
	if(occupant)
		usr << "\blue<B>The sleeper is already occupied!</B>"
		return
	if(ismob(usr.pulling))
		if(get_dist(src, usr) <= 1 && (get_dist(usr, usr.pulling) <= 1 && (isturf(usr.pulling:loc) && isturf(usr.loc))))
			var/M = usr.pulling
			if(locate(/obj) in M)
				usr << "Subject may not have abiotic items on."
				return
			usr.pulling = null
			if(M:client)
				M:client:perspective = EYE_PERSPECTIVE
				M:client:eye = src
			M:loc = src
			occupant = M
			icon_state = "sleeper_1"
			for(var/obj/O in src)
				O:loc = loc
/obj/machinery/sleeper/verb/move_inside()
	set src in oview(1)
	if(usr.stat != 0) return
	if(occupant)
		usr << "\blue<B>The sleeper is already occupied!</B>"
		return
	if(locate(/obj) in usr)
		usr << "Subject may not have abiotic items on."
		return
	usr.pulling = null
	usr.client:perspective = EYE_PERSPECTIVE
	usr.client:eye = src
	usr.loc = src
	occupant = usr
	icon_state = "sleeper_1"
	for(var/obj/O in src)
		del(O)
/obj/machinery/sleeper/proc/go_out()
	if(!occupant) return
	for(var/obj/O in src)
		O:loc = loc
	if(occupant:client)
		occupant:client:eye = occupant:client:mob
		occupant:client:perspective = MOB_PERSPECTIVE
	occupant:loc = loc
	occupant = null
	icon_state = "sleeper_0"
/obj/machinery/sleeper/anchored = 1
/obj/machinery/sleeper/ex_act(severity)
	switch(severity)
		if(1)
			for(var/atom/movable/A in src)
				A:loc = loc
				A:ex_act(severity)
			del(src)
		if(2)
			if(prob(50))
				for(var/atom/movable/A in src)
					A:loc = loc
					A:ex_act(severity)
				del(src)
		if(3)
			if(prob(25))
				for(var/atom/movable/A in src)
					A:loc = loc
					A:ex_act(severity)
				del(src)
/obj/machinery/sleeper/proc/inject(mob/user)
	if(occupant)
		if(occupant:rejuv < 60)
			occupant:rejuv = 60
		user << "Occupant now has [occupant:rejuv] units of rejuvenation in his/her bloodstream."
	else user << "No occupant!"
/obj/machinery/sleeper/proc/check(mob/user)
	if(occupant)
		user << "\blue<B>Occupant ([occupant]) Statistics:</B>"
		var/t1
		switch(occupant:stat)
			if(0)
				t1 = "Conscious"
			if(1)
				t1 = "Unconscious"
			if(2)
				t1 = "*dead*"
		user << "[occupant:health > 50 ? "\blue" : "\red"]\t Health %: [occupant:health] ([t1])"
		user << "[occupant:oxyloss < 60 ? "\blue" : "\red"]\t -Respiratory Damage %: [occupant:oxyloss]"
		user << "[occupant:toxloss < 60 ? "\blue" : "\red"]\t -Toxin Content %: [occupant:toxloss]"
		user << "[occupant:fireloss < 60 ? "\blue" : "\red"]\t -Burn Severity %: [occupant:fireloss]"
		user << "\blue Expected time till occupant can safely awake: (note: If health is below 20% these times are inaccurate)"
		user << "\blue\t [occupant:paralysis / 5] second\s (if around 1 or 2 the sleeper is keeping them asleep.)"
	else user << "\blue There is no one inside!"
/obj/machinery/sleeper/alter_health(mob/M)
	if(M:health > 0)
		if(M:oxyloss >= 10)
			var/mob/amount = max(0.15, 1)
			M:health += amount
			M:oxyloss -= amount
		else
			M:health += M:oxyloss
			M:oxyloss = 0
	M:paralysis -= 4
	M:weakened -= 4
	M:stunned -= 4
	if(M:paralysis <= 1)
		M:paralysis = 3
	if(M:weakened <= 1)
		M:weakened = 3
	if(M:stunned <= 1)
		M:stunned = 3
	if(M:rejuv < 3)
		M:rejuv = 4
/obj/machinery/sleeper/var/occupant
/obj/machinery/cryo_cell{icon_state = "celltop"; var/line_in}
/obj/machinery/cryo_cell/ex_act(severity)
	switch(severity)
		if(1)
			del(src)
		if(2)
			if(prob(50))
				for(var/x in verbs)
					verbs -= x
				icon_state = "broken"







/obj/machinery/cryo_cell/orient_pipe(obj/P)
	if(!line_in) line_in = P
	else
		return 0
	return 1
/obj/machinery/cryo_cell/allow_drop() return 0

/obj/machinery/cryo_cell/New()
	..()
	gas = new /obj/substance/gas(null)
	spawn(50)
		for(var/obj/machinery/M in orange(src, 1))
			if(M:level == level && (p_dir & get_dir(src, M) && M:p_dir & get_dir(M, src)))
				if(!line_in)
					line_in = M
/obj/machinery/cryo_cell/process()
	for(var/mob/M in view(1, src))
		if(M.client && M.machine == src) attack_hand(M)
/obj/machinery/cryo_cell/verb/move_eject()
	set src in oview(1)
	if(usr.stat != 0) return
	go_out()
/obj/machinery/cryo_cell/verb/place_inside()
	set src in oview(1)
	if(usr.stat != 0) return
	if(occupant)
		usr << "\blue<B>The cell is already occupied!</B>"
		return
	if(ismob(usr.pulling))
		if(get_dist(src, usr) <= 1 && (get_dist(usr, usr.pulling) <= 1 && (isturf(usr.pulling:loc) && isturf(usr.loc))))
			var/M = usr.pulling
			if(locate(/obj) in M)
				usr << "Subject may not have abiotic items on."
				return
			usr.pulling = null
			if(M:client)
				M:client:perspective = EYE_PERSPECTIVE
				M:client:eye = src
			M:loc = src
			occupant = M
			icon_state = "celltop_1"
			for(var/obj/O in src)
				del(O)
/obj/machinery/cryo_cell/verb/move_inside()
	set src in oview(1)
	if(usr.stat != 0) return
	if(occupant)
		usr << "\blue<B>The cell is already occupied!</B>"
		return
	if(locate(/obj) in usr)
		usr << "Subject may not have abiotic items on."
		return
	usr.pulling = null
	usr.client:perspective = EYE_PERSPECTIVE
	usr.client:eye = src
	usr.loc = src
	occupant = usr
	icon_state = "celltop_1"
	for(var/obj/O in src)
		O:loc = loc
/obj/machinery/cryo_cell/attack_paw(mob/user)
	return attack_hand(user)
/obj/machinery/cryo_cell/attack_hand(mob/user)
	if(istype(user, /mob/human))
		var/dat = "<font color='blue'> <B>System Statistics:</B></FONT><BR>"
		if(gas:temperature > 0)
			dat += "<font color='red'>\tTemperature (Farenheight): [gas:temperature] (MUST be below 0, add coolant to mixture)</FONT><BR>"
		else
			dat += "<font color='blue'>\tTemperature(Farenheight): [gas:temperature] </FONT><BR>"
		if(gas:plasma < 1)
			dat += "<font color='red'>\tPlasma Units: [gas:plasma] (Add plasma to mixture!)</FONT><BR>"
		else
			dat += "<font color='blue'>\tPlasma Units: [gas:plasma]</FONT><BR>"
		if(gas:oxygen < 1)
			dat += "<font color='red'>\tOxygen Units: [gas:oxygen] (Add oxygen to mixture!)</FONT><BR>"
		else
			dat += "<font color='blue'>\tOxygen Units: [gas:oxygen]</FONT><BR>"
		if(occupant)
			dat += "<font color='blue'><B>Occupant Statistics:</B></FONT><BR>"
			var/t1
			switch(occupant:stat)
				if(0)
					t1 = "Conscious"
				if(1)
					t1 = "Unconscious"
				if(2)
					t1 = "*dead*"
			dat += "[occupant:health > 50 ? "<font color='blue'>" : "<font color='red'>"]\tHealth %: [occupant:health] ([t1])</FONT><BR>"
			dat += "[occupant:oxyloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t-Respiratory Damage %: [occupant:oxyloss]</FONT><BR>"
			dat += "[occupant:toxloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t-Toxin Content %: [occupant:toxloss]</FONT><BR>"
			dat += "[occupant:fireloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t-Burn Severity %: [occupant:fireloss]</FONT>"

		dat += "<BR><BR><A href='?src=\ref[user];mach_close=cryo'>Close</A>"
		user << browse(dat, "window=cryo;size=400x500")
	else
		var/dat = "<font color='blue'> <B>[stars("System Statistics:")]</B></FONT><BR>"
		if(gas:temperature > 0)
			dat += "<font color='red'>\t[stars("Temperature (Farenheight): [gas:temperature] (MUST be below 0, add coolant to mixture)")]</FONT><BR>"
		else
			dat += "<font color='blue'>\t[stars("Temperature(Farenheight): [gas:temperature]")] </FONT><BR>"
		if(gas:plasma < 1)
			dat += "<font color='red'>\t[stars("Plasma Units: [gas:plasma] (Add plasma to mixture!)")]</FONT><BR>"
		else
			dat += "<font color='blue'>\t[stars("Plasma Units: [gas:plasma]")]</FONT><BR>"
		if(gas:oxygen < 1)
			dat += "<font color='red'>\t[stars("Oxygen Units: [gas:oxygen] (Add oxygen to mixture!)")]</FONT><BR>"
		else
			dat += "<font color='blue'>\t[stars("Oxygen Units: [gas:oxygen]")]</FONT><BR>"
		if(occupant)
			dat += "<font color='blue'><B>Occupant Statistics:</B></FONT><BR>"
			var/t1
			switch(occupant:stat)
				if(0)
					t1 = "Conscious"
				if(1)
					t1 = "Unconscious"
				if(2)
					t1 = "*dead*"
			dat += "[occupant:health > 50 ? "<font color='blue'>" : "<font color='red'>"]\t[stars("Health %: [occupant:health] ([t1])")]</FONT><BR>"
			dat += "[occupant:oxyloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t[stars("-Respiratory Damage %: [occupant:oxyloss]")]</FONT><BR>"
			dat += "[occupant:toxloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t[stars("-Toxin Content %: [occupant:toxloss]")]</FONT><BR>"
			dat += "[occupant:fireloss < 60 ? "<font color='blue'>" : "<font color='red'>"]\t[stars("-Burn Severity %: [occupant:fireloss]")]</FONT>"

		dat += "<BR><BR><A href='?src=\ref[user];mach_close=cryo'>Close</A>"
		user << browse(dat, "window=cryo;size=400x500")
/obj/machinery/cryo_cell/proc/go_out()
	if(!occupant) return
	for(var/obj/O in src)
		O:loc = loc
	if(occupant:client)
		occupant:client:eye = occupant:client:mob
		occupant:client:perspective = MOB_PERSPECTIVE
	occupant:loc = loc
	occupant = null
	icon_state = "celltop"
/obj/machinery/cryo_cell/relaymove()
	go_out()
/obj/machinery/cryo_cell/alter_health(mob/M)
	if(M:health < 0)
		if(gas:temperature > 0 || gas:plasma < 1)
			return
	if(M:stat == 2) return
	if(gas:oxygen >= 1)
		gas:oxygen--
		if(M:oxyloss >= 10)
			var/mob/amount = max(0.15, 2)
			M:health += amount
			M:oxyloss -= amount
		else
			M:health += M:oxyloss
			M:oxyloss = 0
	if(gas:temperature < 0 && gas:plasma >= 1)
		gas:plasma--
		if(M:toxloss > 5)
			var/mob/amount = max(0.1, 2)
			M:health += amount
			M:toxloss -= amount
		else
			M:health += M:toxloss
			M:toxloss = 0

		if(M:fireloss > 15)
			var/mob/amount = max(0.3, 2)
			M:health += amount
			M:fireloss -= amount
		else
			M:health += M:fireloss
			M:fireloss = 0


		if(M:bruteloss > 10)
			var/mob/amount = max(0.3, 2)
			M:health += amount
			M:bruteloss -= amount
		else
			M:health += M:bruteloss
			M:bruteloss = 0

		M:paralysis += 5
	if(gas:temperature < 60)
		gas:temperature = min(gas:temperature + 1, 60)
	for(var/mob/E in view(1, src))
		if(E:client && E:machine == src) attack_hand(E)
	return
/obj/machinery/cryo_cell/receive_gas(obj/S, obj/source)
	if(!istype(S, /obj/substance/gas))
		del(S)
		return
	else
		gas:merge_into(S)
		del(S)
	for(var/mob/M in view(1, src))
		if(M:client && M:machine == src) attack_hand(M)
/obj/machinery/cryo_cell/New()
	..()
	layer = 5
	var/O1 = new /obj/overlay()
	O1:icon = 'Cryogenic2.dmi'
	O1:icon_state = "cellconsole"
	O1:pixel_y = -32
	O1:layer = 4
	var/O2 = new /obj/overlay()
	O2:icon = 'Cryogenic2.dmi'
	O2:icon_state = "cellbottom"
	O2:pixel_y = -32
	pixel_y = 32
	overlays += O2
	overlays += O1

/obj/machinery/cryo_cell
	var/occupant
	var/gas
	icon = 'Cryogenic2.dmi'
	density = 1
	anchored = 1
	p_dir = 8
