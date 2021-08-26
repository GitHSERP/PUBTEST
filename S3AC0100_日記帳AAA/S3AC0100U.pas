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
   // �s�[��  T�{��OpenObject �] SetVariant
   TS3AC0100OpenObject = Class(TIOpenForm)
   Public
      Procedure SetVariant(ObjectName, PropertyName: String; Value: Variant); Override; // ��J�ƭ�
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
      ReportForm: TForm; // ���S��Close
      MainReportName: String;
      CDS: TClientDataSet;
      XMASTER,HVOUCHER:String;

      Procedure SetVariant(ObjectName, PropertyName: String; Value: Variant); Override; // ��J�ƭ�
      Procedure SetObject(ObjectName, PropertyName: String; Obj: TObject); Override; // ��J����
   End;
Var
   S3AC0100F: TS3AC0100F;
   LoginPara: TLoginPara; //fred

Exports //fred
   LoginPara; //fred

Implementation

Const
   ProgramID = 'S3AC0100'; // �{���N��
   MasterName = 'HVOUHEAD'; // �D�n�W��
   KeyFieldName = 'BILLNO'; // �D�n���

   {$R *.dfm}

Procedure TS3AC0100OpenObject.SetVariant(ObjectName, PropertyName: String; Value: Variant); // ��J�ƭ�
Begin
   ObjectName := UpperCase(ObjectName);
   If ObjectName = UpperCase('FatherOpenFormClassName') Then Begin
      If PropertyName = 'UserReportFormClose' Then {// mainReportForm ����} Begin
         S3AC0100F.BitBtn3.Visible := False;
         //         S3AC0100F.BitBtn1.Visible:=True;
      End;
   End;
End;
//

Procedure TS3AC0100F.SetVariant(ObjectName, PropertyName: String; Value: Variant); // ��J�ƭ�
Begin
   ObjectName := UpperCase(ObjectName);
   If ObjectName = UpperCase('LocateData') Then Begin
      If Not Master_CDS.Locate(KeyFieldName, PropertyName, []) Then Begin
         LoginPara.Showmessage('�䤣�� ' + PropertyName);
      End;
   End;
End;

Procedure TS3AC0100F.SetObject(ObjectName, PropertyName: String; Obj: TObject); // ��J����
Begin
   ObjectName := UpperCase(ObjectName);
End;

Procedure TS3AC0100F.FormCreate(Sender: TObject);
Begin
   // ���ͳs�u����
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

   // ����MainReportForm
   If ReportForm <> Nil Then
      ReportForm := Nil;

   LoginPara.AutoFreeConnectWhenFormClose; // �������ճs�u
   Action := caFree; // ���n
End;

Procedure TS3AC0100F.FormShow(Sender: TObject);
Begin

   // ���ե� ----
   //myAccBegDate := StartOfAMonth(2006, 1);
   //myAccEndDate := EndOfAMonth(2006, 12);
   //myVouMustCheck := True;
   // -----------
   //Constraints.MaxHeight := 268;
   //Constraints.MaxWidth := 404;

   XMASTER := myXMASTERName ;
   HVOUCHER := myHVOUCHERName ;

   // �ˬd����
   GetCALCUTEPAPERByProgramID(LoginPara, ProgramID);

   LoginPara.AutoConnectWhenFormShow; // �O�_�}�Ҵ��ճs�u


   DEPART_SD := LoginPara.Use_SD('DEPART', False);
   BILLTYPE_SD := LoginPara.Use_SD('BILLTYPE', False);
   CASEITEM_SD := LoginPara.Use_SD('CASEITEM', False);


   DBComboDlgOnCustomDlg := TDBComboDlgOnCustomDlg.Create(Self);
   DBComboDlgOnCustomDlg.LoginPara := LoginPara;


   _CustomDlg(self As TForm ,ProgramID); //�}���ƥ�

   //Dlg_DEPNO2.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_CHECKM_DEPNO;
   //Dlg_DEPNO.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_CHECKM_DEPNO;
   //Dlg_BILLTYPENO.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_BILLTYPE_BILLTYPENO;
   //Dlg_BILLTYPENO2.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_BILLTYPE_BILLTYPENO;
   //Dlg_CASENO.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_SALESD_CASENO;
   //Dlg_CASENO2.OnCustomDlg := DBComboDlgOnCustomDlg.DLG_SALESD_CASENO;

   // �ˬd�_�l���
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
   AClass := GetClass('TMainReportOpenObject'); // Project1 �W���U
   If AClass <> Nil Then
      OpenForm := AClass.Create As TIOpenForm // �ϥΤ��� IOpenForm
   Else
      Exit;

   If MainReportName = '' Then
      ReportForm := Nil
   Else
      ReportForm := Self.FindComponent(MainReportName) As TForm; // �U�γ�����馳�S���s�b

   If ReportForm = Nil Then {// �S���U�γ������ �N�ͥX�@��} Begin
      // 2.�I�s�U�ΦC�L����-----------------------------------------
      OpenForm.SetObject('OpenOwnerForm', '', Self); // Create Form �B Owner �O���L
      ReportForm := OpenForm.GetObject('FORM', '') As TForm; // ReportForm.name �N�O�p��
      MainReportName := ReportForm.Name;
      OpenForm.SetObject('LoginPara', '', LoginPara);
   End Else Begin
      OpenForm.Free;
      ReportForm.BringToFront;
      Exit;
   End;

   If ReportForm <> Nil Then {// ��������� �N�i�ǳƸ�ƨ�Show} Begin

      xstr := 'SELECT ';
      xstr := xstr + ' M.VOUDATE AS "���"';
      xstr := xstr + ' ,M.BILLNO AS "�ǲ����X"';
      xstr := xstr + ' ,M.CODE AS "���O"';
      xstr := xstr + ' ,M.STATUS AS "���A"';
      xstr := xstr + ' ,D.ITEM AS "����"';
      xstr := xstr + ' ,D.ACCNO AS "��إN��"';
      xstr := xstr + ' ,D.ACCNAME AS "��ئW��"';
      xstr := xstr + ' ,D.DETACCNO AS "��H�N��"';
      xstr := xstr + ' ,D.DETNAME AS "��H�W��"';
      xstr := xstr + ' ,D.DESCRIP AS "�K�n"';
      xstr := xstr + ' ,D.DEPNO AS "����"';
      xstr := xstr + ' ,DP.NAME AS "�����W��"';
      xstr := xstr + ' ,D.CASENO AS "�M�קO"';
      xstr := xstr + ' ,CM.CASENAME AS "�M�צW��"';
      xstr := xstr + ' ,D.MONEYKIND AS "���O"';
      xstr := xstr + ' ,D.MONEYRATE AS "�ײv"';
      xstr := xstr + ' ,D.DAMOUNT AS "�ɤ���B"';
      xstr := xstr + ' ,D.CAMOUNT AS "�U����B"';
      xstr := xstr + ' ,D.SOURBILLNO AS "�ӷ��渹"';
      xstr := xstr + ' ,M.TPNO AS "�ǲ��ӷ�"';
      xstr := xstr + ' ,D.BILLNOTE AS "��ڳƵ�"';
      xstr := xstr + ' ,M.MARK AS "���O" ';
      xstr := xstr + ' FROM HVOUHEAD M , ' + HVOUCHER + ' D ';
      xstr := xstr + ' LEFT JOIN DEPART DP ON (D.DEPNO=DP.DEPNO) ';
      xstr := xstr + ' LEFT JOIN CASEITEM CM ON (D.CASENO=CM.CASENO) ';
      xstr := xstr + ' WHERE (M.DISKNO=D.DISKNO) AND M.VOUDATE>=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE.Date))
         + ' AND  M.VOUDATE<=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE2.Date));
      //����
      If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then
         xstr := xstr + ' AND D.DEPNO >=' + Quotedstr(TRIM(Dlg_DEPNO1.text)) + ' AND D.DEPNO <= ' + Quotedstr(TRIM(Dlg_DEPNO2.text));
      //�קO
      If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then
         xstr := xstr + ' AND D.CASENO >=' + Quotedstr(TRIM(Dlg_CASENO1.text)) + ' AND D.CASENO <= ' + Quotedstr(TRIM(Dlg_CASENO2.text));
      //�u�]�t�w���O
      if HTMLCheckBox1.Checked then
         xstr := xstr + ' AND M.MARK=''Y''  ';
      //�֩w
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


      // �{�����J --------------------
      QQ.SQL.Clear;
      xStr := ' Select ';
      xstr := xstr + ' M.VOUDATE AS "���"';
      xstr := xstr + ' ,M.BILLNO AS "�ǲ����X"';
      xstr := xstr + ' ,M.CODE AS "���O"';
      xstr := xstr + ' ,M.STATUS AS "���A"';
      xstr := xstr + ' ,D.ITEM AS "����"';
      xstr := xstr + ' ,D.ACCNO AS "��إN��"';
      xstr := xstr + ' ,D.ACCNAME AS "��ئW��"';
      xstr := xstr + ' ,D.DETACCNO AS "��H�N��"';
      xstr := xstr + ' ,D.DETNAME AS "��H�W��"';
      xstr := xstr + ' ,D.DESCRIP AS "�K�n"';
      xstr := xstr + ' ,D.DEPNO AS "����"';
      xstr := xstr + ' ,DP.NAME AS "�����W��"';
      xstr := xstr + ' ,D.CASENO AS "�M�קO"';
      xstr := xstr + ' ,CM.CASENAME AS "�M�צW��"';
      xstr := xstr + ' ,D.MONEYKIND AS "���O"';
      xstr := xstr + ' ,D.MONEYRATE AS "�ײv"';
      xstr := xstr + ' ,D.DAMOUNT AS "�ɤ���B"';
      xstr := xstr + ' ,D.CAMOUNT AS "�U����B"';
      xstr := xstr + ' ,D.SOURBILLNO AS "�ӷ��渹"';
      xstr := xstr + ' ,M.TPNO AS "�ǲ��ӷ�"';
      xstr := xstr + ' ,D.BILLNOTE As "��ڳƵ�" ';
      xstr := xstr + ' FROM HVOUHEAD M , ' + HVOUCHER + ' D ';
      xstr := xstr + ' LEFT JOIN DEPART DP ON (D.DEPNO=DP.DEPNO) ';
      xstr := xstr + ' LEFT JOIN CASEITEM CM ON (D.CASENO=CM.CASENO) ';
      xstr := xstr + ' WHERE (M.DISKNO=D.DISKNO ) AND M.CODE=''1''  ';
      xstr := xstr + ' And M.VOUDATE>=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE.Date))
         + ' AND  M.VOUDATE<=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE2.Date));
      //����
      If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then
         xstr := xstr + ' AND D.DEPNO >=' + Quotedstr(TRIM(Dlg_DEPNO1.text)) + ' AND D.DEPNO <= ' + Quotedstr(TRIM(Dlg_DEPNO2.text));
      //�קO
      If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then
         xstr := xstr + ' AND D.CASENO >=' + Quotedstr(TRIM(Dlg_CASENO1.text)) + ' AND D.CASENO <= ' + Quotedstr(TRIM(Dlg_CASENO2.text));
      //�֩w
      If myVouMustCheck Then
         xstr := xstr + ' AND M.STATUS=''1'' And Trim(M.CHKWHO)<>'''' ';
      xstr := xstr + ' Order by M.VOUDATE,M.BILLNO ';

      QQ.SQL.Clear;
      QQ.SQL.Add(xstr);
      QQ.Params.ParseSQL(xStr, True);
      QQ.Open;
      QQ.First;
      While Not QQ.Eof Do {// �h�i�Ȧs��} Begin
         If CDS.Locate('�ǲ����X;��إN��', VarArrayOf([QQ.FieldByName('�ǲ����X').AsString, myAccCashAccno]), []) Then Begin
            CDS.Edit;
            CDS.FieldByName('�ɤ���B').AsCurrency := CDS.FieldByName('�ɤ���B').AsCurrency
               + QQ.FIELDBYNAME('�U����B').AsCurrency;
         End Else Begin
            CDS.Append;
            CDS.FieldByName('���').AsDateTime := QQ.FieldByName('���').AsDateTime;
            CDS.FieldByName('�ǲ����X').AsString := QQ.FieldByName('�ǲ����X').AsString;
            CDS.FieldByName('���O').AsString := QQ.FieldByName('���O').AsString;
            CDS.FieldByName('���A').AsString := QQ.FieldByName('���A').AsString;
            CDS.FieldByName('����').AsInteger := 0;
            CDS.FieldByName('��إN��').AsString := myAccCashAccno;
            CDS.FieldByName('��ئW��').AsString := LoginPara.QueryString('Select ACCNAME FROM XMASTER Where ACCNO=:ACCNO And YY=:YY', [myAccCashAccno, LoginPara.FLoginYear]);
            CDS.FieldByName('�ӷ��渹').AsString := QQ.FIELDBYNAME('�ӷ��渹').AsString;
            CDS.FieldByName('�ǲ��ӷ�').AsString := QQ.FIELDBYNAME('�ǲ��ӷ�').AsString;
            CDS.FieldByName('��H�N��').AsString := QQ.FIELDBYNAME('��H�N��').AsString;
            CDS.FieldByName('��H�W��').AsString := QQ.FIELDBYNAME('��H�W��').AsString;
            CDS.FieldByName('�K�n').AsString := QQ.FIELDBYNAME('�K�n').AsString;
            CDS.FieldByName('����').AsString := QQ.FIELDBYNAME('����').AsString;
            CDS.FieldByName('�����W��').AsString := QQ.FIELDBYNAME('�����W��').AsString;
            CDS.FieldByName('�M�קO').AsString := QQ.FIELDBYNAME('�M�קO').AsString;
            CDS.FieldByName('�M�צW��').AsString := QQ.FIELDBYNAME('�M�צW��').AsString;
            CDS.FieldByName('���O').AsString := QQ.FIELDBYNAME('���O').AsString;
            CDS.FieldByName('�ײv').AsCurrency := QQ.FIELDBYNAME('�ײv').AsCurrency;
            CDS.FieldByName('�ɤ���B').AsCurrency := QQ.FIELDBYNAME('�U����B').AsCurrency;
            CDS.FieldByName('�U����B').AsCurrency := 0;
            CDS.FieldByName('��ڳƵ�').AsString := QQ.FIELDBYNAME('��ڳƵ�').AsString;
         End;
         CDS.Post;
         QQ.Next;
      End;
      QQ.Close;

      // �{����X --------------------
      QQ.SQL.Clear;
      xStr := ' Select ';
      xstr := xstr + ' M.VOUDATE AS "���"';
      xstr := xstr + ' ,M.BILLNO AS "�ǲ����X"';
      xstr := xstr + ' ,M.CODE AS "���O"';
      xstr := xstr + ' ,M.STATUS AS "���A"';
      xstr := xstr + ' ,D.ITEM AS "����"';
      xstr := xstr + ' ,D.ACCNO AS "��إN��"';
      xstr := xstr + ' ,D.ACCNAME AS "��ئW��"';
      xstr := xstr + ' ,D.DETACCNO AS "��H�N��"';
      xstr := xstr + ' ,D.DETNAME AS "��H�W��"';
      xstr := xstr + ' ,D.DESCRIP AS "�K�n"';
      xstr := xstr + ' ,D.DEPNO AS "����"';
      xstr := xstr + ' ,DP.NAME AS "�����W��"';
      xstr := xstr + ' ,D.CASENO AS "�M�קO"';
      xstr := xstr + ' ,CM.CASENAME AS "�M�צW��"';
      xstr := xstr + ' ,D.MONEYKIND AS "���O"';
      xstr := xstr + ' ,D.MONEYRATE AS "�ײv"';
      xstr := xstr + ' ,D.DAMOUNT AS "�ɤ���B"';
      xstr := xstr + ' ,D.CAMOUNT AS "�U����B"';
      xstr := xstr + ' ,D.SOURBILLNO AS "�ӷ��渹"';
      xstr := xstr + ' ,M.TPNO AS "�ǲ��ӷ�"';
      xstr := xstr + ' ,D.BILLNOTE As "��ڳƵ�"';
      xstr := xstr + ' FROM HVOUHEAD M , ' + HVOUCHER + ' D ';
      xstr := xstr + ' LEFT JOIN DEPART DP ON (D.DEPNO=DP.DEPNO) ';
      xstr := xstr + ' LEFT JOIN CASEITEM CM ON (D.CASENO=CM.CASENO) ';
      xstr := xstr + ' WHERE (M.DISKNO=D.DISKNO ) AND M.CODE=''2'' ';
      xstr := xstr + ' And M.VOUDATE>=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE.Date))
         + ' AND  M.VOUDATE<=' + Quotedstr(datetostrformat(DBDateTimePicker_SALDATE2.Date));
      //����
      If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then
         xstr := xstr + ' AND D.DEPNO >=' + Quotedstr(TRIM(Dlg_DEPNO1.text)) + ' AND D.DEPNO <= ' + Quotedstr(TRIM(Dlg_DEPNO2.text));
      //�קO
      If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then
         xstr := xstr + ' AND D.CASENO >=' + Quotedstr(TRIM(Dlg_CASENO1.text)) + ' AND D.CASENO <= ' + Quotedstr(TRIM(Dlg_CASENO2.text));
      //�֩w
      If myVouMustCheck Then
         xstr := xstr + ' AND M.STATUS=''1'' And Trim(M.CHKWHO)<>'''' ';
      xstr := xstr + ' Order by M.VOUDATE,M.BILLNO ';


      QQ.SQL.Clear;
      QQ.SQL.Add(xstr);
      QQ.Params.ParseSQL(xstr, True);
      QQ.Open;
      QQ.First;
      While Not QQ.Eof Do {// �h�i�Ȧs��} Begin
         If CDS.Locate('�ǲ����X;��إN��', VarArrayOf([QQ.FieldByName('�ǲ����X').AsString, myAccCashAccno]), []) Then Begin
            CDS.Edit;
            CDS.FieldByName('�U����B').AsCurrency := CDS.FieldByName('�U����B').AsCurrency
               + QQ.FIELDBYNAME('�ɤ���B').AsCurrency;
         End Else Begin
            CDS.Append;
            CDS.FieldByName('���').AsDateTime := QQ.FieldByName('���').AsDateTime;
            CDS.FieldByName('�ǲ����X').AsString := QQ.FieldByName('�ǲ����X').AsString;
            CDS.FieldByName('���O').AsString := QQ.FieldByName('���O').AsString;
            CDS.FieldByName('���A').AsString := QQ.FieldByName('���A').AsString;
            CDS.FieldByName('����').AsInteger := 9999;
            CDS.FieldByName('��إN��').AsString := myAccCashAccno;
            CDS.FieldByName('��ئW��').AsString := LoginPara.QueryString('Select ACCNAME FROM XMASTER Where ACCNO=:ACCNO And YY=:YY', [myAccCashAccno, LoginPara.FLoginYear]);
            CDS.FieldByName('��H�N��').AsString := QQ.FIELDBYNAME('��H�N��').AsString;
            CDS.FieldByName('��H�W��').AsString := QQ.FIELDBYNAME('��H�W��').AsString;
            CDS.FieldByName('�ӷ��渹').AsString := QQ.FIELDBYNAME('�ӷ��渹').AsString;
            CDS.FieldByName('�ǲ��ӷ�').AsString := QQ.FIELDBYNAME('�ǲ��ӷ�').AsString;
            CDS.FieldByName('�K�n').AsString := QQ.FIELDBYNAME('�K�n').AsString;
            CDS.FieldByName('����').AsString := QQ.FIELDBYNAME('����').AsString;
            CDS.FieldByName('�����W��').AsString := QQ.FIELDBYNAME('�����W��').AsString;
            CDS.FieldByName('�M�קO').AsString := QQ.FIELDBYNAME('�M�קO').AsString;
            CDS.FieldByName('�M�צW��').AsString := QQ.FIELDBYNAME('�M�צW��').AsString;
            CDS.FieldByName('���O').AsString := QQ.FIELDBYNAME('���O').AsString;
            CDS.FieldByName('�ײv').AsCurrency := QQ.FIELDBYNAME('�ײv').AsCurrency;
            CDS.FieldByName('�ɤ���B').AsCurrency := 0;
            CDS.FieldByName('�U����B').AsCurrency := QQ.FIELDBYNAME('�ɤ���B').AsCurrency;
            CDS.FieldByName('��ڳƵ�').asstring := QQ.FieldByName('��ڳƵ�').asstring;
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
      OpenForm.SetVariant('RepBeginDate', '', DBDateTimePicker_SALDATE.Date); //�_�l��
      OpenForm.SetVariant('RepEndDate', '', DBDateTimePicker_SALDATE2.Date); //������
      // ���n�L�A�|�X�{2���A������մN�|�L�X���� 991115 ����
      Unino := myGetRegTBU3Key(LoginPara);
      If Unino <> 'ks-17661665' Then Begin

         If (TRIM(Dlg_DEPNO1.Text) <> '') And (TRIM(Dlg_DEPNO2.Text) <> '') Then Begin
            Str2 := TRIM(Dlg_DEPNO1.Text) + ' ' + LoginPara.QueryString('Select NAME From DEPART WHERE DEPNO=:DEPNO ', [TRIM(Dlg_DEPNO1.Text)]);
            Str2 := Str2 + '-' + TRIM(Dlg_DEPNO2.Text) + ' ' + LoginPara.QueryString('Select NAME From DEPART WHERE DEPNO=:DEPNO ', [TRIM(Dlg_DEPNO2.Text)]);
            OpenForm.SetVariant('ConditionLabel1', '', '����:' + Str2);
         End;
         If (TRIM(Dlg_CASENO1.Text) <> '') And (TRIM(Dlg_CASENO2.Text) <> '') Then Begin
            Str2 := TRIM(Dlg_CASENO1.Text) + ' ' + LoginPara.QueryString('Select CASENAME From CASEITEM WHERE CASENO=:CASENO ', [TRIM(Dlg_CASENO1.Text)]);
            Str2 := Str2 + '-' + TRIM(Dlg_CASENO2.Text) + ' ' + LoginPara.QueryString('Select CASENAME From CASEITEM WHERE CASENO=:CASENO ', [TRIM(Dlg_CASENO2.Text)]);
            OpenForm.SetVariant('ConditionLabel2', '', '�קO:' + Str2);
         End;

      End;
      OpenForm.SetVariant('FatherOpenFormClassName', '', 'TS3AC0100OpenObject'); // �ǵ� MainReport �I�s�̤�className
      BitBtn3.Visible := True;
      OpenForm.Show; // �s�W �令 Show
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
   // ��s�D�e���� COMBOBOX
   PostMessage(Application.MainForm.Handle, HS_FORM_ACTIVE_UPDATECOMBO, 0, Self.Handle);

End;

Initialization
   RegisterClass(TS3AC0100F);
   RegisterClass(TS3AC0100OpenObject);
Finalization
   UnRegisterClass(TS3AC0100F);
   UnRegisterClass(TS3AC0100OpenObject);
End.
