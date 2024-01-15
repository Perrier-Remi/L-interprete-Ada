package Interpreteur is

    NB_INSTRUCTIONS : Constant Integer := 6;      -- nombre maximum d'instructions par ligne

    type T_Instruction is array (1..NB_INSTRUCTIONS) of Integer;

    -- fonction permettant d'executer une ligne du programme
    -- retourne 1 si le programme doit continuer et 0 si l'instruction est la dernière ligne du programme
    function executer_ligne(instruction : in T_Instruction; cp : in out Integer) return Integer;

end Interpreteur;
