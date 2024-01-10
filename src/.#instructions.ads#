package Instruction is

	-- Réaliser un branchement, mettre cp à la valeur souhaité 
	procedure branchement(val_cp : in integer, cp : out integer) with
		Post => cp = val_cp;


	-- tester la condition et appeler branchement si condition valide 
    procedure condition (test : T_Abr, val_cp : in integer, cp : out integer) with
        Post => test and (val_cp = cp);
    

    -- affecter une valeur à une variable
    procedure affectation (nom_variable : in string, valeur : in integer);
    
    procedure operation(var_1 : in T_variable, var_2 : in T_variable, operateur : in string);
    
    
end Instruction;
