Unit S3AC0100U;

Interface

Uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, co_func,Co_const, SqlExpr, DBClient, dxBar, SimpleDS,
   ActnList, DB, DosMove, dxBarExtItems, wwdblook, 
   ExtCtrls, S3A_Func, bcshahuo_fun,
   Wwdatsrc, LMDStorBase, LMDStorXMLVault, 
   LMDStorFormHook, LMDStorPropertiesStorage, Menus, AdvMenus,
   AdvPanel, Buttons,
   ComCtrls,CommPrint,
   wwcheckbox, wwdotdot, wwDBDlg, wwidlg, FMTBcd, 
   Mask, wwdbedit, wwDBDateTimePicker,
   LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
   LMDCustomParentPanel, LMDCustomGroupBox, LMDCustomButtonGroup,
   LMDCustomRadioGroup, LMDRadioGroup, LMDControl, LMDBaseControl,
   LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel, XPMan,
   Wwdbcomb, LMDCustomCheckGroup, LMDCheckGroup, LMDButtonControl,
   LMDCustomCheckBox, LMDCheckBox, LMDBackPanel, htmlbtns, StdCtrls;

Type
   // 新加的  T程序OpenObject 設 SetVariant
   TS3AC0100OpenObject = Class(TIOpenForm)
   Public
      Procedure SetVariant(ObjectName, PropertyName: String; Value: Variant); Override; // 填入數值
   End;
   //
   TS3AC0100F = Class(TIFormSetGet)
      BitBtn2: TBitBtn;
      BitBtn1: TBitBtn;
      DBDateTimePicker_SALDATE: TwwDBDateTimePicker;
      DBDateTimePicker_SALDATE2: TwwDBDateTimePicker;
      XPManifest1: TXPManifest;
    myPrintPanel: TAdvPanel;
      Label_SALDATE: TLMDLabel;
      Dlg_BILLTYPENO: TwwDBComboDlg;
      Dlg_BILLTYPENO2: TwwDBComboDlg;
    Dlg_DEPNO1: TwwDBComboDlg;
      Dlg_DEPNO2: TwwDBComboDlg;
      Label_SALTYPE: TLMDLabel;
      Label_DEPNO: TLMDLabel;
      Label_CASENO: TLMDLabel;
    Dlg_CASENO1: TwwDBComboDlg;
      Dlg_CASENO2: TwwDBComboDlg;
      SD: TSimpleDataSet;
      BitBtn3: TBitBtn;
    HTMLCheckBox1: THTMLCheckBox;
    DOSMOVE1: TDOSMOVE;
      Procedure FormCreate(Sender: TObject);
      Procedure FormShow(Sender: TObject);
      Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
      Procedure BitBtn1Click(Sender: TObject);
      Procedure BitBtn2Click(Sender: TObject);
      Procedure BitBtn3Click(Sender: TObject);
      Procedure FormActivate(Sender: TObject);
   Private
      { Private declarations }
   Public
      { Public declarations }
      DBComboDlgOnCustomDlg: TDBComboDlgOnCustomDlg;
      Master_CDS: TClientDataSet;
      DEPART_SD: TSimpleDataSet;
      BILLTYPE_SD: TSimpleDataSet;
      CASEITEM_SD: TSimpleDataSet;
      ReportForm: TForm; // 有沒有Close
      MainReportName: String;
      CDS: TClientDataSet;
      XMASTER,HVOUCHER:String;

      Procedure SetVariant(ObjectName, PropertyName: String; Value: Variant); Override; // 填入數值
      Procedure SetObject(ObjectName, PropertyName: String; Obj: TObject); Override; // 填入物件
   End;
Var
   S3AC0100F: TS3AC0100F;
   LoginPara: TLoginPara; //fred

Exports //fred
   LoginPara; //fred

Implementation

Const
   ProgramID = 'S3AC0100'; // 程式代號
   MasterName = 'HVOUHEAD'; // 主要名稱
   KeyFieldName = 'BILLNO'; // 主要欄位

   {$R *.dfm}

