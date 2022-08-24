

/datum/hand_project
	var/name
	var/desc
	var/reward = 0
	var/selected = FALSE
	var/complete = FALSE

/datum/hand_project/mechanic

/datum/hand_project/mechanic/tool
	name = "tool"
	desc = "scan a tool."
	reward = 2000

/datum/hand_project/biology

/datum/hand_project/biology/egg
	name = "egg"
	desc = "scan an egg."
	reward = 2000