with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Vecteurs_Creux;

procedure Main is
    type Instruction is array (1..6) of Integer;
    
    package Instructions is new Vecteurs_Creux (T_Element => Instruction);

    procedure Initialiser_Instructions is
    begin
        
        
        
    end
begin

   Append(V, (To_Unbounded_String("A"), To_Unbounded_String("3"), To_Unbounded_String("+"), To_Unbounded_String("1")));

end Main;
