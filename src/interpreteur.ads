package Interpreteur is

    NB_INSTRUCTIONS : Constant Integer := 6;      -- nombre maximum d'instructions par ligne

    -- procedure permettant d'executer une ligne du programme
    procedure executer_ligne(instruction : in T_Instruction) ;


private

    type T_Instruction is array (1..NB_INSTRUCTIONS) of Integer;

end Interpreteur;
