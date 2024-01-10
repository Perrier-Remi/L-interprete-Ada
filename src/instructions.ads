package Instruction is

	type T_ABR is limited private;

	-- Réaliser un branchement, mettre cp à la valeur souhaité 
	procedure branchement(val_cp : in integer, cp : out integer) with
		Post => cp = val_cp;


	-- tester la condition et appeler branchement si condition valide 
    procedure condition (test : T_Abr, val_cp : in integer, cp : out integer) with
        Post => test and (val_cp = cp);
    

	-- affecter une valeur à une variable 
	procedure affectation (variable : in out T_variable, valeur : in integer) with
        Post => variable'valeur = valeur;

private

end Instruction;
