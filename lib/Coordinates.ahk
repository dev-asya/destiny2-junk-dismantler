;Find the coordinates for equipment slots- this is written for 1920x1080 displays.

resolution := 1080

weaponSlots := [1, 2, 3]
armourSlots := [1, 2, 3, 4, 5]

if (resolution := 1080)
{
    ;This is the distance between (equipped) gear slots
    global_equipped_offset_x := 0
    global_equipped_offset_y := 120

    ;These are the distances between equipped gear slots and unequipped gear slots
    weapon_unequipped_offset_x := -100
    weapon_unequipped_offset_y := 0
    armour_unequipped_offset_x := 100
    armour_unequipped_offset_y := 0

    ;These are the coordinates of the starting positions for Kinetic Weapons and Helmet Armour
    weapon_kinetic_start_x := 520
    weapon_kinetic_start_y := 370
    armour_helmet_start_x := 1400
    armour_helmet_start_y := 250
}

weapon_equipped := Array2D(3, 2) ; A Multi-Dimensional Array containing 3 slots (Kinetic, Energy, Power) and their respective Screen Coordinates
weapon_unequipped := Array2D(3, 2)
for i in weaponSlots {
    weapon_equipped[i, 1] := weapon_kinetic_start_x + (i - 1) * global_equipped_offset_x
    weapon_equipped[i, 2] := weapon_kinetic_start_y + (i - 1) * global_equipped_offset_y
}

; This finds the on-screen coordinates of the first weapon in each slot that isn't equipped
weapon_unequipped_slot() {
    for i in weaponSlots
    {
        weapon_unequipped[i, 1] := weapon_equipped[i, 1] + weapon_unequipped_offset_x
        weapon_unequipped[i, 2] := weapon_equipped[i, 2] + weapon_unequipped_offset_y
    }
    return
}

armour_equipped := Array2D(5, 2) ; A Multi-Dimensional Array containing 5 slots (Helmet, Gauntlets, Chest, Legs, Class Item) and their respective Screen Coordinates
armour_unequipped := Array2D(5, 2)
for i in armourSlots {
    armour_equipped[i, 1] := armour_helmet_start_x + (i - 1) * global_equipped_offset_x
    armour_equipped[i, 2] := armour_helmet_start_y + (i - 1) * global_equipped_offset_y
}

; This finds the coordinates of the first armour piece in each slot that isn't equipped
armour_unequipped_slot() {
    for i in armourSlots
    {
        armour_unequipped[i, 1] := armour_equipped[i, 1] + armour_unequipped_offset_x
        armour_unequipped[i, 2] := armour_equipped[i, 2] + armour_unequipped_offset_y
    }
    return
}