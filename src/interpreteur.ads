with Memoire; use Memoire;
with Parser; use Parser;

package Interpreteur is

    -- fonction permettant de récupérer une variable si elle se trouve dans un tableau ou non
    function adresse_memoire(mem : in T_Memoire; code_var : in Integer; code_tab : in Integer) return T_Variable;

    -- fonction permettant de configurer un branchement (ex : GOTO 8)
    function parametrer_branchement(instruction : in T_Instruction) return Integer with
        Pre => instruction(1) = -2;

    -- fonction permettant de configurer une condition (ex : IF X GOTO 8)
    function parametrer_condition(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer with
        Pre => instruction(1) = -1 and instruction(4) > 0;

    -- fonction permettant de configurer une affectation (ex : A <- 1)
    function parametrer_affectation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    -- fonction permettant de configurer une operation (ec : A <- i + 1)
    function parametrer_operation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer;

    -- fonction permettant de lire ou d'écrire dans le terminal de l'utilsateur
    function parametrer_lire_ecrire(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer with
        Pre => instruction(1) = -14 or instruction(1) = -15;

    -- fonction indiquant si le programme est fini (true) ou non (false)
    function programme_fini(instruction : in T_Instruction) return Boolean with
        Post => programme_fini'Result = (instruction(1) = 0 and instruction(3) = 0);

    -- fonction permettant d'executer une ligne du programme
    -- retourne vrai si le programme doit continuer et faux si l'instruction est la dernière ligne du programme
    function executer_ligne(mem : in out T_Memoire; instruction : in T_Instruction; cp : in out Integer) return Boolean;

end Interpreteur;
