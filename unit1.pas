unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure KI();
  private

  public

  end;

var
  Form1: TForm1;

implementation

Type tFeld = Array[1..24] of String;
Var Feld: tFeld;
    a,b: byte;


{$R *.lfm}


procedure umgebungUntersuchen(Var m, ps: byte);
begin
  //Feld zwischen 2 und 23 untersuchen
  if((m>=2) and (m<=23)) then
   begin
     if((Feld[m+1]='rot') or (Feld[m-1]='rot') or (Feld[m+1]='blau') or (Feld[m-1]='blau')) then
     begin
        ps:=ps+1;
     end;
   end;
  //Feld 1 untersuchen
   if(m<2) then
   begin
     if(Feld[m+1]='rot') or (Feld[m+1]='blau') then
     begin
        ps:=ps+1;
     end;
   end;
   //Feld 24 untersuchen
   if(m>23) then
   begin
     if(Feld[m-1]='rot') or (Feld[m-1]='blau') then
     begin
        ps:=ps+1;
     end;
   end;
end;

procedure abstandMitte(Var m, op: byte);
begin
   if(m < 12) then
     begin
        op:=12-m;
     end
     else
     begin
        op:=m-12
     end;
end;

procedure TForm1.KI(VAR klassenstuffe: byte);
VAR i, j, m1, m2,m3,m4, op1, op2, op3, op4, ps1, ps2, ps3, ps4, entW: byte;
begin
     op1:=0;
     op2:=0;
     op3:=0;
     op4:=0;

     ps1:=0;
     ps2:=0;
     ps3:=0;
     ps4:=0;

     m1:=0;
     m2:=0;
     m3:=0;
     m4:=0;
     //Würfeln
     i:= random(12)+1;
     j:= random(12)+1;

     //Mögliche Optionen untersuchen
     //Addition immer möglich solange es frei oder blau ist das Feld
     if(Feld[j+i] = 'frei') or (Feld[j+i] = 'rot') then
     begin
       m1:=j+i;
     end;

     //Multiplikation und Division
     //erst ab der 3. Klasse
     if(klassenstuffe>2) then
     begin
     if((j*i)<=24) then
     begin
       if(Feld[j*i]='frei') or (Feld[j*i]='rot') then
       begin
         m3:=j*i;
       end;
     end;
     if(i>=j) then
     begin
       if((i mod j) = 0) then
       begin
          if(Feld[i div j]='frei') or (Feld[i div j]='rot') then
           begin
                m4:=i div j;
           end;
       end;
     end
     else
     begin
       if((j mod i) = 0) then
       begin
          if(Feld[j div i]='frei') or (Feld[j div i]='rot') then
           begin
                m4:=j div i;
           end;
       end;
     end;
     end;


     //Subtration darf nicht null sein oder eine negative Zahl
     if(i>=j) then
     begin
        if not((i-j) <=  0) then
        begin
          if(Feld[i-j]='frei') or (Feld[i-j]='rot') then
           begin
                m2:=i-j;
           end;
        end;
     end
     else
     begin
       if not((j-i) <= 0) then
        begin
          if(Feld[j-i]='frei') or (Feld[j-i]='rot') then
           begin
                m2:=j-i;
           end;
        end;
     end;

     //Test
     //Edit1.text:=IntToStr(m1);
     //Edit2.Text:=InttoStr(m2);
     //Edit3.Text:=InttoStr(m3);
     //Edit4.Text:=InttoStr(m4);



     //Strategisch entscheiden welches die beste Option ist
     //desto näher man der Spiel Mitte ist desto besser
     abstandMitte(m1, op1);
     abstandMitte(m2, op2);
     abstandMitte(m3, op3);
     abstandMitte(m4, op4);




     if (op1 <= op2) and (op1 <= op3) and (op1 <= op4) then
     begin
          ps1:=ps1+1
     end
     else if (op2 <= op1) and (op2 <= op3) and (op2 <= op4) then
     begin
          ps2:=ps2+1
     end
     else if (op3 <= op1) and (op3 <= op2) and (op3 <= op4) then
     begin
          ps3:=ps3+1
     end
     else
     begin
          ps4:=ps4+1
     end;


   //Umgebung untersuchen, ob sich eine bessere Position dadurch ergibt
   umgebungUntersuchen(m1, ps1);
   umgebungUntersuchen(m2, ps2);
   umgebungUntersuchen(m3, ps3);
   umgebungUntersuchen(m4, ps4);


     //Auswertung der Punktsysteme
     if (ps1 >= ps2) and (ps1 >= ps3) and (ps1 >= ps4) then
     begin
          Feld[m1]:='blau';
     end
     else if (ps2 >= ps1) and (ps2 >= ps3) and (ps2 >= ps4) then
     begin
          Feld[m2]:='blau';
     end
     else if (ps3 >= ps1) and (ps3 >= ps2) and (ps3 >= ps4) then
     begin
          Feld[m3]:='blau';
     end
     else
     begin
          Feld[m4]:='blau';
     end;
     if(ps1=ps2) and (ps1=ps3) and (ps1=ps4) then
     begin
        entW:=random(4)+1;
        if(entW=1) then
        begin
             Feld[m1]:='blau';
        end
        else if(entW=2) then
        begin
             Feld[m2]:='blau';
        end
        else if(entW=3) then
        begin
             Feld[m3]:='blau';
        end
        else
        begin
             Feld[m4]:='blau';
        end;

     end;


end;

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
begin
  memo1.Clear;

  KI();
  for b:=1 to 24 do
  begin
    memo1.Lines.add(Feld[b]);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  randomize;
  for a:=1 to 24 do
    begin
    Feld[a]:='frei';
    end;
end;

end.

