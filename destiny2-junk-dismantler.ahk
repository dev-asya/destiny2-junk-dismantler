#SingleInstance Force
#Requires Autohotkey v2

weaponSlots := [1,2,3]
armourSlots := [1,2,3,4,5]

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

weapon_equipped := Array2D(3,2) ; A Multi-Dimensional Array containing 3 slots (Kinetic, Energy, Power) and their respective Screen Coordinates
weapon_unequipped := Array2D(3,2)

armour_equipped := Array2D(5,2) ; A Multi-Dimensional Array containing 5 slots (Helmet, Gauntlets, Chest, Legs, Class Item) and their respective Screen Coordinates
armour_unequipped := Array2D(5,2)

for i in weaponSlots{
weapon_equipped[i,1] := weapon_kinetic_start_x + (i-1) * global_equipped_offset_x
weapon_equipped[i,2] := weapon_kinetic_start_y + (i-1) * global_equipped_offset_y
}

for i in armourSlots{
armour_equipped[i,1] := armour_helmet_start_x + (i-1) * global_equipped_offset_x
armour_equipped[i,2] := armour_helmet_start_y + (i-1) * global_equipped_offset_y
}

weapon_unequipped_slot()
armour_unequipped_slot()
;--------------------------------------------------------------------------------------------------------------
;This implements a GUI asking the user to input what they want to dismantle.
;This was a good challenge
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2
GuiOptions := ""
GuiTitle := "dev-asya's Destiny 2 Junk Dismantler :)"

JunkGui := Gui(GuiOptions,GuiTitle)
JunkGui.SetFont("s9")

JunkGui.Add("CheckBox", "vKinetic x24 y104 w128 h16", "Kinetic Weapons") 
JunkGui.Add("CheckBox", "vEnergy x24 y188 w129 h16", "Energy Weapons") 
JunkGui.Add("CheckBox", "vPower x24 y272 w127 h16", "Power Weapons") 
JunkGui.Add("CheckBox", "vHelmet x272 y104 w77 h16", "Helmets" ) 
JunkGui.Add("CheckBox", "vGauntlets x272 y146 w83 h16", "Gauntlets") 
JunkGui.Add("CheckBox", "vChest x272 y188 w107 h16", "Chest Armour")
JunkGui.Add("CheckBox", "vLegs x272 y230 w96 h16", "Leg Armour") 
JunkGui.Add("CheckBox", "vClassItem x272 y272 w96 h16","Class Items") 

JunkGui.SetFont("s18")
JunkGui.Add("Text", "x60 y24 h45 +0x200", "What do you want to dismantle?")
JunkGui.SetFont("s8")

ButtonDismantleJunk := JunkGui.Add("Button", "Default x160 y376 w283 h111 c0000FF", "Dismantle Junk :)")
ButtonCancel := JunkGui.Add("Button", "x24 y376 w120 h115 cFF0000", "Cancel :(")

ButtonDismantleJunk.OnEvent("Click", DismantleSpecifiedJunk)
ButtonCancel.OnEvent("Click", JunkGui_Close)

JunkGui_Close(*) {
    JunkGui.Destroy()
}
JunkGui.Show()
;--------------------------------------------------------------------------------------------------------------
DismantleSpecifiedJunk(*)
{
ToDismantle := JunkGui.Submit()  ; Save the contents of named controls into an object.
Sleep 1200

    if ToDismantle.Kinetic = 1 {
        dismantle_weapon(1)
    }
    if ToDismantle.Energy = 1 {
        dismantle_weapon(2)
    }
    if ToDismantle.Power = 1 {
        dismantle_weapon(3)
    }
    if ToDismantle.Helmet = 1 {
        dismantle_armour(1)
    }
    if ToDismantle.Gauntlets = 1 {
        dismantle_armour(2)
    }
    if ToDismantle.Chest = 1 {
        dismantle_armour(3)
    }
    if ToDismantle.Legs = 1 {
        dismantle_armour(4)
    }
    if ToDismantle.ClassItem = 1 {
        dismantle_armour(5)
    }
}
;---------------------------------------------------------------------------------------------------------------
; This finds the on-screen coordinates of the first weapon in each slot that isn't equipped
weapon_unequipped_slot() {   
    for i in weaponSlots
    {
    weapon_unequipped[i,1] := weapon_equipped[i,1] + weapon_unequipped_offset_x 
    weapon_unequipped[i,2] := weapon_equipped[i,2] + weapon_unequipped_offset_y
    }
    return
} 

; This finds the coordinates of the first armour piece in each slot that isn't equipped
armour_unequipped_slot() {
    for i in armourSlots
    {
        armour_unequipped[i,1] := armour_equipped[i,1] + armour_unequipped_offset_x
        armour_unequipped[i,2] := armour_equipped[i,2] + armour_unequipped_offset_y
    }   
    return
}

dismantle_weapon(slot) {
SendMode("Event")
Sleep 800
MouseMove weapon_equipped[slot,1] , weapon_equipped[slot,2] , 5
Sleep 300
MouseMove weapon_unequipped[slot,1] , weapon_unequipped[slot,2],5
SendMode("Input")
dismantle_slot()
}

dismantle_armour(slot) {
SendMode("Event")
Sleep 800
MouseMove armour_equipped[slot,1] , armour_equipped[slot,2] , 5
Sleep 300
MouseMove armour_unequipped[slot,1] , armour_unequipped[slot,2] , 5
SendMode("Input")
dismantle_slot()
}

; This dismantles all items in an inventory slot
dismantle_slot()  {
    Loop 9 {
        Sleep 600 ; Slight delay to account for loading times
        Send "{F down}"
        Sleep 4500  ; 4.5 seconds to dismantle exotics & crafted weapons
        Send "{F up}"
    }
}
;-----------------------------------------------------------------------------------------------------
class Array2D extends Array {
    __new(x, y) {
        this.Length := x * y
        this.Width := x
        this.Height := y
    }
    __Item[x, y] {
        get => super.Has(this.i[x, y]) ? super[this.i[x, y]] : false
        set => super[this.i[x, y]] := value
    }
    i[x, y] => this.Width * (y-1) + x
}