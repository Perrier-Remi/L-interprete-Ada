with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure tri_tableau is
    type T_Tab is array (1..8) of Integer;
    
    tab : T_Tab;
    
  -- Procédure pour échanger deux éléments du tableau
  procedure Echange(A, B : in out Integer) is
      Temp : Integer;
  begin
      Temp := A;
      A := B;
      B := Temp;
  end Echange;

  -- Procédure pour le tri par sélection
  procedure Tri_Selection(Tableau : in out T_Tab) is
     i, j, min_index : Integer;
  begin
     for i in Tableau'Range loop
        min_index := i;
        for j in i+1 .. Tableau'Last loop
           if Tableau(j) < Tableau(min_index) then
              min_index := j;
           end if;
        end loop;
        Echange(Tableau(i), Tableau(min_index));
     end loop;
  end Tri_Selection;

begin
    for index in 1..8 loop
        Put("valeur " & Integer'Image(index) & " : ");
        Get(Item => tab(index));
    end loop;
    
    Tri_Selection(tab);
  
    Put_Line("Le tableau trié est :");
    for index in 1..8 loop
        Put(Item => tab(index));
    end loop;
    
end tri_tableau;
