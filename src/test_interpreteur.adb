with Memoire; use Memoire;
with Interpreteur; use Interpreteur;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;


procedure test_interpreteur is
   -- Déclarer une variable pour tester le package Memoire
   Ma_Variable : T_Memoire;

   -- Déclarer d'autres variables nécessaires pour les tests
   Code_Test_1 : constant Integer := 1;
   Valeur_Test_1 : constant Integer := 12;
   Nom_Test_1 : Unbounded_String := To_Unbounded_String("var1");
   Code_Test_2 : constant Integer := 2;
   Valeur_Test_2 : constant Integer := 32;
   Nom_Test_2 : Unbounded_String := To_Unbounded_String("var2");
   
    cp : Integer;
    instruction : Interpreteur.T_Instruction;
    
begin
    
    -- Initialiser Memoire
    Initialiser(Ma_Variable);

    cp := 1;
    
    -- test instruction branchement
    instruction := (-2, 3, -12, 0, 1, 0); -- GOTO 3
    executer_ligne(instruction, cp);
    pragma Assert(cp = 3);

    -- test instruction condition
    instruction := (-1, 1, -2, 5, 0, 1); -- IF var1 GOTO 5
    executer_ligne(instruction, cp);
    pragma Assert(cp = 5);

    -- test instruction affectation
    instruction := (1, 3, -12, 0, 1, 0); -- var1 <- 3
    executer_ligne(instruction, cp);
    pragma Assert(cp = 5);
    pragma Assert(Renvoie_Variable(Ma_Variable, 1).Valeur = 3);

    
    --test instruction operation
    instruction := (1, 3, -3, 4, 1, 1); -- var1 <- 3 + 4
    executer_ligne(instruction, cp);
    pragma Assert(cp = 5);
    pragma Assert(Renvoie_Variable(Ma_Variable, 1).Valeur = 7);
   
end test_interpreteur;
