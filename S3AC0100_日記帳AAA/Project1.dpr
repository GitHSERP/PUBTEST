program Project1;

uses
  classes,
  Forms,
  S3AC0100U in 'S3AC0100U.pas' {S3AC0100F},
  MainReportU in '..\S3_Print\MainReportU.pas' {MainReportF},
  ReportParaU in '..\S3_Print\ReportParaU.pas' {ReportParaF};

// �L�o����

{$R *.res}

begin
  Application.Initialize;
  RegisterClass(TMainReportOpenObject);   // ����L�o����
  RegisterClass(TReportParaOpenObject);   // ����L�o����
  Application.CreateForm(TS3AC0100F, S3AC0100F);
  Application.Run;

end.
