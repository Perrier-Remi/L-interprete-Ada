with Memoire; use Memoire;

package Interpreteur is

    NB_INSTRUCTIONS : Constant Integer := 6;      -- nombre maximum d'instructions par ligne

    type T_Instruction is array (1..NB_INSTRUCTIONS) of Integer;

    -- function permettant de retourner la valeur d'une variable ou d'une constante
    function retourner_valeur(mem : in T_Memoire; variable : in Integer; const : in Integer) return Integer;

    function parametrer_condition(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function parametrer_affectation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function parametrer_operation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function programme_fini(instruction : in T_Instruction) return Boolean;

    -- fonction permettant d'executer une ligne du programme
    -- retourne vrai si le programme doit continuer et faux si l'instruction est la dernière ligne du programme
    function executer_ligne(mem : in out T_Memoire; instruction : in T_Instruction; cp : in out Integer) return Boolean;

end Interpreteur;
