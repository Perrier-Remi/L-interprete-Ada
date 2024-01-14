with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package Memoire is

   type T_Donee_Variable is
		record
			Nom: Unbounded_String;
			Valeur : Integer;
			Code : Integer; --chaine de caractare

		end record;

   type T_Tab_Variable is array (1..100) of T_Donee_Variable;
   
   type T_Variable is record
         Tab_var : T_Tab_Variable; --tableau contenant les variables
         Taille : Integer; --taille du tableau qui est défini
   end record;
   --type T_Variable is limited private;
   


	-- Initialiser la structure de donné composé d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau défini
   --procedure Initialiser(Variable : out T_Variable);
   
   procedure Initialiser (Variable : out T_Variable) with
   Post => Variable.Taille = 0;


	-- Créer une variable avec son code, sa valeur et son nom passé en paramètre
 --procedure Creer_Variable (Code : in integer; Valeur : in integer; Nom : in Unbounded_String;  Variable : in out T_Variable) with
   procedure Creer_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String; Variable : in out T_Variable) with
     Pre => Code >= 0,
     Post => (Variable.Tab_var(Variable.Taille).Code = Code);
   --        Le dernier élément de Tab_Var a le code, la valeur et le nom spécifiés.
   --
   --
   --
	-- Affecter la variable avec la valeur passé en paramètre et appelle de la fonction affecter du bon package
   procedure Affectation_Variable (Code : in integer; Valeur : in integer; Variable : in out T_Variable);

   --Renvoie la variable correspondante au code passé en paramètre
   function Renvoie_Variable (Code : in integer; Variable : in T_Variable) return T_Donee_Variable with
   -- Check pour post condition renvoie variable correspondante au code
   Post => Renvoie_Variable'Result.Code = Code;

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable (Variable : in T_Variable) return T_Tab_Variable ;

   --Renvoie la valeur maximun du code, le code maximun est stocké dans le dernier enregistrement
   function Renvoie_Code_Max (Variable : in T_Variable) return Integer;
   --Check post condition renvoie code du dernier record défini
   
   function Renvoie_Taille (Variable : in T_Variable) return Integer;



end Memoire;
