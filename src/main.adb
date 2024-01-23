with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Interpreteur; use Interpreteur;
with Memoire; use Memoire;
with Parser; use Parser;

procedure Main is
    
    prog : Parser.T_Programme;
    mem : T_Memoire;

    
    -- Programme simple
    -- 1 i <- 2
    -- 2 a <- i
    -- 3 b <- i - a
    -- 4 if b goto 6
    -- 5 b <- 0
    -- 6 b <- 12
    -- 7 fin prog (opérateur 0)
    --
    -- variables :
    -- i, a, b : Integer
    procedure Initialiser_Main is
    begin
        Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("i"), False, mem);
        Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("a"), False, mem);
        Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("b"), False, mem);        
        Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 2), To_Unbounded_String(""), True, mem);
        Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String(""), True, mem);
        Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 12), To_Unbounded_String(""), True, mem);
        
        prog.Tab_Instruction(1) := (1,  4, -12, 0, 0, 0);
        prog.Tab_Instruction(2) := (2,  1, -12, 0, 0, 0);
        prog.Tab_Instruction(3) := (3,  1,  -4, 2, 0, 0);
        prog.Tab_Instruction(4) := (-1, 3,  -2, 6, 0, 1);
        prog.Tab_Instruction(5) := (3,  5, -12, 0, 0, 0);
        prog.Tab_Instruction(6) := (3,  6, -12, 0, 0, 0);
        prog.Tab_Instruction(7) := (0,  0,   0, 0, 0, 0);
    end Initialiser_Main;
    
    cp : Integer;
    prog_fini : Boolean;
    instruction_courrante : Parser.T_Instruction;
    mode : Character;
    MODE_NORMAL : Constant Character := '1';
    MODE_DEBUG : Constant Character := '2';

    function Menu return Character is
        choix : String(1..128);
        last : Integer;
    begin
        Put_Line("    ----- L'Interpreteur Ada -----");
        Put_Line("Choisissez un mode de fonctionnement :");
        Put_Line(" 1 : mode normal");
        Put_Line(" 2 : mode debug");
        Put("Votre choix : ");
        Get_Line(choix, last);
        while (last /= 1) or else ((choix(1) /= '1') and then (choix(1) /= '2')) loop            
            Put("Choix invalide, nouveau choix : ");
            Get_Line(choix, last);
        end loop;
        New_Line;
        return choix(1);
    end Menu;
    
    procedure Afficher_Debug is
    begin
        Memoire.Afficher_Memoire(mem);
        Put_Line("Instruction suivante : " & Integer'Image(cp));
        Put_Line("Appuyez sur entrée pour continuer le programme");
        Skip_Line;
    end;
    
begin

    -- initialiser les variables
    -- initialiser le programme
    -- initialiser cp
    -- tant que prog non fini faire
    --     executer instruction
    -- fin tant que
    -- afficher mémoire

    mode := Menu;
    Memoire.Initialiser(mem);
    Initialiser_Main;
    cp := 1;
    prog_fini := false;

    loop
        if mode = MODE_DEBUG then
            Afficher_Debug;
        end if;
        instruction_courrante := prog.Tab_Instruction(cp);
        prog_fini := Interpreteur.executer_ligne(mem, instruction_courrante, cp);
        exit when prog_fini;
    end loop;
    
end Main;
