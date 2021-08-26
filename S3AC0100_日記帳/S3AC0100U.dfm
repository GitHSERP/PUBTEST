object S3AC0100F: TS3AC0100F
  Tag = 1
  Left = 299
  Top = 177
  Width = 401
  Height = 292
  Caption = #26085#35352#24115
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object myPrintPanel: TAdvPanel
    Left = 8
    Top = 8
    Width = 377
    Height = 241
    Align = alCustom
    BevelOuter = bvNone
    Color = 16774120
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #26032#32048#26126#39636
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '1.7.6.0'
    AutoHideChildren = False
    BorderShadow = True
    BorderWidth = 1
    Caption.Color = clHighlight
    Caption.ColorTo = clBlue
    Caption.CloseColor = clBackground
    Caption.CloseButtonColor = clLime
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Verdana'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clBtnFace
    CollapsDelay = 0
    ColorTo = 16763534
    HoverColor = clBlack
    HoverFontColor = clBlack
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    FullHeight = 0
    object Label_SALDATE: TLMDLabel
      Left = 19
      Top = 30
      Width = 83
      Height = 19
      Bevel.Mode = bmCustom
      FontFX.LightColor = clWindow
      FontFX.Style = tdSunken
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      Options = []
      ParentFont = False
      Caption = #26085#26399#31684#22285#65306
    end
    object Label_SALTYPE: TLMDLabel
      Left = 19
      Top = 153
      Width = 83
      Height = 19
      Bevel.Mode = bmCustom
      FontFX.LightColor = clWindow
      FontFX.Style = tdSunken
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      Options = []
      ParentFont = False
      Visible = False
      Caption = #21934#25818#39006#21029#65306
    end
    object Label_DEPNO: TLMDLabel
      Left = 19
      Top = 65
      Width = 83
      Height = 19
      Bevel.Mode = bmCustom
      FontFX.LightColor = clWindow
      FontFX.Style = tdSunken
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      Options = []
      ParentFont = False
      Caption = #37096#12288#12288#38272#65306
    end
    object Label_CASENO: TLMDLabel
      Left = 19
      Top = 99
      Width = 83
      Height = 19
      Bevel.Mode = bmCustom
      FontFX.LightColor = clWindow
      FontFX.Style = tdSunken
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      Options = []
      ParentFont = False
      Caption = #26696#12288#12288#21029#65306
    end
    object Dlg_BILLTYPENO: TwwDBComboDlg
      Left = 104
      Top = 151
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDown
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      TabOrder = 7
      WordWrap = False
      UnboundDataType = wwDefault
      Visible = False
    end
    object Dlg_BILLTYPENO2: TwwDBComboDlg
      Left = 232
      Top = 151
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDown
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      TabOrder = 8
      WordWrap = False
      UnboundDataType = wwDefault
      Visible = False
    end
    object Dlg_DEPNO1: TwwDBComboDlg
      Left = 104
      Top = 63
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDown
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      TabOrder = 2
      WordWrap = False
      UnboundDataType = wwDefault
    end
    object Dlg_DEPNO2: TwwDBComboDlg
      Left = 232
      Top = 63
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDown
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      TabOrder = 3
      WordWrap = False
      UnboundDataType = wwDefault
    end
    object Dlg_CASENO1: TwwDBComboDlg
      Left = 104
      Top = 97
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDown
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      TabOrder = 4
      WordWrap = False
      UnboundDataType = wwDefault
    end
    object Dlg_CASENO2: TwwDBComboDlg
      Left = 232
      Top = 97
      Width = 121
      Height = 24
      ShowButton = True
      Style = csDropDown
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      TabOrder = 5
      WordWrap = False
      UnboundDataType = wwDefault
    end
    object DBDateTimePicker_SALDATE2: TwwDBDateTimePicker
      Left = 232
      Top = 28
      Width = 121
      Height = 24
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
    object DBDateTimePicker_SALDATE: TwwDBDateTimePicker
      Left = 104
      Top = 28
      Width = 121
      Height = 24
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ImeName = #20013#25991' ('#32321#39636') - Yahoo! '#22855#25705#36664#20837#27861
      ParentFont = False
      ShowButton = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 253
      Top = 178
      Width = 107
      Height = 29
      Cancel = True
      Caption = #38626#38283
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 11
      OnClick = BitBtn2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn1: TBitBtn
      Left = 19
      Top = 178
      Width = 105
      Height = 29
      Caption = #21015#21360
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 136
      Top = 178
      Width = 105
      Height = 29
      Caption = #22577#34920#35222#31383
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#32048#26126#39636
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Visible = False
      OnClick = BitBtn3Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object HTMLCheckBox1: THTMLCheckBox
      Left = 123
      Top = 138
      Width = 161
      Height = 23
      Alignment = taLeftJustify
      ButtonType = btClassic
      ButtonVertAlign = tlCenter
      Caption = #21482#21253#21547#24050#35387#35352#20659#31080
      ReturnIsTab = False
      TabOrder = 6
      Transparent = True
      Version = '1.5.1.2'
    end
  end
  object XPManifest1: TXPManifest
    Left = 336
    Top = 177
  end
  object SD: TSimpleDataSet
    Aggregates = <>
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 16
    Top = 152
  end
  object DOSMOVE1: TDOSMOVE
    Active = True
    Left = 289
    Top = 24
  end
end
