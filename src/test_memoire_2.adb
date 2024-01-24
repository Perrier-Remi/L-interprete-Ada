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
    Memoire.Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("a"), False, mem);
    Memoire.Creer_Variable(new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'b'), To_Unbounded_String("b"), False, mem);        
    
    var_a := Memoire.Renvoie_Variable(mem, 1).Valeur.Valeur_Entier;
    var_b := Memoire.Renvoie_Variable(mem, 2).Valeur.Valeur_Caractere;

    Put(Integer'Image(var_a));
    Put(var_b);
    
    a := To_Unbounded_String("adaaa");
    b := To_Unbounded_String("aa");
    c := (if a = b then 1 else 0);
    Put_Line(Integer'Image(c));
end test_memoire_2;
