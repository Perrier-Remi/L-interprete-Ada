package Instruction is

	type T_ABR is limited private;

	Cle_Presente_Exception : Exception;	-- une clé est déjà présente dans un ABR
	Cle_Absente_Exception  : Exception;	-- une clé est absente d'un ABR

	-- Réaliser un branchement, mettre cp à la valeur souhaité 
	procedure branchement(val_cp : in integer, cp : out integer) with
		Post => cp = val_cp;


	-- tester la condition et appeler branchement si condition valide 
	procedure condition (test : T_Abr, val_cp : in integer, cp : out integer) ;


	-- affecter une valeur à une variable 
	procedure affectation (variable : in out T_variable, valeur : in integer) with
		;




private

	type T_Noeud;
	type T_ABR is access T_Noeud;
	type T_Noeud is
		record
			Cle: Character;
			Donnee : Integer;
			Sous_Arbre_Gauche : T_ABR;
			Sous_Arbre_Droit : T_ABR;
			-- Invariant
			--    Pour tout noeud N dans Sous_Arbre_Gauche, N.Cle < Cle
			--    Pour tout noeud N dans Sous_Arbre_Droit,  N.Cle > Cle
		end record;

end ABR;
