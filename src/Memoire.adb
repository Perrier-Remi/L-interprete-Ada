with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package body Memoire is

	-- Initialiser la structure de donné composé d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau défini
	--procedure Initialiser (Variable : out T_Variable) is
   --begin
   --   Variable.Taille := 0;
   --end Initialiser;
   

      function Creer_Tab_Variable return T_Tab_Variable is
      Variable : T_Tab_Variable := (others => (Nom => To_Unbounded_String(""), Valeur => 0, Code => 0));
   begin
      return Variable;
   end Creer_Tab_Variable;
   
   procedure Initialiser (Variable : out T_Variable) is
   begin
      Variable.Taille := 0;
      Variable.Tab_var := Creer_Tab_Variable;
   end Initialiser;


 --  function Creer_Donee_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String) return T_Donee_Variable with
 --  Pre => Code >= 0,
 --  Post => Creer_Donee_Variable'Result.Code = Code;

function Creer_Donee_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String) return T_Donee_Variable is
   Variable : T_Donee_Variable;
begin
   Variable.Code := Code;
   Variable.Valeur := Valeur;
   Variable.Nom := Nom;
   return Variable;
end Creer_Donee_Variable;

   -- Créer une variable avec son code, sa valeur et son nom passé en paramètre
   procedure Creer_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String; Variable : in out T_Variable) is
   begin
      Variable.Taille := Variable.Taille + 1;
      Variable.Tab_var(Variable.Taille) := Creer_Donee_Variable(Code, Valeur, Nom);
   end Creer_Variable;
	
   
	-- Affecter la variable avec la valeur passé en paramètre et appelle de la fonction affecter du bon package
  procedure Affectation_Variable (Code : in integer; Valeur : in integer; Variable : in out T_Variable) is
   begin
      -- Rechercher la variable correspondante dans le tableau
      for I in 1..Variable.Taille loop
         if Variable.Tab_var(I).Code = Code then
            -- Affecter la nouvelle valeur à la variable
            Variable.Tab_var(I).Valeur := Valeur;
         end if;
      end loop;
   end Affectation_Variable;

   --Renvoie la variable correspondante au code passé en paramètre
   function Renvoie_Variable (Code : in integer; Variable : in T_Variable) return T_Donee_Variable is
   Result : T_Donee_Variable; 
   begin
      -- Rechercher la variable correspondante dans le tableau
      for I in 1.. Variable.Taille loop
         if Variable.Tab_var(I).Code = Code then
            Result := Variable.Tab_var(I);
            exit;
         end if;
      end loop;
      return Result;
   end Renvoie_Variable;

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable (Variable : in T_Variable) return T_Tab_Variable is
   begin
      return Variable.Tab_var;
   end Renvoie_Tab_Variable;

   --Renvoie la valeur maximun du code, le code maximun est stocké dans le dernier enregistrement
   function Renvoie_Code_Max (Variable : in T_Variable) return Integer is
   begin
         return Variable.Taille;
   end Renvoie_Code_Max;
   
   function Renvoie_Taille (Variable : in T_Variable) return Integer is
   begin
         return Variable.Taille;
   end Renvoie_Taille;
   


end Memoire;
