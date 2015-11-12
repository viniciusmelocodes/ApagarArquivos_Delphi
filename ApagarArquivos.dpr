program ApagarArquivos;

uses
  Forms,
  untApagarArquivos in 'untApagarArquivos.pas' {FormApagarArquivos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormApagarArquivos, FormApagarArquivos);
  Application.Run;
end.
