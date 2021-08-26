program Project1;

uses
  classes,
  Forms,
  S3AC0100U in 'S3AC0100U.pas' {S3AC0100F},
  MainReportU in '..\S3_Print\MainReportU.pas' {MainReportF},
  ReportParaU in '..\S3_Print\ReportParaU.pas' {ReportParaF};

// 過濾條件

{$R *.res}

begin
  Application.Initialize;
  RegisterClass(TMainReportOpenObject);   // 報表過濾條件
  RegisterClass(TReportParaOpenObject);   // 報表過濾條件
  Application.CreateForm(TS3AC0100F, S3AC0100F);
  Application.Run;

end.
