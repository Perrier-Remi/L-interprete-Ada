package TraiterLigne is

    CAPACITE : constant Integer := 4;      -- nombre maximum d'instructions par ligne


    procedure executer_ligne(instruction : in T_Instruction) ;


private

    type T_Instruction is array (1..CAPACITE) of T_Materiel;

end TraiterLigne;
