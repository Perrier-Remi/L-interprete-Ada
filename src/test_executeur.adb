with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Executeur; use Executeur;
with Memoire; use Memoire;
with Parser; use Parser;

procedure test_executeur is
   -- Déclarer une variable pour tester le package Memoire
   Ma_Variable : T_Memoire;

   -- Déclarer d'autres variables nécessaires pour les tests
   Code_Test_1 : constant Integer := 1;
   Valeur_Test_1 : constant Integer := 12;
   Nom_Test_1 : Unbounded_String := To_Unbounded_String("var1");
   Code_Test_2 : constant Integer := 2;
   Valeur_Test_2 : constant Integer := 32;
   Nom_Test_2 : Unbounded_String := To_Unbounded_String("var2");
   
begin
    
    -- Initialiser Memoire
    Initialiser(Ma_Variable);
    
    -- tests branchement
    pragma Assert(branchement(2,1) = 1);
    pragma Assert(branchement(2,2) = 2);
    pragma Assert(branchement(2,10) = 10);

    -- tests condition
    pragma Assert(condition(0,4,10) = 3);
    pragma Assert(condition(12,4,10) = 10);
    pragma Assert(condition(-2,4,10) = 4);

    --  -- tests affectation
    --  -- affectation : var1 <- 42
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 1).Valeur.Valeur_Entier = 12);
    --  affectation(Ma_Variable, 1, 42);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 1).Valeur.Valeur_Entier = 42);
    
    --  -- affectation : var2 <- 26
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 32);
    --  affectation(Ma_Variable, 2, 26);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 26);
    
    --  --tests operation
    --  -- opération : var1 <- 1 + 2
    --  operation(Ma_Variable, 1, 1, 2, -3);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 1).Valeur.Valeur_Entier = 3);
    
    --  --opération : var2 <- 2 - 10
    --  operation(Ma_Variable, 2, 2, 10, -4);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = -8);
    
    --  --opération : var2 <- 2 * 3
    --  operation(Ma_Variable, 2, 2, 3, -5);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 6);
    
    --  --opération : var2 <- 6 / 3
    --  operation(Ma_Variable, 2, 6, 3, -6);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 2);
    
    --  --opération : var2 <- 1 = 1 (vrai)
    --  operation(Ma_Variable, 2, 1, 1, -7);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 1);
    
    --  --opération : var2 <- 1 = 0 (faux)
    --  operation(Ma_Variable, 2, 1, 0, -7);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 0);
    
    --  --opération : var2 <- 0 < 1 (vrai)
    --  operation(Ma_Variable, 2, 0, 1, -8);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 1);

    --  --opération : var2 <- 1 < 0 (faux)
    --  operation(Ma_Variable, 2, 1, 0, -8);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 0);
    
    --  --opération : var2 <- 1 > 0 (vrai)
    --  operation(Ma_Variable, 2, 1, 0, -9);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 1);

    --  --opération : var2 <- 0 > 1 (faux)
    --  operation(Ma_Variable, 2, 0, 1, -9);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 0);
    
    --  --opération : var2 <- 1 OR 0 (vrai)
    --  operation(Ma_Variable, 2, 1, 0, -10);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 1);

    --  --opération : var2 <- 0 OR 0 (faux)
    --  operation(Ma_Variable, 2, 0, 0, -10);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 0);
    
    --  --opération : var2 <- 1 AND 1 (vrai)
    --  operation(Ma_Variable, 2, 1, 1, -11);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 1);

    --  --opération : var2 <- 0 AND 0 (faux)
    --  operation(Ma_Variable, 2, 0, 0, -11);
    --  pragma Assert(Renvoie_Variable(Ma_Variable, 2).Valeur.Valeur_Entier = 0);
    
end test_executeur;
