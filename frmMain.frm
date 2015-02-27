VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PokeStats"
   ClientHeight    =   1290
   ClientLeft      =   195
   ClientTop       =   11550
   ClientWidth     =   10830
   ForeColor       =   &H00000000&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   86
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   722
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fraPokemon6 
      BackColor       =   &H00000000&
      Height          =   1335
      Left            =   9000
      TabIndex        =   20
      Top             =   0
      Width           =   1875
      Begin VB.Image imgPKMNStatus 
         Height          =   120
         Index           =   5
         Left            =   1080
         Picture         =   "frmMain.frx":0000
         Top             =   600
         Width           =   300
      End
      Begin VB.Image imgPKMN1BARexpFRAME 
         Height          =   75
         Index           =   5
         Left            =   0
         Picture         =   "frmMain.frx":0368
         Top             =   1160
         Width           =   975
      End
      Begin VB.Image imgPKMN1HPbarFrame 
         Height          =   120
         Index           =   5
         Left            =   0
         Picture         =   "frmMain.frx":06DE
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Shape Shape6 
         FillStyle       =   0  'Solid
         Height          =   255
         Index           =   5
         Left            =   720
         Top             =   2040
         Width           =   1575
      End
      Begin VB.Label lblPKMN1LVL 
         BackColor       =   &H00000000&
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   5
         Left            =   1245
         TabIndex        =   23
         Top             =   360
         Width           =   495
      End
      Begin VB.Image imgPKMN1HPbarRed 
         Height          =   45
         Index           =   5
         Left            =   240
         Picture         =   "frmMain.frx":0A8B
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarYellow 
         Height          =   45
         Index           =   5
         Left            =   240
         Picture         =   "frmMain.frx":0DDB
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarGREEN 
         Height          =   45
         Index           =   5
         Left            =   240
         Picture         =   "frmMain.frx":112B
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBlue 
         Height          =   45
         Index           =   5
         Left            =   240
         Picture         =   "frmMain.frx":147B
         Top             =   1175
         Width           =   720
      End
      Begin VB.Label lblPKMN1Nick 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "ZZZZZZZZZZ"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   5
         Left            =   885
         TabIndex        =   22
         Top             =   120
         Width           =   975
      End
      Begin VB.Label lblPKMN1LVLLabel 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Lvl:"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   5
         Left            =   885
         TabIndex        =   21
         Top             =   360
         Width           =   375
      End
      Begin VB.Image imgPKMN1HPbarGrey 
         Height          =   45
         Index           =   5
         Left            =   240
         Picture         =   "frmMain.frx":17C0
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBACK 
         Height          =   45
         Index           =   5
         Left            =   240
         Picture         =   "frmMain.frx":1B10
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1Sprite 
         Height          =   960
         Index           =   5
         Left            =   0
         Picture         =   "frmMain.frx":1E54
         Stretch         =   -1  'True
         Top             =   120
         Width           =   960
      End
   End
   Begin VB.Frame fraPokemon5 
      BackColor       =   &H00000000&
      Height          =   1335
      Left            =   7200
      TabIndex        =   16
      Top             =   0
      Width           =   1875
      Begin VB.Image imgPKMNStatus 
         Height          =   120
         Index           =   4
         Left            =   1080
         Picture         =   "frmMain.frx":2629
         Top             =   600
         Width           =   300
      End
      Begin VB.Image imgPKMN1BARexpFRAME 
         Height          =   75
         Index           =   4
         Left            =   0
         Picture         =   "frmMain.frx":2991
         Top             =   1160
         Width           =   975
      End
      Begin VB.Image imgPKMN1HPbarFrame 
         Height          =   120
         Index           =   4
         Left            =   0
         Picture         =   "frmMain.frx":2D07
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Label lblPKMN1LVLLabel 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Lvl:"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   4
         Left            =   885
         TabIndex        =   19
         Top             =   360
         Width           =   375
      End
      Begin VB.Label lblPKMN1Nick 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "ZZZZZZZZZZ"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   4
         Left            =   885
         TabIndex        =   18
         Top             =   120
         Width           =   975
      End
      Begin VB.Image imgPKMN1EXPbarBlue 
         Height          =   45
         Index           =   4
         Left            =   240
         Picture         =   "frmMain.frx":30B4
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1HPbarGREEN 
         Height          =   45
         Index           =   4
         Left            =   240
         Picture         =   "frmMain.frx":33F9
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarYellow 
         Height          =   45
         Index           =   4
         Left            =   240
         Picture         =   "frmMain.frx":3749
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarRed 
         Height          =   45
         Index           =   4
         Left            =   240
         Picture         =   "frmMain.frx":3A99
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Label lblPKMN1LVL 
         BackColor       =   &H00000000&
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   4
         Left            =   1245
         TabIndex        =   17
         Top             =   360
         Width           =   495
      End
      Begin VB.Shape Shape6 
         FillStyle       =   0  'Solid
         Height          =   255
         Index           =   4
         Left            =   720
         Top             =   2040
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarGrey 
         Height          =   45
         Index           =   4
         Left            =   240
         Picture         =   "frmMain.frx":3DE9
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBACK 
         Height          =   45
         Index           =   4
         Left            =   240
         Picture         =   "frmMain.frx":4139
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1Sprite 
         Height          =   960
         Index           =   4
         Left            =   0
         Picture         =   "frmMain.frx":447D
         Stretch         =   -1  'True
         Top             =   120
         Width           =   960
      End
   End
   Begin VB.Frame fraPokemon4 
      BackColor       =   &H00000000&
      Height          =   1335
      Left            =   5400
      TabIndex        =   12
      Top             =   0
      Width           =   1875
      Begin VB.Image imgPKMNStatus 
         Height          =   120
         Index           =   3
         Left            =   1080
         Picture         =   "frmMain.frx":4C52
         Top             =   600
         Width           =   300
      End
      Begin VB.Image imgPKMN1BARexpFRAME 
         Height          =   75
         Index           =   3
         Left            =   0
         Picture         =   "frmMain.frx":4FBA
         Top             =   1160
         Width           =   975
      End
      Begin VB.Image imgPKMN1HPbarFrame 
         Height          =   120
         Index           =   3
         Left            =   0
         Picture         =   "frmMain.frx":5330
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Shape Shape6 
         FillStyle       =   0  'Solid
         Height          =   255
         Index           =   2
         Left            =   720
         Top             =   2040
         Width           =   1575
      End
      Begin VB.Label lblPKMN1LVL 
         BackColor       =   &H00000000&
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   3
         Left            =   1245
         TabIndex        =   15
         Top             =   360
         Width           =   495
      End
      Begin VB.Image imgPKMN1HPbarRed 
         Height          =   45
         Index           =   3
         Left            =   240
         Picture         =   "frmMain.frx":56DD
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarYellow 
         Height          =   45
         Index           =   3
         Left            =   240
         Picture         =   "frmMain.frx":5A2D
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarGREEN 
         Height          =   45
         Index           =   3
         Left            =   240
         Picture         =   "frmMain.frx":5D7D
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBlue 
         Height          =   45
         Index           =   3
         Left            =   240
         Picture         =   "frmMain.frx":60CD
         Top             =   1175
         Width           =   720
      End
      Begin VB.Label lblPKMN1Nick 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "ZZZZZZZZZZ"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   3
         Left            =   885
         TabIndex        =   14
         Top             =   120
         Width           =   975
      End
      Begin VB.Label lblPKMN1LVLLabel 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Lvl:"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   3
         Left            =   885
         TabIndex        =   13
         Top             =   360
         Width           =   375
      End
      Begin VB.Image imgPKMN1EXPbarBACK 
         Height          =   45
         Index           =   3
         Left            =   240
         Picture         =   "frmMain.frx":6412
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1Sprite 
         Height          =   960
         Index           =   3
         Left            =   0
         Picture         =   "frmMain.frx":6756
         Stretch         =   -1  'True
         Top             =   120
         Width           =   960
      End
      Begin VB.Image imgPKMN1HPbarGrey 
         Height          =   45
         Index           =   3
         Left            =   240
         Picture         =   "frmMain.frx":6F2B
         Top             =   1080
         Width           =   1575
      End
   End
   Begin VB.Frame fraPokemon3 
      BackColor       =   &H00000000&
      Height          =   1335
      Left            =   3600
      TabIndex        =   8
      Top             =   0
      Width           =   1875
      Begin VB.Image imgPKMNStatus 
         Height          =   120
         Index           =   2
         Left            =   1080
         Picture         =   "frmMain.frx":727B
         Top             =   600
         Width           =   300
      End
      Begin VB.Image imgPKMN1BARexpFRAME 
         Height          =   75
         Index           =   2
         Left            =   0
         Picture         =   "frmMain.frx":75E3
         Top             =   1160
         Width           =   975
      End
      Begin VB.Image imgPKMN1HPbarFrame 
         Height          =   120
         Index           =   2
         Left            =   0
         Picture         =   "frmMain.frx":7959
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Label lblPKMN1LVLLabel 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Lvl:"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   2
         Left            =   885
         TabIndex        =   11
         Top             =   360
         Width           =   375
      End
      Begin VB.Label lblPKMN1Nick 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "ZZZZZZZZZZ"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   2
         Left            =   885
         TabIndex        =   10
         Top             =   120
         Width           =   975
      End
      Begin VB.Image imgPKMN1EXPbarBlue 
         Height          =   45
         Index           =   2
         Left            =   240
         Picture         =   "frmMain.frx":7D06
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1HPbarGREEN 
         Height          =   45
         Index           =   2
         Left            =   240
         Picture         =   "frmMain.frx":804B
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarYellow 
         Height          =   45
         Index           =   2
         Left            =   240
         Picture         =   "frmMain.frx":839B
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarRed 
         Height          =   45
         Index           =   2
         Left            =   240
         Picture         =   "frmMain.frx":86EB
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Label lblPKMN1LVL 
         BackColor       =   &H00000000&
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   2
         Left            =   1245
         TabIndex        =   9
         Top             =   360
         Width           =   495
      End
      Begin VB.Shape Shape6 
         FillStyle       =   0  'Solid
         Height          =   255
         Index           =   1
         Left            =   720
         Top             =   2040
         Width           =   1575
      End
      Begin VB.Image imgPKMN1Sprite 
         Height          =   960
         Index           =   2
         Left            =   0
         Picture         =   "frmMain.frx":8A3B
         Stretch         =   -1  'True
         Top             =   120
         Width           =   960
      End
      Begin VB.Image imgPKMN1HPbarGrey 
         Height          =   45
         Index           =   2
         Left            =   240
         Picture         =   "frmMain.frx":9210
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBACK 
         Height          =   45
         Index           =   2
         Left            =   240
         Picture         =   "frmMain.frx":9560
         Top             =   1175
         Width           =   720
      End
   End
   Begin VB.Frame fraPokemon2 
      BackColor       =   &H00000000&
      Height          =   1335
      Left            =   1800
      TabIndex        =   4
      Top             =   0
      Width           =   1875
      Begin VB.Image imgPKMNStatus 
         Height          =   120
         Index           =   1
         Left            =   1080
         Picture         =   "frmMain.frx":98A4
         Top             =   600
         Width           =   300
      End
      Begin VB.Image imgPKMN1BARexpFRAME 
         Height          =   75
         Index           =   1
         Left            =   0
         Picture         =   "frmMain.frx":9C0C
         Top             =   1160
         Width           =   975
      End
      Begin VB.Image imgPKMN1HPbarFrame 
         Height          =   120
         Index           =   1
         Left            =   0
         Picture         =   "frmMain.frx":9F82
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Shape Shape6 
         FillStyle       =   0  'Solid
         Height          =   255
         Index           =   0
         Left            =   720
         Top             =   2040
         Width           =   1575
      End
      Begin VB.Label lblPKMN1LVL 
         BackColor       =   &H00000000&
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   1
         Left            =   1245
         TabIndex        =   7
         Top             =   360
         Width           =   495
      End
      Begin VB.Image imgPKMN1HPbarRed 
         Height          =   45
         Index           =   1
         Left            =   240
         Picture         =   "frmMain.frx":A32F
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarYellow 
         Height          =   45
         Index           =   1
         Left            =   240
         Picture         =   "frmMain.frx":A67F
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarGREEN 
         Height          =   45
         Index           =   1
         Left            =   240
         Picture         =   "frmMain.frx":A9CF
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBlue 
         Height          =   45
         Index           =   1
         Left            =   240
         Picture         =   "frmMain.frx":AD1F
         Top             =   1175
         Width           =   720
      End
      Begin VB.Label lblPKMN1Nick 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "ZZZZZZZZZZ"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   1
         Left            =   885
         TabIndex        =   6
         Top             =   120
         Width           =   975
      End
      Begin VB.Label lblPKMN1LVLLabel 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Lvl:"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   1
         Left            =   885
         TabIndex        =   5
         Top             =   360
         Width           =   375
      End
      Begin VB.Image imgPKMN1HPbarGrey 
         Height          =   45
         Index           =   1
         Left            =   240
         Picture         =   "frmMain.frx":B064
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBACK 
         Height          =   45
         Index           =   1
         Left            =   240
         Picture         =   "frmMain.frx":B3B4
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1Sprite 
         Height          =   960
         Index           =   1
         Left            =   0
         Picture         =   "frmMain.frx":B6F8
         Stretch         =   -1  'True
         Top             =   120
         Width           =   960
      End
   End
   Begin VB.Frame fraPokemon1 
      BackColor       =   &H00000000&
      Height          =   1335
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1875
      Begin VB.Image imgPKMNStatus 
         Height          =   120
         Index           =   0
         Left            =   1080
         Picture         =   "frmMain.frx":BECD
         Top             =   600
         Width           =   300
      End
      Begin VB.Image imgPKMN1BARexpFRAME 
         Height          =   75
         Index           =   0
         Left            =   0
         Picture         =   "frmMain.frx":C235
         Top             =   1160
         Width           =   975
      End
      Begin VB.Shape Shape6 
         FillStyle       =   0  'Solid
         Height          =   255
         Index           =   3
         Left            =   720
         Top             =   2040
         Width           =   1575
      End
      Begin VB.Label lblPKMN1LVL 
         BackColor       =   &H00000000&
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   0
         Left            =   1245
         TabIndex        =   3
         Top             =   360
         Width           =   495
      End
      Begin VB.Image imgPKMN1HPbarFrame 
         Height          =   120
         Index           =   0
         Left            =   0
         Picture         =   "frmMain.frx":C5AB
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Image imgPKMN1EXPbarBlue 
         Height          =   45
         Index           =   0
         Left            =   240
         Picture         =   "frmMain.frx":C958
         Top             =   1175
         Width           =   720
      End
      Begin VB.Label lblPKMN1Nick 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "ZZZZZZZZZZ"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   0
         Left            =   885
         TabIndex        =   2
         Top             =   120
         Width           =   975
      End
      Begin VB.Label lblPKMN1LVLLabel 
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Lvl:"
         BeginProperty Font 
            Name            =   "Pokemon FireLeaf"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   0
         Left            =   885
         TabIndex        =   1
         Top             =   360
         Width           =   375
      End
      Begin VB.Image imgPKMN1HPbarGREEN 
         Height          =   45
         Index           =   0
         Left            =   240
         Picture         =   "frmMain.frx":CC9D
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarRed 
         Height          =   45
         Index           =   0
         Left            =   240
         Picture         =   "frmMain.frx":CFED
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1HPbarYellow 
         Height          =   45
         Index           =   0
         Left            =   240
         Picture         =   "frmMain.frx":D33D
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Image imgPKMN1EXPbarBACK 
         Height          =   45
         Index           =   0
         Left            =   240
         Picture         =   "frmMain.frx":D68D
         Top             =   1175
         Width           =   720
      End
      Begin VB.Image imgPKMN1Sprite 
         Height          =   960
         Index           =   0
         Left            =   0
         Picture         =   "frmMain.frx":D9D1
         Stretch         =   -1  'True
         Top             =   120
         Width           =   960
      End
      Begin VB.Image imgPKMN1HPbarGrey 
         Height          =   45
         Index           =   0
         Left            =   240
         Picture         =   "frmMain.frx":E1A6
         Top             =   1080
         Width           =   1575
      End
   End
   Begin VB.Timer timHPBarColour 
      Interval        =   1
      Left            =   0
      Top             =   480
   End
   Begin VB.Timer timFileReader 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   0
      Top             =   0
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   0
      Top             =   960
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Image Image6 
      Height          =   495
      Left            =   5640
      Stretch         =   -1  'True
      Top             =   6600
      Width           =   1215
   End
   Begin VB.Image Image5 
      Height          =   495
      Left            =   1800
      Stretch         =   -1  'True
      Top             =   6600
      Width           =   1215
   End
   Begin VB.Image Image4 
      Height          =   495
      Left            =   3360
      Stretch         =   -1  'True
      Top             =   5640
      Width           =   1215
   End
   Begin VB.Image Image3 
      Height          =   495
      Left            =   4800
      Stretch         =   -1  'True
      Top             =   6840
      Width           =   1215
   End
   Begin VB.Image Image2 
      Height          =   495
      Left            =   2400
      Stretch         =   -1  'True
      Top             =   6600
      Width           =   1215
   End
   Begin VB.Image Image1 
      Height          =   495
      Left            =   360
      Stretch         =   -1  'True
      Top             =   6600
      Width           =   1215
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim pkmnCur(5) As String
Dim pkmnCurHP(5) As Long
Dim pkmnMaxHP(5) As Long
Dim pkmnCurEXP(5) As Long
Dim pkmnMaxEXP(5) As Long
Dim pkmnStatus(5) As Long
Dim buffer As Long

