unit untApagarArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, Mask, rxToolEdit, StdCtrls, ExtCtrls, ExtDlgs;

type
  TFormApagarArquivos = class(TForm)
    pnlApagarArquivos: TPanel;
    edtTipoArquivo: TLabeledEdit;
    lblListaDiretorios: TcxLabel;
    btnApagarArquivos: TButton;
    memHistoricoExclusao: TMemo;
    edtListaDiretorios: TEdit;
    Button1: TButton;
    otfdListaDiretorios: TOpenTextFileDialog;
    procedure btnApagarArquivosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);


  private

    slListaDiretorios: TStringList;

    procedure apagarArquivos(sDiretorioArquivos        : string;
                             sTipoArquivos             : string;
                             var iQtdeArquivosApagados : Integer);

    function lerArquivoListaDiretorios(sDiretorioArquivo: String): Boolean;

    function validarCampos: Boolean;
    { private declarations }

  public
    { public declarations }

  end;

var
  FormApagarArquivos: TFormApagarArquivos;

implementation

{$R *.dfm}

{ TFormApagarArquivos }

procedure TFormApagarArquivos.apagarArquivos(sDiretorioArquivos: string;
                                             sTipoArquivos: string;
                                             var iQtdeArquivosApagados: Integer);
var
  srSearchRec: TSearchRec;
  iPosicaoPrimeiroArquivo: Integer;
begin
  try
    iQtdeArquivosApagados   := 0;
    // Acrescenta uma barra "\"
    sDiretorioArquivos      := IncludeTrailingPathDelimiter(sDiretorioArquivos);
    // Procura pelo primeiro arquivo
    iPosicaoPrimeiroArquivo := FindFirst(sDiretorioArquivos + sTipoArquivos,
                                         faAnyFile,
                                         srSearchRec);

    while (iPosicaoPrimeiroArquivo = 0) do
    begin
      // Apaga o arquivo encontrado
      DeleteFile(sDiretorioArquivos + srSearchRec.Name);
      // Procura pelo próximo arquivo
      iPosicaoPrimeiroArquivo := FindNext(srSearchRec);
      // Acrescenta mais um na contagem de quantidade de arquivos apagados
      Inc(iQtdeArquivosApagados);
    end;

    // Fechar a pesquisa de arquivos a serem apagados
    FindClose(srSearchRec);

  except
    on E:Exception do
      MessageBox(Handle, PChar('Erro encontrado.' + sLineBreak + E.Message), 'Erro', MB_OK);
  end;
end;

procedure TFormApagarArquivos.btnApagarArquivosClick(Sender: TObject);
var
  i,
  iQtdeArquivosApagados,
  iTotalArquivosApagados : Integer;
  sTipoArquivo: String;
  sDiretorioArquivo: String;
begin
  if ((validarCampos) and
      (lerArquivoListaDiretorios(edtListaDiretorios.Text))) then
  begin
    iTotalArquivosApagados := 0;
    sTipoArquivo           := '*.' + edtTipoArquivo.Text;

    memHistoricoExclusao.Lines.Clear;
    Self.Refresh;
    memHistoricoExclusao.Lines.Add('Iniciando exclusão de arquivos. Hora de início: ' +
                                   FormatDateTime('hh:mm:ss', Now));

    for i := 0 to slListaDiretorios.Count -1 do
    begin
      sDiretorioArquivo := slListaDiretorios.Strings[i];

      apagarArquivos(sDiretorioArquivo, sTipoArquivo, iQtdeArquivosApagados);
      iTotalArquivosApagados := iTotalArquivosApagados + iQtdeArquivosApagados;

      if (iQtdeArquivosApagados > 0) then
        memHistoricoExclusao.Lines.Add(IntToStr(iQtdeArquivosApagados) +
                                       ' Arquivo(s) apagado(s) em ' + sDiretorioArquivo)
      else
        memHistoricoExclusao.Lines.Add('Nenhum Arquivo Encontrado em ' + sDiretorioArquivo);

    end;

    memHistoricoExclusao.Lines.Add('Fim de exclusão de arquivos. Hora de finalização: ' +
                                   FormatDateTime('hh:mm:ss', Now));

    if (iTotalArquivosApagados > 0) then
      memHistoricoExclusao.Lines.Add('Total de Arquivo(s) apagado(s): ' + IntToStr(iTotalArquivosApagados));
  end;
end;

procedure TFormApagarArquivos.Button1Click(Sender: TObject);
begin
  if (otfdListaDiretorios.Execute) then
    edtListaDiretorios.Text := otfdListaDiretorios.FileName;
end;

procedure TFormApagarArquivos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(slListaDiretorios);
end;

procedure TFormApagarArquivos.FormCreate(Sender: TObject);
begin
  if (slListaDiretorios = nil) then
    slListaDiretorios := TStringList.Create;
end;

function TFormApagarArquivos.lerArquivoListaDiretorios(sDiretorioArquivo: String): Boolean;
begin
  if (not FileExists(sDiretorioArquivo)) then
  begin
    MessageBox(Handle, 'Informe uma Lista de Diretórios válida.', 'Atenção', MB_OK);
    Result := False;
  end
  else
  begin
    slListaDiretorios.LoadFromFile(sDiretorioArquivo);
    Result := True;
  end;
end;

function TFormApagarArquivos.validarCampos: Boolean;
begin
  Result := True;

  if (Trim(edtListaDiretorios.Text) = '') then
  begin
    if (edtListaDiretorios.CanFocus) then
      edtListaDiretorios.SetFocus;

    MessageBox(Handle, 'O campo Lista de Diretórios precisa ser preenchido.', 'Atenção', MB_OK);
    Result := False;
    Exit;
  end;

  if (Trim(edtTipoArquivo.Text) = '') then
  begin
    if (edtTipoArquivo.CanFocus) then
      edtTipoArquivo.SetFocus;

    MessageBox(Handle, 'O campo Tipo de Arquivo precisa ser preenchido.', 'Atenção', MB_OK);
    Result := False;
    Exit;
  end;

  if (Length(edtTipoArquivo.Text) > 3) then
  begin
    if (edtTipoArquivo.CanFocus) then
      edtTipoArquivo.SetFocus;

    MessageBox(Handle, 'O campo Tipo de Arquivo não pode ser maior que 3 caracteres.', 'Atenção', MB_OK);
    Result := False;
    Exit;
  end;
end;

end.
