with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package body Memoire is

	-- Initialiser la structure de donné composé d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau défini
	--procedure Initialiser (Variable : out T_Variable) is
   --begin
   --   Variable.Taille := 0;
   --end Initialiser;
   
   
   --Focntion interne au package --
  function Creer_Tab_Variable return T_Tab_Variable is
        Memoire : T_Tab_Variable := (others => (Nom => To_Unbounded_String(""), Valeur => 0, Code => 0));
   begin
      return Memoire;
   end Creer_Tab_Variable;
   
   
   --function Creer_Donee_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String) return T_Variable with
--   Pre => Code >= 0,
--   Post => Creer_Donee_Variable'Result.Code = Code;

  function Creer_Donee_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String) return T_Variable is
   Variable : T_Variable;
  begin
   Variable.Code := Code;
   Variable.Valeur := Valeur;
   Variable.Nom := Nom;
   return Variable;
  end Creer_Donee_Variable;


---- Fin Fonction interne au package Memoire---
   
   

   procedure Initialiser (Memoire : out T_Memoire) is
   begin
      Memoire.Taille := 0;
      Memoire.Tab_var := Creer_Tab_Variable;
   end Initialiser;

  

   -- Créer une variable avec son code, sa valeur et son nom passé en paramètre
   procedure Creer_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String; Memoire : in out T_Memoire) is
   begin
      Memoire.Taille := Memoire.Taille + 1;
      Memoire.Tab_var(Memoire.Taille) := Creer_Donee_Variable(Code, Valeur, Nom);
   end Creer_Variable;
	
   
	-- Affecter la variable avec la valeur passé en paramètre et appelle de la fonction affecter du bon package
  procedure Affectation_Variable (Code : in integer; Valeur : in integer; Memoire : in out T_Memoire) is
   begin
      -- Rechercher la variable correspondante dans le tableau
      for I in 1..Memoire.Taille loop
         if Memoire.Tab_var(I).Code = Code then
            -- Affecter la nouvelle valeur à la variable
            Memoire.Tab_var(I).Valeur := Valeur;
         end if;
      end loop;
   end Affectation_Variable;

   --Renvoie la variable correspondante au code passé en paramètre
   function Renvoie_Variable (Memoire : in T_Memoire; Code : in integer) return T_Variable is
        Result : T_Variable; 
   begin
      -- Rechercher la variable correspondante dans le tableau
      for I in 1.. Memoire.Taille loop
         if Memoire.Tab_var(I).Code = Code then
            Result := Memoire.Tab_var(I);
            exit;
         end if;
      end loop;
      return Result;
   end Renvoie_Variable;

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable (Memoire : in T_Memoire) return T_Tab_Variable is
   begin
      return Memoire.Tab_var;
   end Renvoie_Tab_Variable;

   --Renvoie la valeur maximun du code, le code maximun est stocké dans le dernier enregistrement
   function Renvoie_Code_Max (Memoire : in T_Memoire) return Integer is
   begin
         return Memoire.Taille;
   end Renvoie_Code_Max;
   
   function Renvoie_Taille (Memoire : in T_Memoire) return Integer is
   begin
         return Memoire.Taille;
   end Renvoie_Taille;
   


end Memoire;
