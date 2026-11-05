var/world_message = "Welcome to SS13!"
var/changes = {"<FONT color='blue'><B>Changes</B></FONT>
<B>Version 40.82(1)(2)(3):</B>
	Stuttering has been added. It has uses other than a disability.
	I toned down getting a disability a bit.
	Overconsumption of certain chemicals can cause adverse effects
		injected plasam no longer causes instant damage
		injected antitoxs can provide blood immunity
			to overconsumption
			it CAN also be overconsumed
	I added a delay to administering a pill.
		You can eat one instantly however.
	Added placebos
	Bug fixes.
		dead say should be back
	I finally caved into the excessive amount of requests...
		I thought you guys wanted better things but due
			to the really nice icon by SoraKu =]
			I added the straight jackets :/
	New mode! Hosts: You need more than 3 players

<B>Version 40.82:</B>
	Tourette's Syndrome - It's not too bad. >:D
		its pills which aren't bad at all >>:D
		I really have sympathy for people with this syndrome.
			Maybe this might instill some as well.
	Added a few more medical items:
		Pills that relieve antitoxin damage, chronic cough,
		epilepsy, Tourette, and let you sleep are in.
	Their canisters are marked and described and adequately dispersed
	You can put health analyzers on your belt.
		Other medical diagnosis ideas would be nice...

	I added another courtroom to prison station.
	The radio frequencies have been changed.
		There are now 25 freqs and 100 codes. 2500 possibilities for signaller =]
	Bug Fixes

<B>Version 40.81: (40.811/2 with bug fixes)</B>
	The heat system is in partially. It does nothng yet.
		You can check a tiles heat with an analyzer.
		Try playing around with it and report strange behaviors to me.
	You can 'push' (or pull) what you arepullng more accruately without trying to move.
		This is done by double clicking on a floor tile. the object will TRY to go there.
	ID thievery is now exceedingly more difficult
		Speaking gives you away
		You must be covering your face else its obvious your lying
	NO MORE BAN SPAM!!!!!!

<B>Version 40.8:</B>
	Prison Station
		3 new jobs:
			Prison Security: A securiy officer in the prison. There are 2.
			Prison Doctor: A doctor in the prison infirmary. He CAN act as an officer
				if so equipped.
			Prison Warden: The ruler of the station.
		1 new shuttle:
			The shuttle is docked at the prison station and can be piloted to SS13
				by a prison official (and anyone who gets to the controls)
		I suggest that only major criminals go there but it is a safe palce to put prisoners
			as it stays VERY isolated.
		Working here isn't exactly exciting and would most likely be exceedingly boring.
			However someone has to do it. It's a great last resort job.
	Also the stations a tank. you can't drill through the walls.floors. I made them
		invulnerable. This station was made to stop that build up of prisoners.

<B>Version 40.77:</B>
	Flashbang grenades
	Redone blindness/deafness
	Eyedropper

Version 40.76:</B>
	Wirecutters cut paper
	You can repair reinforced walls
	Yellow Jumpsuits (Technicians)
	Bug fixes

<B>Version 40.70+40.75</B>
	This version contains a slight remodellnig of the rooms as well as
bug fixes.

<B>Version 40.66</B>
	Experiment with assemblies!

<B>Version 40.5 Changes:</B>

Flashes have a slightly more offensive use when aimed at someone at CLOSE range. I mean close range.
Due to this they have a slight ammo thing.
So give them to staff assistants security guards... You already got your tasers.

No air in shuttle fixed, dead men breathing, and dead men DNA fixed."}
var/list/bombers = list()
























































































































































































































































































































/proc/add_zero(t, u)
	while(length(t) < u)
		t = "0[t]"
	return t
/obj/bomb
	icon_state = "x"
	icon = 'screen1.dmi'
/obj/bomb/New()
	..()
	var/R = new /obj/item/weapon/assembly/r_i_ptank(loc)
	var/p3 = new /obj/item/weapon/tank/plasmatank(R)
	var/p1 = new /obj/item/weapon/radio/signaler(R)
	var/p2 = new /obj/item/weapon/igniter(R)

	R:part1 = p1
	R:part2 = p2
	R:part3 = p3

	p1:master = R
	p2:master = R
	p3:master = R

	R:status = 1
	p1:b_stat = 0
	p2:status = 1

	del(src)





















































































/atom
	var/level = 2
	var/flags

/atom/proc/burn(fi_amount)
/atom/movable/layer = 3


/atom/movable/Move()
	var/A = loc
	. = ..()
	m_flag = 1
	if(A != loc && (A && A:z == z))
		last_move = get_dir(A, loc)

/obj/proc/throwing(t_dir, rs)
	if(throwspeed <= 1) throwing = 0
	throwspeed--
	if(rs == 0) rs = 1
	if(throwing)
		if(rs == 1)
			step(src, t_dir)
			sleep(1)
			spawn(0) throwing(t_dir, rs)
		else if(rs > 1)
			for(var/t, t < rs, t++)
				step(src, t_dir)
			sleep(10)
			spawn(0) throwing(t_dir, rs)
		else
			step(src, t_dir)
			sleep(10 / rs)
			spawn(0) throwing(t_dir, rs)
	else density = 0

/turf
	var/intact = 0
/atom/movable
	var/last_move
	var/anchored = 0
	var/weight = 0
	var/m_flag = 1
/area
	var/fire
	layer = 1
	level = null
/obj
	var/throwspeed = 0
	var/throwing = null