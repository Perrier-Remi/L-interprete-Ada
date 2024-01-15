with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Interpreteur; use Interpreteur;
with Memoire; use Memoire;

procedure Main is
    
    MAX_LIGNES_PROGRAMME : Constant Integer := 1000;
    type T_Programme is array (1..MAX_LIGNES_PROGRAMME) of Interpreteur.T_Instruction;

    prog : T_Programme;
    mem : T_Memoire;

    
    -- Programme simple
    -- 1 i <- 2
    -- 2 a <- i + 1
    -- 3 b <- i + a
    -- 4 if b goto 6
    -- 5 b <- 0
    -- 6 b <- 12
    -- 7 fin prog (opérateur 0)
    --
    -- variables :
    -- i, a, b : Integer
    procedure Initialiser_Main is
    begin
        Memoire.Creer_Variable(0, To_Unbounded_String("i"), mem);
        Memoire.Creer_Variable(0, To_Unbounded_String("a"), mem);
        Memoire.Creer_Variable(0, To_Unbounded_String("b"), mem);

        prog(1) := (1,  2, -12, 0, 1, 0);
        prog(2) := (2,  1,  -3, 1, 0, 1);
        prog(3) := (3,  1,  -3, 2, 0, 0);
        prog(4) := (-1, 3,  -2, 6, 0, 1);
        prog(5) := (3,  0, -12, 0, 1, 0);
        prog(6) := (3, 12, -12, 0, 1, 0);
        prog(7) := (0,  0,   0, 0, 0, 0);
    end Initialiser_Main;
    
    cp : Integer;
    prog_fini : Boolean;
    instruction_courrante : Interpreteur.T_Instruction;
begin

    -- initialiser les variables
    -- initialiser le programme
    -- initialiser cp
    -- tant que prog non fini faire
    --     executer instruction
    -- fin tant que
    -- afficher mémoire

    Memoire.Initialiser(mem);
    Initialiser_Main;
    cp := 1;
    prog_fini := false;

    while not prog_fini loop
        instruction_courrante := prog(cp);
        prog_fini := Interpreteur.executer_ligne(mem, instruction_courrante, cp);
    end loop;

    Memoire.Afficher_Memoire(mem);
end Main;
