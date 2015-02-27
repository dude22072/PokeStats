Attribute VB_Name = "Module1"
Public Sub Main() 'derptest!
    
    If CheckPath("Z:\pokestats.txt") Then
        frmMain.CommonDialog1.FileName = ("Z:\pokestats.txt")
        Debug.Print (frmMain.CommonDialog1.FileName)
    Else
        On Error GoTo errorHandler
        frmMain.CommonDialog1.InitDir = App.Path
        frmMain.CommonDialog1.CancelError = True
        frmMain.CommonDialog1.Filter = "Pokestats|pokestats.txt|Text Files (*.txt)|*.txt|All (*.*)|*.*"
        frmMain.CommonDialog1.ShowOpen
        Debug.Print (frmMain.CommonDialog1.FileName)
    End If
    GoTo phaseTwo
    Exit Sub
phaseTwo:
    frmMain.Visible = True
    frmMain.timFileReader.Enabled = True
    Exit Sub
errorHandler:
        End
    Exit Sub
End Sub

Public Function expNeeded(ByVal curLevel As Long, ByVal expGroup As Long) As Long
    Select Case expGroup 'Slow, Medium Slow, Medium Fast, Fast
    Case 1
        expNeeded = ((5 * (curLevel ^ 3)) / 4)
    Case 2
        expNeeded = (1.2 * (curLevel ^ 3)) - (15 * (curLevel ^ 2)) + (100 * curLevel) - 140
    Case 3
        expNeeded = (curLevel ^ 3)
    Case 4
        expNeeded = ((4 * (curLevel ^ 3)) / 5)
    Case Else
        expNeeded = 1
    End Select
End Function

