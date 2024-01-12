with Ada.Strings.Unbounded;

package Primitif is

	type T_primitif is limited private;


	-- Initialiser un variable de type T_primitif avec son nom et son type
   procedure Initialiser(Nom_var : in Unbounded_String; type_var : in T_type; variable: out T_primitif) with
     Post => variable.Valeur = null;
   
   
	-- Affecter une valeur passer en paramËtre ‡ Var.Valeur 
	procedure affecter_variable (valeur : in integer; var : in out T_primitif) with
		Post => var.Type_var = valeur;


	-- tester la condition et appeler branchement si condition valide 
	procedure renvoie_primitif (variable : in out T_primitif) ;





private
	type T_type is enumeration (int, booleen);
	
	type T_primitif is
		record
			Nom: unbouded_string; --chaine de caract√®re
			Valeur : Integer;
			Type_var : T_type; --chaine de caractare

		end record;

end Primitif;
