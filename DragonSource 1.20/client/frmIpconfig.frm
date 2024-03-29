VERSION 5.00
Begin VB.Form frmIpconfig 
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Configure Server IP"
   ClientHeight    =   6000
   ClientLeft      =   135
   ClientTop       =   375
   ClientWidth     =   6000
   ControlBox      =   0   'False
   Icon            =   "frmIpconfig.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmIpconfig.frx":1CCA
   ScaleHeight     =   6000
   ScaleWidth      =   6000
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox TxtPort 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   480
      TabIndex        =   1
      Top             =   3120
      Width           =   3375
   End
   Begin VB.TextBox TxtIP 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   480
      TabIndex        =   0
      Top             =   2280
      Width           =   3375
   End
   Begin VB.Label PicCancel 
      BackStyle       =   0  'Transparent
      Caption         =   "Cancel"
      Height          =   255
      Left            =   5040
      TabIndex        =   5
      Top             =   5160
      Width           =   615
   End
   Begin VB.Label PicConfirm 
      BackStyle       =   0  'Transparent
      Caption         =   "Confirm"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   5160
      Width           =   615
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Enter Server IP"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   600
      TabIndex        =   3
      Top             =   2040
      Width           =   1095
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Enter Server Port"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   600
      TabIndex        =   2
      Top             =   2880
      Width           =   1095
   End
End
Attribute VB_Name = "frmIpconfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'##################################'
'##### MADE WITH DRAGONSOURCE #####'
'# http://www.source.draignet.com #'
'##################################'

Option Explicit

Private Sub Form_Load()
    Dim FileName As String
    FileName = App.Path & "\config.ini"
    TxtIP = ReadINI("IPCONFIG", "IP", FileName)
    TxtPort = ReadINI("IPCONFIG", "PORT", FileName)
    TxtIP.Text = ReadINI("IPCONFIG", "IP", FileName)
    TxtPort.Text = ReadINI("IPCONFIG", "PORT", FileName)
End Sub

Private Sub picCancel_Click()
    frmMainMenu.Visible = True
    frmIpconfig.Visible = False
End Sub

Private Sub picConfirm_Click()
    Dim IP, Port As String
    Dim fErr As Integer
    Dim Texto As String
        
    IP = TxtIP
    Port = Val(TxtPort)

    fErr = 0
    If fErr = 0 And Len(Trim(IP)) = 0 Then
        fErr = 1
        Call MsgBox("Please Fix The IP!", vbCritical, GAME_NAME)
        Exit Sub
    End If
    If fErr = 0 And Port <= 0 Then
        fErr = 1
        Call MsgBox("Please Fix The Port!", vbCritical, GAME_NAME)
        Exit Sub
    End If
    If fErr = 0 Then
        ' Gravar IP e Porta
        Call WriteINI("IPCONFIG", "IP", TxtIP.Text, (App.Path & "\config.ini"))
        Call WriteINI("IPCONFIG", "PORT", TxtPort.Text, (App.Path & "\config.ini"))
        'Call MenuState(MENU_STATE_IPCONFIG)
    End If
    frmMain.Socket.Close
    frmMain.Socket.RemoteHost = TxtIP.Text
    frmMain.Socket.RemotePort = TxtPort.Text
    frmMainMenu.Visible = True
    frmIpconfig.Visible = False
End Sub