Procedure TS3AC0100OpenObject.SetVariant(ObjectName, PropertyName: String; Value: Variant); // 填入數值
Begin
   ObjectName := UpperCase(ObjectName);
   If ObjectName = UpperCase('FatherOpenFormClassName') Then Begin
      If PropertyName = 'UserReportFormClose' Then {// mainReportForm 關掉} Begin
         S3AC0100F.BitBtn3.Visible := False;
         //         S3AC0100F.BitBtn1.Visible:=True;
      End;
   End;
End;
//

Procedure TS3AC0100F.SetVariant(ObjectName, PropertyName: String; Value: Variant); // 填入數值
Begin
   ObjectName := UpperCase(ObjectName);
   If ObjectName = UpperCase('LocateData') Then Begin
      If Not Master_CDS.Locate(KeyFieldName, PropertyName, []) Then Begin
         LoginPara.Showmessage('找不到 ' + PropertyName);
      End;
   End;
End;

Procedure TS3AC0100F.SetObject(ObjectName, PropertyName: String; Obj: TObject); // 填入物件
Begin
   ObjectName := UpperCase(ObjectName);
End;

Procedure TS3AC0100F.FormCreate(Sender: TObject);
Begin
   // 產生連線物件
   LoginPara := AutoCreateLoginParaWhenFormCreate(Sender, TForm(S3AC0100F));
   Set_Print_Dialog_Style(self As TForm);
   //windowstate := wsNormal;
   //Position := poMainFormCenter;
   //BorderStyle := bsToolWindow; //bsDialog bsNone bsToolWindow

End;

Procedure TS3AC0100F.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
   LoginPara.Free_DataObj('BILLTYPE', TsimpleDataSet, False);
   LoginPara.Free_DataObj('DEPART', TsimpleDataSet, False);
   LoginPara.Free_DataObj('CASEITEM', TsimpleDataSet, False);

   FreeAndNil(CDS);

   // 關閉MainReportForm
   If ReportForm <> Nil Then
      ReportForm := Nil;

   LoginPara.AutoFreeConnectWhenFormClose; // 關閉測試連線
   Action := caFree; // 重要
End;

Procedure TS3AC0100F.FormShow(Sender: TObject);
Begin

   // 測試用 ----
   //myAccBegDate := StartOfAMonth(2006, 1);
   //myAccEndDate := EndOfAMonth(2006, 12);
   //myVouMustCheck := True;
   // -----------
   //Constraints.MaxHeight := 268;
   //Constraints.MaxWidth := 404;

   XMASTER := myXMASTERName ;
   HVOUCHER := myHVOUCHERName ;

   // 檢查報表
   GetCALCUTEPAPERByProgramID(LoginPara, ProgramID);

   LoginPara.AutoConnectWhenFormShow; // 是否開啟測試連線


   DEPART_SD := LoginPara.Use_SD('DEPART', False);
   BILLTYPE_SD := LoginPara.Use_SD('BILLTYPE', False);
   CASEITEM_SD := LoginPara.Use_SD('CASEITEM', False);


   DBComboDlgOnCustomDlg := TDBComboDlgOnCustomDlg.Create(Self);
   DBComboDlgOnCustomDlg.LoginPara := LoginPara;


   _CustomDlg(self As TForm ,ProgramID); //開窗事件

   //Dlg_DEPNO2.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_CHECKM_DEPNO;
   //Dlg_DEPNO.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_CHECKM_DEPNO;
   //Dlg_BILLTYPENO.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_BILLTYPE_BILLTYPENO;
   //Dlg_BILLTYPENO2.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_BILLTYPE_BILLTYPENO;
   //Dlg_CASENO.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_SALESD_CASENO;
   //Dlg_CASENO2.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_SALESD_CASENO;

   // 檢查起始日期
   DBDateTimePicker_SALDATE.Date := myAccBegDate;
   If myStartDate > myAccBegDate Then
      DBDateTimePicker_SALDATE.Date := myStartDate;
   DBDateTimePicker_SALDATE2.Date := myAccEndDate;

   MainReportName := '';

End;

Procedure TS3AC0100F.BitBtn1Click(Sender: TObject);
Var
   xstr, str2, Unino: String;
   AClass: TPersistentClass;
   OpenForm: TIOpenForm;
   QQ: TSQLQuery;
Begin
   AClass := GetClass('TMainReportOpenObject'); // Project1 上註冊
   If AClass <> Nil Then
      OpenForm := AClass.Create As TIOpenForm // 使用介面 IOpenForm
   Else
      Exit;

   If MainReportName = '' Then
      ReportForm := Nil
   Else
      ReportForm := Self.FindComponent(MainReportName) As TForm; // 萬用報表實體有沒有存在

   If ReportForm = Nil Then {// 沒有萬用報表實體 就生出一個} Begin
      // 2.呼叫萬用列印視窗-----------------------------------------
      OpenForm.SetObject('OpenOwnerForm', '', Self); // Create Form 且 Owner 是本尊
      ReportForm := OpenForm.GetObject('FORM', '') As TForm; // ReportForm.name 就是妳的
      MainReportName := ReportForm.Name;
      OpenForm.SetObject('LoginPara', '', LoginPara);
   End Else Begin
      OpenForm.Free;
      ReportForm.BringToFront;
      Exit;
   End;

   If ReportForm <> Nil Then {// 有報表實體 就可準備資料來Show} Begin

      xstr := 'SELECT ';
      xstr := xstr + ' M.VOUDATE AS "日期"';
      xstr := xstr + ' ,M.BILLNO AS "傳票號碼"';
      xstr := xstr + ' ,M.CODE AS "類別"';
      xstr := xstr + ' ,M.STATUS AS "狀態"';
      xstr := xstr + ' ,D.ITEM AS "項次"';
      xstr := xstr + ' ,D.ACCNO AS "科目代號"';
      xstr := xstr + ' ,D.ACCNAME AS "科目名稱"';
      xstr := xstr + ' ,D.DETACCNO AS "對象代號"';
      xstr := xstr + ' ,D.DETNAME AS "對象名稱"';
      xstr := xstr + ' ,D.DESCRIP AS "摘要"';
      xstr := xstr + ' ,D.DEPNO AS "部門"';
      xstr := xstr + ' ,DP.NAME AS "部門名稱"';
      xstr := xstr + ' ,D.CASENO AS "專案別"';
      xstr := xstr + ' ,CM.CASENAME AS "專案名稱"';
      xstr := xstr + ' ,D.MONEYKIND AS "幣別"';
      xstr := xstr + ' ,D.MONEYRATE AS "匯率"';
      xstr := xstr + ' ,D.DAMOUNT AS "借方金額"';
      xstr := xstr + ' ,D.CAMOUNT AS "貸方金額"';
      xstr := xstr + ' ,D.SOURBILLNO AS "來源單號"';
      xstr := xstr + ' ,M.TPNO AS "傳票來源"';
      xstr := xstr + ' ,D.BILLNOTE AS "單據備註"';
      xstr := xstr + ' ,M.MARK AS "註記" ';
      xstr := xstr + ' FROM HVOUHEAD M , ' + HVOUCHER + ' D ';
      xstr := xstr + ' LEFT JOIN DEPART DP ON (D.DEPNO=DP.DEPNO) ';
      xstr := xstr + ' LEFT JOIN CASEITEM CM ON (D.CASENO=CM.CASENO) ';
      xstr := xstr + ' WHERE (M.DISKNO=D.DISKNO) AND M.VOUDATE>=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE.Date))
         + ' AND  M.VOUDATE<=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE2.Date));
      //部門
      If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then
         xstr := xstr + ' AND D.DEPNO >=' + Quotedstr(TRIM(Dlg_DEPNO1.text)) + ' AND D.DEPNO <= ' + Quotedstr(TRIM(Dlg_DEPNO2.text));
      //案別
      If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then
         xstr := xstr + ' AND D.CASENO >=' + Quotedstr(TRIM(Dlg_CASENO1.text)) + ' AND D.CASENO <= ' + Quotedstr(TRIM(Dlg_CASENO2.text));
      //只包含已註記
      if HTMLCheckBox1.Checked then
         xstr := xstr + ' AND M.MARK=''Y''  ';
      //核定
      If myVouMustCheck Then
         xstr := xstr + ' AND M.STATUS=''1'' And Trim(M.CHKWHO)<>'''' ';
      xstr := xstr + ' Order by M.VOUDATE,M.BILLNO ';

      QQ := TSQLQuery.Create(self);
      QQ.SQLConnection := LoginPara.FSQLConnection2;
      QQ.Sql.Add(xStr);
      QQ.Params.ParseSQL(xstr, true);
      QQ.Open;
      CDS := TClientDataSet.Create(Self);
      CopyDataSetByName(QQ, CDS);


      // 現金收入 --------------------
      QQ.SQL.Clear;
      xStr := ' Select ';
      xstr := xstr + ' M.VOUDATE AS "日期"';
      xstr := xstr + ' ,M.BILLNO AS "傳票號碼"';
      xstr := xstr + ' ,M.CODE AS "類別"';
      xstr := xstr + ' ,M.STATUS AS "狀態"';
      xstr := xstr + ' ,D.ITEM AS "項次"';
      xstr := xstr + ' ,D.ACCNO AS "科目代號"';
      xstr := xstr + ' ,D.ACCNAME AS "科目名稱"';
      xstr := xstr + ' ,D.DETACCNO AS "對象代號"';
      xstr := xstr + ' ,D.DETNAME AS "對象名稱"';
      xstr := xstr + ' ,D.DESCRIP AS "摘要"';
      xstr := xstr + ' ,D.DEPNO AS "部門"';
      xstr := xstr + ' ,DP.NAME AS "部門名稱"';
      xstr := xstr + ' ,D.CASENO AS "專案別"';
      xstr := xstr + ' ,CM.CASENAME AS "專案名稱"';
      xstr := xstr + ' ,D.MONEYKIND AS "幣別"';
      xstr := xstr + ' ,D.MONEYRATE AS "匯率"';
      xstr := xstr + ' ,D.DAMOUNT AS "借方金額"';
      xstr := xstr + ' ,D.CAMOUNT AS "貸方金額"';
      xstr := xstr + ' ,D.SOURBILLNO AS "來源單號"';
      xstr := xstr + ' ,M.TPNO AS "傳票來源"';
      xstr := xstr + ' ,D.BILLNOTE As "單據備註" ';
      xstr := xstr + ' FROM HVOUHEAD M , ' + HVOUCHER + ' D ';
      xstr := xstr + ' LEFT JOIN DEPART DP ON (D.DEPNO=DP.DEPNO) ';
      xstr := xstr + ' LEFT JOIN CASEITEM CM ON (D.CASENO=CM.CASENO) ';
      xstr := xstr + ' WHERE (M.DISKNO=D.DISKNO ) AND M.CODE=''1''  ';
      xstr := xstr + ' And M.VOUDATE>=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE.Date))
         + ' AND  M.VOUDATE<=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE2.Date));
      //部門
      If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then
         xstr := xstr + ' AND D.DEPNO >=' + Quotedstr(TRIM(Dlg_DEPNO1.text)) + ' AND D.DEPNO <= ' + Quotedstr(TRIM(Dlg_DEPNO2.text));
      //案別
      If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then
         xstr := xstr + ' AND D.CASENO >=' + Quotedstr(TRIM(Dlg_CASENO1.text)) + ' AND D.CASENO <= ' + Quotedstr(TRIM(Dlg_CASENO2.text));
      //核定
      If myVouMustCheck Then
         xstr := xstr + ' AND M.STATUS=''1'' And Trim(M.CHKWHO)<>'''' ';
      xstr := xstr + ' Order by M.VOUDATE,M.BILLNO ';

      QQ.SQL.Clear;
      QQ.SQL.Add(xstr);
      QQ.Params.ParseSQL(xStr, True);
      QQ.Open;
      QQ.First;
      While Not QQ.Eof Do {// 搬進暫存檔} Begin
         If CDS.Locate('傳票號碼;科目代號', VarArrayOf([QQ.FieldByName('傳票號碼').AsString, myAccCashAccno]), []) Then Begin
            CDS.Edit;
            CDS.FieldByName('借方金額').AsCurrency := CDS.FieldByName('借方金額').AsCurrency
               + QQ.FIELDBYNAME('貸方金額').AsCurrency;
         End Else Begin
            CDS.Append;
            CDS.FieldByName('日期').AsDateTime := QQ.FieldByName('日期').AsDateTime;
            CDS.FieldByName('傳票號碼').AsString := QQ.FieldByName('傳票號碼').AsString;
            CDS.FieldByName('類別').AsString := QQ.FieldByName('類別').AsString;
            CDS.FieldByName('狀態').AsString := QQ.FieldByName('狀態').AsString;
            CDS.FieldByName('項次').AsInteger := 0;
            CDS.FieldByName('科目代號').AsString := myAccCashAccno;
            CDS.FieldByName('科目名稱').AsString := LoginPara.QueryString('Select ACCNAME FROM XMASTER Where ACCNO=:ACCNO And YY=:YY', [myAccCashAccno, LoginPara.FLoginYear]);
            CDS.FieldByName('來源單號').AsString := QQ.FIELDBYNAME('來源單號').AsString;
            CDS.FieldByName('傳票來源').AsString := QQ.FIELDBYNAME('傳票來源').AsString;
            CDS.FieldByName('對象代號').AsString := QQ.FIELDBYNAME('對象代號').AsString;
            CDS.FieldByName('對象名稱').AsString := QQ.FIELDBYNAME('對象名稱').AsString;
            CDS.FieldByName('摘要').AsString := QQ.FIELDBYNAME('摘要').AsString;
            CDS.FieldByName('部門').AsString := QQ.FIELDBYNAME('部門').AsString;
            CDS.FieldByName('部門名稱').AsString := QQ.FIELDBYNAME('部門名稱').AsString;
            CDS.FieldByName('專案別').AsString := QQ.FIELDBYNAME('專案別').AsString;
            CDS.FieldByName('專案名稱').AsString := QQ.FIELDBYNAME('專案名稱').AsString;
            CDS.FieldByName('幣別').AsString := QQ.FIELDBYNAME('幣別').AsString;
            CDS.FieldByName('匯率').AsCurrency := QQ.FIELDBYNAME('匯率').AsCurrency;
            CDS.FieldByName('借方金額').AsCurrency := QQ.FIELDBYNAME('貸方金額').AsCurrency;
            CDS.FieldByName('貸方金額').AsCurrency := 0;
            CDS.FieldByName('單據備註').AsString := QQ.FIELDBYNAME('單據備註').AsString;
         End;
         CDS.Post;
         QQ.Next;
      End;
      QQ.Close;

      // 現金支出 --------------------
      QQ.SQL.Clear;
      xStr := ' Select ';
      xstr := xstr + ' M.VOUDATE AS "日期"';
      xstr := xstr + ' ,M.BILLNO AS "傳票號碼"';
      xstr := xstr + ' ,M.CODE AS "類別"';
      xstr := xstr + ' ,M.STATUS AS "狀態"';
      xstr := xstr + ' ,D.ITEM AS "項次"';
      xstr := xstr + ' ,D.ACCNO AS "科目代號"';
      xstr := xstr + ' ,D.ACCNAME AS "科目名稱"';
      xstr := xstr + ' ,D.DETACCNO AS "對象代號"';
      xstr := xstr + ' ,D.DETNAME AS "對象名稱"';
      xstr := xstr + ' ,D.DESCRIP AS "摘要"';
      xstr := xstr + ' ,D.DEPNO AS "部門"';
      xstr := xstr + ' ,DP.NAME AS "部門名稱"';
      xstr := xstr + ' ,D.CASENO AS "專案別"';
      xstr := xstr + ' ,CM.CASENAME AS "專案名稱"';
      xstr := xstr + ' ,D.MONEYKIND AS "幣別"';
      xstr := xstr + ' ,D.MONEYRATE AS "匯率"';
      xstr := xstr + ' ,D.DAMOUNT AS "借方金額"';
      xstr := xstr + ' ,D.CAMOUNT AS "貸方金額"';
      xstr := xstr + ' ,D.SOURBILLNO AS "來源單號"';
      xstr := xstr + ' ,M.TPNO AS "傳票來源"';
      xstr := xstr + ' ,D.BILLNOTE As "單據備註"';
      xstr := xstr + ' FROM HVOUHEAD M , ' + HVOUCHER + ' D ';
      xstr := xstr + ' LEFT JOIN DEPART DP ON (D.DEPNO=DP.DEPNO) ';
      xstr := xstr + ' LEFT JOIN CASEITEM CM ON (D.CASENO=CM.CASENO) ';
      xstr := xstr + ' WHERE (M.DISKNO=D.DISKNO ) AND M.CODE=''2'' ';
      xstr := xstr + ' And M.VOUDATE>=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE.Date))
         + ' AND  M.VOUDATE<=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE2.Date));
      //部門
      If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then
         xstr := xstr + ' AND D.DEPNO >=' + Quotedstr(TRIM(Dlg_DEPNO1.text)) + ' AND D.DEPNO <= ' + Quotedstr(TRIM(Dlg_DEPNO2.text));
      //案別
      If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then
         xstr := xstr + ' AND D.CASENO >=' + Quotedstr(TRIM(Dlg_CASENO1.text)) + ' AND D.CASENO <= ' + Quotedstr(TRIM(Dlg_CASENO2.text));
      //核定
      If myVouMustCheck Then
         xstr := xstr + ' AND M.STATUS=''1'' And Trim(M.CHKWHO)<>'''' ';
      xstr := xstr + ' Order by M.VOUDATE,M.BILLNO ';


      QQ.SQL.Clear;
      QQ.SQL.Add(xstr);
      QQ.Params.ParseSQL(xstr, True);
      QQ.Open;
      QQ.First;
      While Not QQ.Eof Do {// 搬進暫存檔} Begin
         If CDS.Locate('傳票號碼;科目代號', VarArrayOf([QQ.FieldByName('傳票號碼').AsString, myAccCashAccno]), []) Then Begin
            CDS.Edit;
            CDS.FieldByName('貸方金額').AsCurrency := CDS.FieldByName('貸方金額').AsCurrency
               + QQ.FIELDBYNAME('借方金額').AsCurrency;
         End Else Begin
            CDS.Append;
            CDS.FieldByName('日期').AsDateTime := QQ.FieldByName('日期').AsDateTime;
            CDS.FieldByName('傳票號碼').AsString := QQ.FieldByName('傳票號碼').AsString;
            CDS.FieldByName('類別').AsString := QQ.FieldByName('類別').AsString;
            CDS.FieldByName('狀態').AsString := QQ.FieldByName('狀態').AsString;
            CDS.FieldByName('項次').AsInteger := 9999;
            CDS.FieldByName('科目代號').AsString := myAccCashAccno;
            CDS.FieldByName('科目名稱').AsString := LoginPara.QueryString('Select ACCNAME FROM XMASTER Where ACCNO=:ACCNO And YY=:YY', [myAccCashAccno, LoginPara.FLoginYear]);
            CDS.FieldByName('對象代號').AsString := QQ.FIELDBYNAME('對象代號').AsString;
            CDS.FieldByName('對象名稱').AsString := QQ.FIELDBYNAME('對象名稱').AsString;
            CDS.FieldByName('來源單號').AsString := QQ.FIELDBYNAME('來源單號').AsString;
            CDS.FieldByName('傳票來源').AsString := QQ.FIELDBYNAME('傳票來源').AsString;
            CDS.FieldByName('摘要').AsString := QQ.FIELDBYNAME('摘要').AsString;
            CDS.FieldByName('部門').AsString := QQ.FIELDBYNAME('部門').AsString;
            CDS.FieldByName('部門名稱').AsString := QQ.FIELDBYNAME('部門名稱').AsString;
            CDS.FieldByName('專案別').AsString := QQ.FIELDBYNAME('專案別').AsString;
            CDS.FieldByName('專案名稱').AsString := QQ.FIELDBYNAME('專案名稱').AsString;
            CDS.FieldByName('幣別').AsString := QQ.FIELDBYNAME('幣別').AsString;
            CDS.FieldByName('匯率').AsCurrency := QQ.FIELDBYNAME('匯率').AsCurrency;
            CDS.FieldByName('借方金額').AsCurrency := 0;
            CDS.FieldByName('貸方金額').AsCurrency := QQ.FIELDBYNAME('借方金額').AsCurrency;
            CDS.FieldByName('單據備註').asstring := QQ.FieldByName('單據備註').asstring;
         End;
         CDS.Post;
         QQ.Next;
      End;
      QQ.Close;

      OpenForm.SetObject('OUTPUTDATA', '', CDS);
      OpenForm.SetVariant('ParamFileName', '', ProgramID);

      OpenForm.SetVariant('RMReport1', 'NewReport', False); //
      OpenForm.SetVariant('RMReport1', 'MDIPreview', False);
      OpenForm.SetVariant('RMReport1', 'ModalPreview', False);
      OpenForm.SetVariant('RepBeginDate', '', DBDateTimePicker_SALDATE.Date); //起始日
      OpenForm.SetVariant('RepEndDate', '', DBDateTimePicker_SALDATE2.Date); //結束日
      // 不要印，會出現2次，報表分組就會印出部門 991115 高雄
      Unino := myGetRegTBU3Key(LoginPara);
      If Unino <> 'ks-17661665' Then Begin

         If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then Begin
            Str2 := TRIM(Dlg_DEPNO1.Text) + ' ' + LoginPara.QueryString('Select NAME From DEPART WHERE DEPNO=:DEPNO ', [TRIM(Dlg_DEPNO1.Text)]);
            Str2 := Str2 + '-' + TRIM(Dlg_DEPNO2.Text) + ' ' + LoginPara.QueryString('Select NAME From DEPART WHERE DEPNO=:DEPNO ', [TRIM(Dlg_DEPNO2.Text)]);
            OpenForm.SetVariant('ConditionLabel1', '', '部門:' + Str2);
         End;
         If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then Begin
            Str2 := TRIM(Dlg_CASENO1.Text) + ' ' + LoginPara.QueryString('Select CASENAME From CASEITEM WHERE CASENO=:CASENO ', [TRIM(Dlg_CASENO1.Text)]);
            Str2 := Str2 + '-' + TRIM(Dlg_CASENO2.Text) + ' ' + LoginPara.QueryString('Select CASENAME From CASEITEM WHERE CASENO=:CASENO ', [TRIM(Dlg_CASENO2.Text)]);
            OpenForm.SetVariant('ConditionLabel2', '', '案別:' + Str2);
         End;

      End;
      OpenForm.SetVariant('FatherOpenFormClassName', '', 'TS3AC0100OpenObject'); // 傳給 MainReport 呼叫者之className
      BitBtn3.Visible := True;
      OpenForm.Show; // 新增 改成 Show
   End;
   OpenForm.Free;
End;

Procedure TS3AC0100F.BitBtn2Click(Sender: TObject);
Begin
   SD.Close;
   close;
End;


Procedure TS3AC0100F.BitBtn3Click(Sender: TObject);
Begin
   ReportForm.BringToFront;
End;

Procedure TS3AC0100F.FormActivate(Sender: TObject);
Begin
   // 更新主畫面的 COMBOBOX
   PostMessage(Application.MainForm.Handle, HS_FORM_ACTIVE_UPDATECOMBO, 0, Self.Handle);

End;

Initialization
   RegisterClass(TS3AC0100F);
   RegisterClass(TS3AC0100OpenObject);
Finalization
   UnRegisterClass(TS3AC0100F);
   UnRegisterClass(TS3AC0100OpenObject);
End.
