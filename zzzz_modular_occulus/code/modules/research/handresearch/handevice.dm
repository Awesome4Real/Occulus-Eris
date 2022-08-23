#define FILTERS list ("Biology","Mechanical")


/obj/item/device/hand_tool
	name = "HAND Unit"
	icon_state = "science"
	item_state = "sciencetool"
	desc = "A hand-held device capable of extracting usefull data from various sources, such as paper reports and slime cores."
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = ITEM_SIZE_SMALL
	throw_speed = 5
	throw_range = 10
	matter = list(MATERIAL_STEEL = 5)
	origin_tech = list(TECH_ENGINEERING = 1, TECH_BIO = 1)


/obj/item/device/hand_tool/proc/select_bio(mob/user)
	to_chat(user, SPAN_NOTICE("bio."))
	return

/obj/item/device/hand_tool/proc/select_eng(mob/user)
	to_chat(user, SPAN_NOTICE("eng."))
	return

/obj/item/device/hand_tool/attack_self(mob/user)
	var/choice = input(usr, "Select what research field you want your projects to be filtered by", "Filter selection", null) in FILTERS
	switch(choice)
		if("Biology")
			select_bio(user)
			return
		if("Mechanical")
			select_eng(user)
			return
		else
			to_chat(user, SPAN_NOTICE("[src]\'s data buffer is empty."))
			return