Private Sub Form_Load()
    Dim I As Integer
    fraPokemon1.BorderStyle = 0
    fraPokemon2.BorderStyle = 0
    fraPokemon3.BorderStyle = 0
    fraPokemon4.BorderStyle = 0
    fraPokemon5.BorderStyle = 0
    fraPokemon6.BorderStyle = 0
    Me.BackColor = &H0
    For I = 0 To 5
        pkmnStatus(I) = 100
    Next

End Sub

Private Sub timFileReader_Timer()
    On Error GoTo timer_error
    Dim lines() As String
    Dim I As Integer
    lines = Split(LoadFile(CommonDialog1.FileName), vbCrLf)
    
    If UBound(lines) < 1 Then
        GoTo abort
    End If
    
    For I = 0 To 5
    'Pokemon i
    If pkmnCur(I) <> lines(0 + (9 * I)) Then
        imgPKMN1Sprite(I).Picture = LoadPicture(App.Path & "\sprites\" & lines(0 + (9 * I)) & ".gif")
        pkmnCur(I) = lines(0 + (9 * I))
    End If
    Debug.Print (pkmnCur(I))
    If pkmnCur(I) = "None" Then
        imgPKMN1HPbarGREEN(I).Width = 0
        imgPKMN1HPbarYellow(I).Width = 0
        imgPKMN1HPbarRed(I).Width = 0
        imgPKMN1HPbarGrey(I).Width = 735
        lblPKMN1Nick(I).Caption = ""
        pkmnCurHP(I) = 0
        pkmnMaxHP(I) = 0
        pkmnCurEXP(I) = 0
        pkmnMaxEXP(I) = 0
        imgPKMN1EXPbarBlue(I).Width = 0
        visbleState False, I
    Else
        visbleState True, I
        lblPKMN1Nick(I).Caption = lines(1 + (9 * I))
        lblPKMN1LVL(I).Caption = lines(4 + (9 * I))
        pkmnCurHP(I) = lines(2 + (9 * I))
        pkmnMaxHP(I) = lines(3 + (9 * I))
        
        If pkmnMaxHP(I) = 0 Then
            MsgBox "The problem was a 0 value of 'pkmnMaxHP' around line 60 in frmMain main timer"
            GoTo abort ' let's get the hell out of here
        End If
        
        buffer = ((pkmnCurHP(I) / pkmnMaxHP(I)) * 100) * 7.35 ' possible fault location
        If imgPKMN1HPbarGREEN(I).Width <> buffer Then
            imgPKMN1HPbarGREEN(I).Width = buffer
            imgPKMN1HPbarYellow(I).Width = buffer
            imgPKMN1HPbarRed(I).Width = buffer
            imgPKMN1HPbarGrey(I).Width = 735
        End If
        pkmnCurEXP(I) = lines(8 + (9 * I))
        pkmnMaxEXP(I) = expNeeded((lines(4 + (9 * I)) + 1), getExpGroup(lines(0 + (9 * I))))
        
        If pkmnMaxHP(I) = 0 Then
            MsgBox "The problem was a 0 value of 'pkmnMaxEXP' around line 70 in frmMain main timer"
            GoTo abort ' let's get the hell out of here
        End If
        
        buffer = ((pkmnCurEXP(I) / pkmnMaxEXP(I)) * 100) * 7.2 ' possible fault location
        If imgPKMN1EXPbarBlue(I).Width <> buffer Then
            imgPKMN1EXPbarBlue(I).Width = buffer
        End If
        If pkmnCurHP(I) > 0 Then
            If pkmnStatus(I) <> lines(5 + (9 * I)) Then
                pkmnStatus(I) = lines(5 + (9 * I))
                Select Case pkmnStatus(I)
                Case 3
                    imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\" & "SLP" & ".gif")
                Case 4
                    imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\" & "PSN" & ".gif")
                Case 5
                    imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\" & "BRN" & ".gif")
                Case 6
                    imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\" & "FRZ" & ".gif")
                Case 7
                    imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\" & "PAR" & ".gif")
                Case Else
                    imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\NIL.gif")
                End Select
            End If
        Else
            imgPKMNStatus(I).Picture = LoadPicture(App.Path & "\status\" & "FNT" & ".gif")
        End If
    End If
    Next
timer_error:

  If Err.Number > 0 Then
     MsgBox "Error " & Err.Number & " (" & Err.Description & ") in line " & Erl & _
            ", in main timer tick!"
  End If
abort:
End Sub

Public Function LoadFile(dFile As String) As String
    Dim ff As Integer
    On Error Resume Next
    ff = FreeFile
    Open dFile For Binary As #ff
        LoadFile = Space(LOF(ff))
        Get #ff, , LoadFile
    Close #ff
End Function

Private Sub timHPBarColour_Timer()
    Dim num As Long
    num = 735
    For I = 0 To 5
    If pkmnCur(I) = "None" Then
        imgPKMN1HPbarGREEN(I).Visible = False
        imgPKMN1HPbarYellow(I).Visible = False
        imgPKMN1HPbarRed(I).Visible = False
        imgPKMN1HPbarGrey(I).Visible = False
    Else
        imgPKMN1HPbarGrey(I).Visible = True
        If imgPKMN1HPbarGREEN(I).Width <= (num / 4) Then
            imgPKMN1HPbarGREEN(I).Visible = False
            imgPKMN1HPbarYellow(I).Visible = False
            imgPKMN1HPbarRed(I).Visible = True
        Else
            If imgPKMN1HPbarGREEN(I).Width <= (num / 2) Then
                imgPKMN1HPbarGREEN(I).Visible = False
                imgPKMN1HPbarYellow(I).Visible = True
                imgPKMN1HPbarRed(I).Visible = False
            Else
                imgPKMN1HPbarGREEN(I).Visible = True
                imgPKMN1HPbarYellow(I).Visible = False
                imgPKMN1HPbarRed(I).Visible = False
            End If
        End If
    End If
    Next
End Sub

Private Sub visbleState(ByVal tf As Boolean, ByVal I As Integer)
    imgPKMN1HPbarFrame(I).Visible = tf
    imgPKMN1Sprite(I).Visible = tf
    imgPKMN1BARexpFRAME(I).Visible = tf
    imgPKMN1EXPbarBlue(I).Visible = tf
    imgPKMN1EXPbarBACK(I).Visible = tf
    lblPKMN1LVLLabel(I).Visible = tf
    lblPKMN1LVL(I).Visible = tf
    imgPKMNStatus(I).Visible = tf
End Sub
