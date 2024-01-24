with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Executeur; use Executeur;
with Memoire; use Memoire;
with Parser; use Parser;

procedure test_executeur is
   -- Déclarer une variable pour tester le package Memoire
   mem : T_Memoire;

begin
    -- initialisition memoire
    Initialiser(mem);
    Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("e1"), False, mem);
    Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 10), To_Unbounded_String("e2"), False, mem);
    Memoire.Creer_Variable(new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'a'), To_Unbounded_String("c1"), False, mem);
    Memoire.Creer_Variable(new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'a'), To_Unbounded_String("c2"), False, mem);
    Memoire.Creer_Variable(new T_Element'(Type_Element => Chaine, Valeur_Chaine => To_Unbounded_String("aa")), To_Unbounded_String("s1"), False, mem);        
    Memoire.Creer_Variable(new T_Element'(Type_Element => Chaine, Valeur_Chaine => To_Unbounded_String("aa")), To_Unbounded_String("s2"), False, mem);        
   

    
    -- tests branchement
    pragma Assert(branchement(2,1) = 1);
    pragma Assert(branchement(2,2) = 2);
    pragma Assert(branchement(2,10) = 10);

    -- tests condition
    pragma Assert(condition(0,4,10) = 5);
    pragma Assert(condition(12,4,10) = 10);
    pragma Assert(condition(-2,4,10) = 10);

    -- tests affectation
    -- affectation : e1 <- 5
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    affectation(mem, 1, new T_Element'(Type_Element => Entier, Valeur_Entier => 5));
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 5);
    
    -- affectation : c1 <- 'c'
    pragma Assert(Renvoie_Variable(mem, 3).Valeur.Valeur_Caractere = 'a');
    affectation(mem, 3, new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'c'));
    pragma Assert(Renvoie_Variable(mem, 3).Valeur.Valeur_Caractere = 'c');
    
    -- affectation : s1 <- "ada"
    pragma Assert(Renvoie_Variable(mem, 5).Valeur.Valeur_Chaine = "aa");
    affectation(mem, 5, new T_Element'(Type_Element => Chaine, Valeur_Chaine => To_Unbounded_String("ada")));
    pragma Assert(Renvoie_Variable(mem, 5).Valeur.Valeur_Chaine = "ada");

    --tests operation
    -- opération : e1 (15) <- e1 (5) + e2 (10)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -3);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 15);
    
    --opération : e1 (5) <- e1 (15) - e2 (10)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -4);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 5);
    
    --opération : e1 (50) <- e1 (5) * e2 (10)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -5);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 50);
    
    --opération : e1 (5) <- e1 (50) / e2 (10)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -6);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 5);
    
    --opération : e1 (1) <- e2 (10) = e2 (10) (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 2).Valeur, Renvoie_Variable(mem, 2).Valeur, -7);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);
    
    --opération : e1 (0) <- e1 (1) = e2 (10) (faux)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -7);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : e1 (1) <- e1 (0) < e2 (10) (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -8);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);

    --opération : e1 (0) <- e2 (10) < e1 (1) (faux)
    operation(mem, 1, Renvoie_Variable(mem, 2).Valeur, Renvoie_Variable(mem, 1).Valeur, -8);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : e1 (1) <- e2 (10) > e1 (0) (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 2).Valeur, Renvoie_Variable(mem, 1).Valeur, -9);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);

    --opération : e1 (0) <- e1 (1) > e2 (10) (faux)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -9);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : e1 (0) <- e1 (0) OR e1 (0) (faux)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 1).Valeur, -10);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);

    --opération : e1 (1) <- e1 (0) OR e2 (10) (faux)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -10);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);
    
    --opération : e1 (1) <- e1 (1) AND e2 (10) (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -11);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);

    affectation(mem, 1, new T_Element'(Type_Element => Entier, Valeur_Entier => 0));
    --opération : e1 (0) <- e1 (0) AND e2 (10) (faux)
    operation(mem, 1, Renvoie_Variable(mem, 1).Valeur, Renvoie_Variable(mem, 2).Valeur, -11);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : s1 "adaaa" <- s1 "ada" + s2 "aa"
    operation(mem, 5, Renvoie_Variable(mem, 5).Valeur, Renvoie_Variable(mem, 6).Valeur, -3);
    pragma Assert(Renvoie_Variable(mem, 5).Valeur.Valeur_Chaine = "adaaa");
    
    --opération : e1 (1) <- s1 "adaaa" = s1 "adaaa" (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 5).Valeur, Renvoie_Variable(mem, 5).Valeur, -7);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);
    
    --opération : e1 (0) <- s1 "adaaa" = s2 "aa" (faux)
    operation(mem, 1, Renvoie_Variable(mem, 5).Valeur, Renvoie_Variable(mem, 6).Valeur, -7);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : e1 (1) <- s2 "aa" < s1 "adaaa" (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 6).Valeur, Renvoie_Variable(mem, 5).Valeur, -8);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);

    --opération : e1 (0) <- s1 "adaaa" < s2 "aa" (faux)
    operation(mem, 1, Renvoie_Variable(mem, 5).Valeur, Renvoie_Variable(mem, 6).Valeur, -8);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : e1 (1) <- s1 "adaaa" > s2 "aa" (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 5).Valeur, Renvoie_Variable(mem, 6).Valeur, -9);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);

    --opération : e1 (0) <- s2 "aa" > s1 "adaaa" (faux)
    operation(mem, 1, Renvoie_Variable(mem, 6).Valeur, Renvoie_Variable(mem, 5).Valeur, -9);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);


    --opération : e1 (1) <- c1 'c' = c1 'c' (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 3).Valeur, Renvoie_Variable(mem, 3).Valeur, -7);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);
    
    --opération : e1 (0) <- c1 'c' = c2 'a' (faux)
    operation(mem, 1, Renvoie_Variable(mem, 3).Valeur, Renvoie_Variable(mem, 4).Valeur, -7);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    
    --opération : e1 (0) <- c2 'a' < c1 'c' (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 4).Valeur, Renvoie_Variable(mem, 3).Valeur, -8);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);
    
    --opération : e1 (1) <- c1 'c' < c2 'a' (faux)
    operation(mem, 1, Renvoie_Variable(mem, 3).Valeur, Renvoie_Variable(mem, 4).Valeur, -8);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);    

    --opération : e1 (0) <- c1 'c' > c2 'a' (vrai)
    operation(mem, 1, Renvoie_Variable(mem, 3).Valeur, Renvoie_Variable(mem, 4).Valeur, -9);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 1);    
    
    --opération : e1 (1) <- c2 'a' > c1 'c' (faux)
    operation(mem, 1, Renvoie_Variable(mem, 4).Valeur, Renvoie_Variable(mem, 3).Valeur, -9);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);

end test_executeur;
