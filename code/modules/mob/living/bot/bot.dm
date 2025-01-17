/mob/living/bot
	name = "Bot"
	health = 20
	maxHealth = 20
	icon = 'icons/obj/aibots.dmi'
	layer = MOB_LAYER
	universal_speak = 1
	density = FALSE
	bad_type = /mob/living/bot
	var/obj/item/card/id/botcard = null
	var/list/botcard_access = list()
	var/on = TRUE
	var/open = 0
	var/locked = 1
	var/emagged = 0
	var/light_strength = 3

	var/obj/access_scanner = null
	var/list/req_access = list()
	var/list/req_one_access = list()
	mob_classification = CLASSIFICATION_SYNTHETIC

/mob/living/bot/New()
	..()
	update_icons()

	botcard = new /obj/item/card/id(src)
	botcard.access = botcard_access.Copy()

	access_scanner = new /obj(src)
	access_scanner.req_access = req_access.Copy()
	access_scanner.req_one_access = req_one_access.Copy()

/mob/living/bot/Life()
	..()
	if(health <= 0)
		death()
		return
	weakened = 0
	stunned = 0
	paralysis = 0

/mob/living/bot/updatehealth()
	if(status_flags & GODMODE)
		health = maxHealth
		stat = CONSCIOUS
	else
		health = maxHealth - getFireLoss() - getBruteLoss()
	oxyloss = 0
	toxloss = 0
	cloneloss = 0
	halloss = 0

/mob/living/bot/death()
	explode()

/mob/living/bot/attackby(var/obj/item/O, var/mob/user)
	if(O.GetIdCard())
		if(access_scanner.allowed(user) && !open && !emagged)
			locked = !locked
			to_chat(user, "<span class='notice'>Controls are now [locked ? "locked." : "unlocked."]</span>")
			attack_hand(user)
		else
			if(emagged)
				to_chat(user, SPAN_WARNING("ERROR"))
			if(open)
				to_chat(user, SPAN_WARNING("Please close the access panel before locking it."))
			else
				to_chat(user, SPAN_WARNING("Access denied."))
		return
	else if(istype(O, /obj/item/tool/screwdriver))
		if(!locked)
			open = !open
			to_chat(user, "<span class='notice'>Maintenance panel is now [open ? "opened" : "closed"].</span>")
		else
			to_chat(user, SPAN_NOTICE("You need to unlock the controls first."))
		return
	else if(istype(O, /obj/item/tool/weldingtool))
		if(health < maxHealth)
			if(open)
				health = min(maxHealth, health + 10)
				user.visible_message(SPAN_NOTICE("[user] repairs [src]."),SPAN_NOTICE("You repair [src]."))
			else
				to_chat(user, SPAN_NOTICE("Unable to repair with the maintenance panel closed."))
		else
			to_chat(user, SPAN_NOTICE("[src] does not need a repair."))
		return
	else
		..()

/mob/living/bot/attack_ai(var/mob/user)
	return attack_hand(user)

/mob/living/bot/say(var/message)
	var/verb = "beeps"

	message = sanitize(message)

	..(message, null, verb)

/mob/living/bot/Bump(var/atom/A)
	if(on && botcard && istype(A, /obj/machinery/door))
		var/obj/machinery/door/D = A
		if(!istype(D, /obj/machinery/door/firedoor) && !istype(D, /obj/machinery/door/blast) && D.check_access(botcard))
			D.open()
	else
		..()

/mob/living/bot/emag_act(var/remaining_charges, var/mob/user)
	return 0

/mob/living/bot/proc/turn_on()
	if(stat)
		return 0
	on = TRUE
	set_light(light_strength)
	update_icons()
	return 1

/mob/living/bot/proc/turn_off()
	on = FALSE
	set_light(0)
	update_icons()

/mob/living/bot/proc/explode()
	qdel(src)

