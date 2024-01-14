with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package Memoire is

   type T_Variable is
		record
			Nom: Unbounded_String;
			Valeur : Integer;
			Code : Integer; --chaine de caractare

		end record;

   type T_Tab_Variable is array (1..100) of T_Variable;
   
   type T_Memoire is record
         Tab_var : T_Tab_Variable; --tableau contenant les variables
         Taille : Integer; --taille du tableau qui est défini
   end record;
   --type T_Variable is limited private;
   


	-- Initialiser la structure de donné composé d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau défini
   --procedure Initialiser(Variable : out T_Variable);
   


   procedure Initialiser (Memoire : out T_Memoire) with
   Post => Memoire.Taille = 0;

   function Creer_Tab_Variable return T_Tab_Variable;


   
   function Creer_Donee_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String) return T_Variable with
   Pre => Code >= 0,
   Post => Creer_Donee_Variable'Result.Code = Code;




	-- Créer une variable avec son code, sa valeur et son nom passé en paramètre
 --procedure Creer_Variable (Code : in integer; Valeur : in integer; Nom : in Unbounded_String;  Variable : in out T_Variable) with
   procedure Creer_Variable (Code : Integer; Valeur : Integer; Nom : Unbounded_String; Memoire : in out T_Memoire) with
     Pre => Code >= 0,
     Post => (Memoire.Tab_var(Memoire.Taille).Code = Code);
   --        Le dernier élément de Tab_Var a le code, la valeur et le nom spécifiés.
   --
   --
   --
	-- Affecter la variable avec la valeur passé en paramètre et appelle de la fonction affecter du bon package
   procedure Affectation_Variable (Code : in integer; Valeur : in integer; Memoire : in out T_Memoire);

   --Renvoie la variable correspondante au code passé en paramètre
   function Renvoie_Variable (Memoire : in T_Memoire; Code : in integer) return T_Variable with
   -- Check pour post condition renvoie variable correspondante au code
   Post => Renvoie_Variable'Result.Code = Code;

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable (Memoire : in T_Memoire) return T_Tab_Variable ;

   --Renvoie la valeur maximun du code, le code maximun est stocké dans le dernier enregistrement
   function Renvoie_Code_Max (Memoire : in T_Memoire) return Integer;
   --Check post condition renvoie code du dernier record défini
   
   function Renvoie_Taille (Memoire : in T_Memoire) return Integer;



end Memoire;
