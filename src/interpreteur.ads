with Memoire; use Memoire;
with Parser; use Parser;

package Interpreteur is
    function parametrer_branchement(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function parametrer_condition(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function parametrer_affectation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function parametrer_operation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    function programme_fini(instruction : in T_Instruction) return Boolean;

    -- fonction permettant d'executer une ligne du programme
    -- retourne vrai si le programme doit continuer et faux si l'instruction est la dernière ligne du programme
    function executer_ligne(mem : in out T_Memoire; instruction : in T_Instruction; cp : in out Integer) return Boolean;

end Interpreteur;
