with Ada.Strings.Unbounded;

package Primitif is

	type T_primitif is limited private;


	-- Initialiser la structure de donn� compos� d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau d�fini
	procedure Initialiser(Tab_Var : out T_var);

	-- Cr�er une variable avec son code, sa valeur et son nom pass� en param�tre
   procedure Creer_Variable (Code : in integer; Valeur : in integer; Nom : in Unbounded_String;  Tab_Var : in out T_var);
   --check post condition
   --
   --
   --
	-- Affecter la variable avec la valeur pass� en param�tre et appelle de la fonction affecter du bon package
   procedure Affectation_Variable (Code : in integer; Valeur : in integer; Tab_Var : in out T_var);

   --Renvoie la variable correspondante au code pass� en param�tre
   function Renvoie_Variable (code : in integer) return T_Donee_Variable ;
   -- Check pour post condition renvoie variable correspondante au code

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable return T_Tab_Variable ;

   --Renvoie la valeur maximun du code, le code maximun est stock� dans le dernier enregistrement
   function Renvoie_Code_Max return Integer;
   --Check post condition renvoie code du dernier record d�fini






   private

	type T_Donee_Variable is
		record
			Nom: unbouded_string; --chaine de caractaree
			Valeur : Integer;
			code : Integer; --chaine de caractare

		end record;

      type T_Tab_Variable is array (1..100) of T_Donee_Variable;

      type T_Variable is record
         Tab_var : T_Tab_Variable; --tableau contenant les variables
         Taille : Integer; --taille du tableau qui est d�fini
      end record;


end Primitif;
