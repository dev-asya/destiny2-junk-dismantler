; This dismantles all items in an inventory slot
dismantle_slot() {
    Loop 9 {
        Sleep 600 ; Slight delay to account for loading times
        Send "{F down}"
        Sleep 4500  ; 4.5 seconds to dismantle exotics & crafted weapons
        Send "{F up}"
    }
}

dismantle_armour(slot) {
    SendMode("Event")
    Sleep 800
    MouseMove armour_equipped[slot, 1], armour_equipped[slot, 2], 5
    Sleep 300
    MouseMove armour_unequipped[slot, 1], armour_unequipped[slot, 2], 5
    SendMode("Input")
    dismantle_slot()
}

dismantle_weapon(slot) {
    SendMode("Event")
    Sleep 800
    MouseMove weapon_equipped[slot, 1], weapon_equipped[slot, 2], 5
    Sleep 300
    MouseMove weapon_unequipped[slot, 1], weapon_unequipped[slot, 2], 5
    SendMode("Input")
    dismantle_slot()
}