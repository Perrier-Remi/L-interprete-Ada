with Memoire; use Memoire;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;


procedure test_memoire_2 is
    mem : T_Memoire;
    var_a : Integer;
    var_b : Character;
    a : UNbounded_String;
    b : UNbounded_String;
    c : Integer;
    
begin
    
    Initialiser(mem);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("a"), False);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'b'), To_Unbounded_String("b"), False);        
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Tableau, Valeur_Taille_Tableau => 8), To_Unbounded_String("MonTableau"), False);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 1), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 2), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 3), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 4), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 5), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 6), To_Unbounded_String("MonTableau"), True);
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 7), To_Unbounded_String("MonTableau"), True);
    Afficher_Memoire(mem);
    
end test_memoire_2;


-- tab(3) <- 4
-- 3 4 0 0 0 0 2 0 0

-- tab(a) <- b
-- 3 1 0 0 0 0 2 0 0 
