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
         Taille : Integer; --taille du tableau qui est d�fini
   end record;
   --type T_Variable is limited private;
   


	-- Initialiser la structure de donn� compos� d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau d�fini
   --procedure Initialiser(Variable : out T_Variable);
   


   procedure Initialiser (Memoire : out T_Memoire) with
   Post => Memoire.Taille = 0;

	-- Cr�er une variable avec son code, sa valeur et son nom pass� en param�tre
 --procedure Creer_Variable (Code : in integer; Valeur : in integer; Nom : in Unbounded_String;  Variable : in out T_Variable) with
   procedure Creer_Variable (Valeur : in Integer; Nom : in Unbounded_String; Memoire : in out T_Memoire) with
     Post => (Memoire.Tab_var(Memoire.Taille).Code = Code);
   --        Le dernier �l�ment de Tab_Var a le code, la valeur et le nom sp�cifi�s.
   --
   --
   --
	-- Affecter la variable avec la valeur pass� en param�tre et appelle de la fonction affecter du bon package
   procedure Affectation_Variable (Code : in integer; Valeur : in integer; Memoire : in out T_Memoire);

   --Renvoie la variable correspondante au code pass� en param�tre
   function Renvoie_Variable (Memoire : in T_Memoire; Code : in integer) return T_Variable with
   -- Check pour post condition renvoie variable correspondante au code
   Post => Renvoie_Variable'Result.Code = Code;

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable (Memoire : in T_Memoire) return T_Tab_Variable ;

   --Renvoie la valeur maximun du code, le code maximun est stock� dans le dernier enregistrement
   function Renvoie_Code_Max (Memoire : in T_Memoire) return Integer;
   --Check post condition renvoie code du dernier record d�fini
   
   function Renvoie_Taille (Memoire : in T_Memoire) return Integer;
   
   --Afficher la memoire 
   procedure Afficher_Memoire (Memoire : in T_Memoire);
   
   



end Memoire;
