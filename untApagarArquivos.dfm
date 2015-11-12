object FormApagarArquivos: TFormApagarArquivos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Apagar Arquivos Por Tipo'
  ClientHeight = 414
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlApagarArquivos: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 414
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 120
    ExplicitTop = 200
    ExplicitWidth = 185
    ExplicitHeight = 41
    object edtTipoArquivo: TLabeledEdit
      Left = 12
      Top = 65
      Width = 121
      Height = 21
      EditLabel.Width = 75
      EditLabel.Height = 13
      EditLabel.Caption = 'Tipo de Arquivo'
      TabOrder = 2
    end
    object lblListaDiretorios: TcxLabel
      Left = 12
      Top = 8
      Caption = 'Lista de Diret'#243'rios'
      Style.Shadow = False
    end
    object btnApagarArquivos: TButton
      Left = 298
      Top = 65
      Width = 139
      Height = 22
      Caption = 'Apagar Arquivos'
      TabOrder = 3
      OnClick = btnApagarArquivosClick
    end
    object memHistoricoExclusao: TMemo
      Left = 0
      Top = 95
      Width = 449
      Height = 319
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Ubuntu Mono'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 4
      ExplicitLeft = 1
      ExplicitTop = 94
      ExplicitWidth = 419
    end
    object edtListaDiretorios: TEdit
      Left = 12
      Top = 25
      Width = 398
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 413
      Top = 25
      Width = 24
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object otfdListaDiretorios: TOpenTextFileDialog
    Filter = 'Arquivos de Texto (*.txt)|*.txt'
    InitialDir = 'C:\'
    Title = 'Localizar Lista de Diret'#243'rios'
    Left = 208
    Top = 48
  end
end