Public Function getExpGroup(ByVal species As String) As Long
    Select Case species
    Case "Bulbasaur"
        getExpGroup = 2
    Case "Ivysaur"
        getExpGroup = 2
    Case "Venusaur"
        getExpGroup = 2
    Case "Charmander"
        getExpGroup = 2
    Case "Charmeleon"
        getExpGroup = 2
    Case "Charizard"
        getExpGroup = 2
    Case "Squirtle"
        getExpGroup = 2
    Case "Wartortle"
        getExpGroup = 2
    Case "Blastoise"
        getExpGroup = 2
    Case "Caterpie"
        getExpGroup = 3
    Case "Metapod"
        getExpGroup = 3
    Case "Butterfree"
        getExpGroup = 3
    Case "Weedle"
        getExpGroup = 3
    Case "Kakuna"
        getExpGroup = 3
    Case "Beedrill"
        getExpGroup = 3
    Case "Pidgey"
        getExpGroup = 2
    Case "Pidgeotto"
        getExpGroup = 2
    Case "Pidgeot"
        getExpGroup = 2
    Case "Rattata"
        getExpGroup = 3
    Case "Raticate"
        getExpGroup = 3
    Case "Spearow"
        getExpGroup = 3
    Case "Fearow"
        getExpGroup = 3
    Case "Ekans"
        getExpGroup = 3
    Case "Arbok"
        getExpGroup = 3
    Case "Pikachu"
        getExpGroup = 3
    Case "Raichu"
        getExpGroup = 3
    Case "Sandshrew"
        getExpGroup = 3
    Case "Sandslash"
        getExpGroup = 3
    Case "NidoranF"
        getExpGroup = 2
    Case "Nidorina"
        getExpGroup = 2
    Case "Nidoqueen"
        getExpGroup = 2
    Case "NidoranM"
        getExpGroup = 2
    Case "Nidorino"
        getExpGroup = 2
    Case "Nidoking"
        getExpGroup = 2
    Case "Clefairy"
        getExpGroup = 4
    Case "Clefable"
        getExpGroup = 4
    Case "Vulpix"
        getExpGroup = 3
    Case "Ninetales"
        getExpGroup = 3
    Case "Jigglypuff"
        getExpGroup = 4
    Case "Wigglytuff"
        getExpGroup = 4
    Case "Zubat"
        getExpGroup = 3
    Case "Golbat"
        getExpGroup = 3
    Case "Oddish"
        getExpGroup = 2
    Case "Gloom"
        getExpGroup = 2
    Case "Vileplume"
        getExpGroup = 2
    Case "Paras"
        getExpGroup = 3
    Case "Parasect"
        getExpGroup = 3
    Case "Venonat"
        getExpGroup = 3
    Case "Venomoth"
        getExpGroup = 3
    Case "Diglett"
        getExpGroup = 3
    Case "Dugtrio"
        getExpGroup = 3
    Case "Meowth"
        getExpGroup = 3
    Case "Persian"
        getExpGroup = 3
    Case "Psyduck"
        getExpGroup = 3
    Case "Golduck"
        getExpGroup = 3
    Case "Mankey"
        getExpGroup = 3
    Case "Primeape"
        getExpGroup = 3
    Case "Growlithe"
        getExpGroup = 1
    Case "Arcanine"
        getExpGroup = 1
    Case "Poliwag"
        getExpGroup = 2
    Case "Poliwhirl"
        getExpGroup = 2
    Case "Poliwrath"
        getExpGroup = 2
    Case "Abra"
        getExpGroup = 2
    Case "Kadabra"
        getExpGroup = 2
    Case "Alakazam"
        getExpGroup = 2
    Case "Machop"
        getExpGroup = 2
    Case "Machoke"
        getExpGroup = 2
    Case "Machamp"
        getExpGroup = 2
    Case "Bellsprout"
        getExpGroup = 2
    Case "Weepinbell"
        getExpGroup = 2
    Case "Victreebel"
        getExpGroup = 2
    Case "Tentacool"
        getExpGroup = 1
    Case "Tentacruel"
        getExpGroup = 1
    Case "Geodude"
        getExpGroup = 2
    Case "Graveler"
        getExpGroup = 2
    Case "Golem"
        getExpGroup = 2
    Case "Ponyta"
        getExpGroup = 3
    Case "Rapidash"
        getExpGroup = 3
    Case "Slowpoke"
        getExpGroup = 3
    Case "Slowbro"
        getExpGroup = 3
    Case "Magnemite"
        getExpGroup = 3
    Case "Magneton"
        getExpGroup = 3
    Case "Farfetch'd"
        getExpGroup = 3
    Case "Doduo"
        getExpGroup = 3
    Case "Dodrio"
        getExpGroup = 3
    Case "Seel"
        getExpGroup = 3
    Case "Dewgong"
        getExpGroup = 3
    Case "Grimer"
        getExpGroup = 3
    Case "Muk"
        getExpGroup = 3
    Case "Shellder"
        getExpGroup = 1
    Case "Cloyster"
        getExpGroup = 1
    Case "Gastly"
        getExpGroup = 2
    Case "Haunter"
        getExpGroup = 2
    Case "Gengar"
        getExpGroup = 2
    Case "Onix"
        getExpGroup = 3
    Case "Drowzee"
        getExpGroup = 3
    Case "Hypno"
        getExpGroup = 3
    Case "Krabby"
        getExpGroup = 3
    Case "Kingler"
        getExpGroup = 3
    Case "Voltorb"
        getExpGroup = 3
    Case "Electrode"
        getExpGroup = 3
    Case "Exeggcute"
        getExpGroup = 1
    Case "Exeggutor"
        getExpGroup = 1
    Case "Cubone"
        getExpGroup = 3
    Case "Marowak"
        getExpGroup = 3
    Case "Hitmonlee"
        getExpGroup = 3
    Case "Hitmonchan"
        getExpGroup = 3
    Case "Lickitung"
        getExpGroup = 3
    Case "Koffing"
        getExpGroup = 3
    Case "Weezing"
        getExpGroup = 3
    Case "Rhyhorn"
        getExpGroup = 1
    Case "Rhydon"
        getExpGroup = 1
    Case "Chansey"
        getExpGroup = 4
    Case "Tangela"
        getExpGroup = 3
    Case "Kangaskhan"
        getExpGroup = 3
    Case "Horsea"
        getExpGroup = 3
    Case "Seadra"
        getExpGroup = 3
    Case "Goldeen"
        getExpGroup = 3
    Case "Seaking"
        getExpGroup = 3
    Case "Staryu"
        getExpGroup = 1
    Case "Starmie"
        getExpGroup = 1
    Case "Mr. Mime"
        getExpGroup = 3
    Case "Scyther"
        getExpGroup = 3
    Case "Jynx"
        getExpGroup = 3
    Case "Electabuzz"
        getExpGroup = 3
    Case "Magmar"
        getExpGroup = 3
    Case "Pinsir"
        getExpGroup = 1
    Case "Tauros"
        getExpGroup = 1
    Case "Magikrap"
        getExpGroup = 1
    Case "Gyarados"
        getExpGroup = 1
    Case "Lapras"
        getExpGroup = 1
    Case "Ditto"
        getExpGroup = 3
    Case "Eevee"
        getExpGroup = 3
    Case "Vaporeon"
        getExpGroup = 3
    Case "Jolteon"
        getExpGroup = 3
    Case "Flareon"
        getExpGroup = 3
    Case "Porygon"
        getExpGroup = 3
    Case "Omanyte"
        getExpGroup = 3
    Case "Omastar"
        getExpGroup = 3
    Case "Kabuto"
        getExpGroup = 3
    Case "Kabutops"
        getExpGroup = 3
    Case "Aerodactyl"
        getExpGroup = 1
    Case "Snorlax"
        getExpGroup = 1
    Case "Articuno"
        getExpGroup = 1
    Case "Zapdos"
        getExpGroup = 1
    Case "Moltres"
        getExpGroup = 1
    Case "Dratini"
        getExpGroup = 1
    Case "Dragonair"
        getExpGroup = 1
    Case "Dragonite"
        getExpGroup = 1
    Case "Mewtwo"
        getExpGroup = 1
    Case "Mew"
        getExpGroup = 2
    Case Else
        getExpGroup = 0
    End Select
End Function

Private Function CheckPath(strPath As String) As Boolean
    If Dir$(strPath) <> "" Then
        CheckPath = True
    Else
        CheckPath = False
    End If
End Function
