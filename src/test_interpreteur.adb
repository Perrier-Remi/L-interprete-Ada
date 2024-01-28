with Memoire; use Memoire;
with Interpreteur; use Interpreteur;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Parser; use Parser;


procedure test_interpreteur is
    -- Déclarer une variable pour tester le package Memoire
    mem : T_Memoire;
    
    cp : Integer;
    instruction : T_Instruction;
begin
    
    -- Initialiser Memoire
    Initialiser(mem);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("e1"), False); 
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 10), To_Unbounded_String("e2"), False);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 3), To_Unbounded_String(""), True);    
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'a'), To_Unbounded_String("c1"), False);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'a'), To_Unbounded_String("c2"), False);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'd'), To_Unbounded_String(""), False);

    
    -- test instruction branchement
    cp := 1;
    instruction := (-2, 3, 0, 0, 1, 0); -- GOTO 3
    pragma Assert(not executer_ligne(mem, instruction, cp)); -- le programme n'étant pas fini, executer_ligne renvoie false
    pragma Assert(cp = 3);

    -- test instruction condition
    cp := 1;
    instruction := (-1, 1, -2, 5, 0, 1); -- IF e1 GOTO 5 (faux → cp reste passe à l'instruction suivante)
    pragma Assert(not executer_ligne(mem, instruction, cp));
    pragma Assert(cp = 2);
    
    cp := 1;
    instruction := (-1, 2, -2, 8, 0, 1); -- IF e2 GOTO 8 (vrai → cp passe à 8)
    pragma Assert(not executer_ligne(mem, instruction, cp));
    pragma Assert(cp = 8);

    -- test instruction affectation
    cp := 1;    
    instruction := (1, 3, 0, 0, 0, 0); -- e1 <- 3
    pragma Assert(not executer_ligne(mem, instruction, cp));
    pragma Assert(cp = 2);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 3);

    cp := 1;
    instruction := (4, 6, 0, 0, 0, 0); -- c1 <- 'd'
    pragma Assert(not executer_ligne(mem, instruction, cp));
    pragma Assert(cp = 2);
    pragma Assert(Renvoie_Variable(mem, 4).Valeur.Valeur_Caractere = 'd');
    
    -- test instruction operation
    -- tous les cas d'opération ne sont pas traités ici mais dans le fichier test_executeur, ce test permet de vérifier que les opérations sont bien paramétrés
    cp := 1;
    instruction := (1, 2, -3, 3, 0, 0); -- e1 <- e2 + 3
    pragma Assert(not executer_ligne(mem, instruction, cp));
    pragma Assert(cp = 2);
    pragma Assert(Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 13);
    
    -- test fin programme
    cp := 1;
    instruction := (0, 0, 0, 0, 0, 0);
    pragma Assert(executer_ligne(mem, instruction ,cp));
    pragma Assert(cp = 1);
   
end test_interpreteur;
