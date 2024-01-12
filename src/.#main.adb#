with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   type Instruction is array (1..4) of Integer;
   package String_Vectors is new Vectors(Natural, Instruction);
   use String_Vectors;
    
   V : Vector;

begin
   Append(V, ());
   Append(V, (To_Unbounded_String("A"), To_Unbounded_String("3"), To_Unbounded_String("+"), To_Unbounded_String("1")));
   
   for I in V.First_Index .. V.Last_Index loop
      for J in V.Element(I)'Range loop
         Put(Unbounded_String'Image(V.Element(I)(J)));
      end loop;
      New_Line;
   end loop;
end Main;
