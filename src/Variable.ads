with Ada.Strings.Unbounded;

package Primitif is

	type T_primitif is limited private;


	-- Initialiser un Tableau ou seront stockés les variables
	procedure Initialiser(capacite : in interger; Tab_var: out T_primitif);

	-- Affecter la variable avec la valeur passé en paramètre et appelle de la fonction affecter du bon package
	procedure affectation_val (Valeur : in integer; Nom : in Unbounded_String;  Tab : in out T_primitif) with
		Post => cp = val_cp;

   procedure renvoie_variable (Tab_variable : in out T_tab) with
     Pre => Tab_variable

	-- tester la condition et appeler branchement si condition valide
   generic
      with procedure creer_variable (Nom : in  Unbounded_String; Var_Type : in T_type_gen);



   procedure renvoie_variable





private
	type T_type_gen is enumeration (int, booleen);

	type T_tab is array (1..Capacite) of generic;


end Primitif;
