;--------------------------------------------------------------------------------------------------------------
;This implements a GUI asking the user to input what they want to dismantle.
;Thanks : Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2
GuiOptions := ""
GuiTitle := "dev-asya's Destiny 2 Junk Dismantler :)"

JunkGui := Gui(GuiOptions, GuiTitle)
JunkGui.SetFont("s9")

JunkGui.Add("CheckBox", "vKinetic x24 y104 w128 h16", "Kinetic Weapons")
JunkGui.Add("CheckBox", "vEnergy x24 y188 w129 h16", "Energy Weapons")
JunkGui.Add("CheckBox", "vPower x24 y272 w127 h16", "Power Weapons")
JunkGui.Add("CheckBox", "vHelmet x272 y104 w77 h16", "Helmets")
JunkGui.Add("CheckBox", "vGauntlets x272 y146 w83 h16", "Gauntlets")
JunkGui.Add("CheckBox", "vChest x272 y188 w107 h16", "Chest Armour")
JunkGui.Add("CheckBox", "vLegs x272 y230 w96 h16", "Leg Armour")
JunkGui.Add("CheckBox", "vClassItem x272 y272 w96 h16", "Class Items")

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