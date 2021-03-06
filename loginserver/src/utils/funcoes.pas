unit funcoes;

(*

Unit que contém funções básicas para tratamento de dados.

Organizado por:
Felipe de Souza Camargo(Kurama)

Sobre o funcionamento do código:
Sem muitas explicações.

Referências:
Sem referências no momento

*)

interface

uses SysUtils, windows, forms;

function wrapper(data: AnsiString; tamanho: Integer): ansistring;
function returnsize(what: ansistring): integer;
function stringtohex(data: ansistring): ansistring;
function space(txt: ansistring): string;
function gerarcodigo(): string;
function reversestring(s: string ): string;
function hextoascii(data: ansistring): ansistring;
function arraytostring(const a: array of char): ansistring;
procedure delay(dwmilliseconds: longint);

implementation

function wrapper(data: AnsiString; tamanho: Integer): ansistring;
var
  i: Integer;
  wrap: AnsiString;
begin
  wrap:='';
  for i:=1 to tamanho do begin
    if i<=Length(data) then
      wrap:=wrap+data[i]
    else
      wrap:=wrap+#$00;
  end;
  result:=wrap;
end;

function returnsize(what: ansistring): integer;
var
  ix: integer;
begin
asm
  mov eax, what
  mov ecx, dword [eax]
  mov dword ptr ds:[ix], ecx
end;
  result:=ix+4;
end;

function stringtohex(data: ansistring): ansistring;
var
  i, i2: integer;
  s: string;
begin
  i2 := 1;
  for i := 1 to length(data) do begin
    inc(i2);
    if i2 = 2 then begin
      s  := s + '';
      i2 := 1;
    end;
    s := s + inttohex(ord(data[i]), 2);
  end;
  result := s;
end;

function space(txt: ansistring): string;
var
  i: integer;
begin
  i := 3;
  result := copy(txt,0,2);
  while i <= length(txt) do begin
    result := result + ' ' +copy(txt,i,2);
    i := i+2;
  end;
end;

function gerarcodigo(): string;
const
  minc='abcdefg';
  numc='1234567890';
var
  p, q: integer;
  char, senha: ansistring;
  min, num: boolean;
begin
  char:='';
  min:= true;
  num:= true;
  if min then char:=char+minc;
  if num then char:=char+numc;
  for p:=1 to 7 do begin
    randomize;
    q:=random(length(char))+1;
    senha:=senha+char[q];
  end;
  result:=senha;
end;

function reversestring(s: string ): string;
var
  i  : integer;
  s2 : string;
begin
  s2 := '';
  i:=0;
  while i <= length(s) do begin
    s2:=s[ i-1] + s[ i] + s2;
  i:=i+2;
  end;
  result:=copy(s2,1,length(s2)-2);
end;

function hextoascii(data: ansistring): ansistring;
function hextoint(hex: ansistring): integer;
begin
  result := strtoint('$' + hex);
end;
var
  i : integer;
begin
  result := '';
  data := stringreplace(data,' ','',[rfreplaceall]);
  for i := 1 to length(data) do begin
    if i mod 2 <> 0 then
      result := result + chr(hextoint(copy(data,i,2)));
  end;
end;

function arraytostring(const a: array of char): ansistring;
begin
  setstring(result, pchar(@a[0]), length(a));
end;

procedure delay(dwmilliseconds: longint);
var
  istart, istop: dword;
begin
  istart:=gettickcount;
  repeat
	istop := gettickcount;
	application.processmessages;
	sleep(1);
  until (istop - istart) >= dwmilliseconds;
end;

end.
