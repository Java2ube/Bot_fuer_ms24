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
    Edit10: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure KI(VAR klassenstuffe: byte);
  private

  public

  end;

var
  Form1: TForm1;

implementation

Type tFeld = Array[1..24] of String;
     tGroesse = Array[0..4] of byte;
Var Feld: tFeld;
    Groesse: tGroesse;
    a,b,h, ks: byte;


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
VAR i, j,b, laenge, temp, quersummeB, m1, m2,m3,m4,m5, op1, op2, op3, op4,op5, ps1, ps2, ps3, ps4,ps5, entW: byte;
    quersummeS: string;
begin
     quersummeB:=0;

     op1:=0;
     op2:=0;
     op3:=0;
     op4:=0;
     op5:=0;

     ps1:=0;
     ps2:=0;
     ps3:=0;
     ps4:=0;
     ps5:=0;

     m1:=0;
     m2:=0;
     m3:=0;
     m4:=0;
     m5:=0;
     //Würfeln
     i:= random(12)+1;
     j:= random(12)+1;

     //Test
     //(*
     Edit6.text:=inttostr(i);
     Edit7.text:=inttostr(j);
     //*)

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
     end
     else
     //Quersumme wird errechnet
     begin
       quersummeS:=InttoStr(j*i);
       Edit8.text:=quersummeS;
       laenge:= Length(quersummeS);
       for b:= 1 to laenge do
       begin
         quersummeB:=quersummeB+StrtoInt(quersummeS[b]);
       end;
       if(Feld[quersummeB]='frei') or (Feld[quersummeB]='rot') then
       begin
         m5:=quersummeB;
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






     //Strategisch entscheiden welches die beste Option ist
     //desto näher man der Spiel Mitte ist desto besser
     abstandMitte(m1, op1);
     abstandMitte(m2, op2);
     abstandMitte(m3, op3);
     abstandMitte(m4, op4);
     abstandMitte(m5, op5);




     if (op1 <= op2) and (op1 <= op3) and (op1 <= op4) and (op1<=op5) then
     begin
          ps1:=ps1+2
     end
     else if (op2 <= op1) and (op2 <= op3) and (op2 <= op4) and (op2<=op5) then
     begin
          ps2:=ps2+2
     end
     else if (op3 <= op1) and (op3 <= op2) and (op3 <= op4) and (op3<=op5) then
     begin
          ps3:=ps3+2
     end
     else if (op4 <= op1) and (op4 <= op2) and (op4 <= op3) and (op4<=op5) then
     begin
          ps4:=ps4+2
     end
     else
     begin
          ps5:=ps5+2
     end;


   //Umgebung untersuchen, ob sich eine bessere Position dadurch ergibt
   umgebungUntersuchen(m1, ps1);
   umgebungUntersuchen(m2, ps2);
   umgebungUntersuchen(m3, ps3);
   umgebungUntersuchen(m4, ps4);
   umgebungUntersuchen(m5, ps5);


     Edit1.text:=IntToStr(ps1);
     Edit2.Text:=InttoStr(ps2);
     Edit3.Text:=InttoStr(ps3);
     Edit4.Text:=InttoStr(ps4);
     Edit5.Text:=InttoStr(ps5);

   //Sortiert den Array nach Größe


     //Auswertung der Punktsysteme
     if (ps1 > ps2) and (ps1 > ps3) and (ps1 > ps4) and (ps1 > ps5) and not(ps1=0) then
     begin
          if(Feld[m1]='frei') or (Feld[m1]='rot') then
          begin
          Feld[m1]:='blau';
          end;
          h:=h+1;
     end
     else if (ps2 > ps1) and (ps2 > ps3) and (ps2 > ps4) and (ps2 > ps5)and  not(ps2=0) then
     begin
          if(Feld[m2]='frei') or (Feld[m2]='rot') then
          begin
          Feld[m2]:='blau';
          end;
          h:=h+1;
     end
     else if (ps3 > ps1) and (ps3 > ps2) and (ps3 > ps4) and (ps3 > ps5) and not(ps3=0) then
     begin
          if(Feld[m3]='frei') or (Feld[m3]='rot') then
          begin
          Feld[m3]:='blau';
          end;
          h:=h+1;
     end
     else if (ps4 > ps1) and (ps4 > ps2) and (ps4 > ps3) and (ps4 > ps5) and not(ps4=0) then
     begin
          if(Feld[m4]='frei') or (Feld[m4]='rot') then
          begin
          Feld[m4]:='blau';
          end;
          h:=h+1;
     end
     else if (ps5 > ps1) and (ps5 > ps2) and (ps5 > ps3) and (ps5 > ps4) and not(ps5=0) then
     begin
          if(Feld[m5]='frei') or (Feld[m5]='rot') then
          begin
          Feld[m5]:='blau';
          end;
          h:=h+1;
     end;
     (*if(groesse[4]=ps1) then
     begin
       Feld[m1]:='blau';
       h:=h+1;
     end
     else if(groesse[4]=ps2) then
     begin
       Feld[m2]:='blau';
       h:=h+1;
     end
     else if(groesse[4]=ps3) then
     begin
       Feld[m3]:='blau';
       h:=h+1;
     end
     else if(groesse[4]=ps4) then
     begin
       Feld[m4]:='blau';
       h:=h+1;
     end
     else if(groesse[4]=ps5) then
     begin
       Feld[m5]:='blau';
       h:=h+1;
     end;  *)
     (*else if(ps1=ps2) or (ps1=ps3) or (ps1=ps4) or (ps1=ps5) and not(ps1=0) then
     begin
        entW:=random(5)+1;
        if(entW=1) then
        begin
             Feld[m1]:='blau';
             h:=h+1;
        end
        else if(entW=2) then
        begin
             Feld[m2]:='blau';
             h:=h+1;
        end
        else if(entW=3) then
        begin
             Feld[m3]:='blau';
            h:=h+1;
        end
        else if(entW=4) then
        begin
             Feld[m4]:='blau';
             h:=h+1;
        end
        else
        begin
             Feld[m5]:='blau';
             h:=h+1;
        end;
     end;        *)


     Edit9.text:=InttoStr(h);

end;

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
begin

  memo1.Clear;
  ks:=3;
  KI(ks);
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

  h:=0;
  randomize;
  for a:=1 to 24 do
    begin
    Feld[a]:='frei';
    end;
end;

end.

