with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with GNAT.OS_Lib;
with Interpreteur; use Interpreteur;
with Memoire; use Memoire;
with Parser; use Parser;

procedure Main is
    
    prog : Parser.T_Programme; -- variable contenant toutes les instructions du programme
    mem : T_Memoire; -- variable contenant la mémoire du programme
    cp : Integer; -- valeur de cp
    prog_fini : Boolean; -- variable booléenne indiquant si un programme est fini ou non
    instruction_courrante : Parser.T_Instruction; -- variable contenant une instruction du programme
    mode : Character; -- variable contenant le mode d'exécution (débug ou normal)
    MODE_NORMAL : Constant Character := '1';
    MODE_DEBUG : Constant Character := '2';
    
    -- chargement du programme et de la mémoire à partir d'un fichier de code intermédiaire
    procedure Initialiser_Main(prog : in out T_Programme; mem : in out T_Memoire) is
        path : Unbounded_String;
    begin
        if (Argument_Count = 1) then
            path := To_Unbounded_String(Argument(1)); -- récupération du chemin du code intermédiaire
            Memoire.Initialiser(mem); -- initialisation de la mémoire
            Parser.Lire_Fichier(To_String(path), prog, mem); -- chargement du code intermédiaire dans la mémoire et dans le programme
            Parser.Renvoyer_Resultat_Programme(prog); -- création d'un fichier d'instructions
        else
            Put_Line("Erreur  : Vous devez mettre un code intermediaire en parametre du programme");
            Put_Line("Exemple : ./main code_intermediaire.txt");
            GNAT.OS_Lib.OS_Exit (0);
        end if;
    end Initialiser_Main;
    

    -- affichage du menu permettant de sélection le mode d'exécution du programme
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
    
    -- procédure permettant d'afficher le mode debug d'une instruction
    procedure Afficher_Debug(instruction_courrante : in T_Instruction) is
    begin
        Memoire.Afficher_Memoire(mem);
        Put_Line("Instruction suivante : " & Integer'Image(cp));
        Put_Line("Appuyez sur entrée pour continuer le programme");
        Skip_Line;
    end;
    
begin
    -- initialisation du programme
    Initialiser_Main(prog, mem);
    cp := 1;
    prog_fini := false;
    
    -- choix du mode d'exécution
    mode := Menu;
 
    -- exécution du programme
    loop
        if mode = MODE_DEBUG then
            Afficher_Debug(prog.Tab_Instruction(cp));
        end if;
        instruction_courrante := prog.Tab_Instruction(cp);
        prog_fini := Interpreteur.executer_ligne(mem, instruction_courrante, cp);
        exit when prog_fini;
    end loop;
end Main;
