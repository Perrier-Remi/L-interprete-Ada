with Ada.Strings.Unbounded;

package primitif is

	type T_primitif is limited private;


	-- Initialiser un ABR Abr.  L'ABR est vide.
	procedure Initialiser(variable: out T_primitif);
		
	-- Réaliser un branchement, mettre cp à la valeur souhaité 
	procedure affectation_val (valeur : in integer, var : in out T_primitif) with
		Post => cp = val_cp;


	-- tester la condition et appeler branchement si condition valide 
	procedure condition (test : T_Abr, val_cp : in integer, cp : out integer) ;


	-- affecter une valeur à une variable 
	procedure affectation (variable : in out T_variable, valeur : in integer) with
		;




private
	type T_type is enumeration (int, booleen);
	
	type T_primitif is
		record
			Nom: unbouded_string; --chaine de caractère
			Valeur : Integer;
			Type_var : T_type; --chaine de caractère

		end record;

end ABR;
