#define OPTIONS list ("Telepathy", "Mind Reading", "Stun", "Cancel")

/obj/item/device/psiamp
	name = "Psionic Amplifier"
	desc = "Super Cool Placeholder"

/obj/item/psiamp/attack_self(var/user)
    var/target
    var/choice = input(user, "What would you like to do?", null) in OPTIONS
    switch(choice)
        if("Telepathy")
            target = input(user, "Who would you like to send a message to?", null) in OPTIONS

        if("Mind Reading")

        if("Stun")

        if("Cancel")
            return