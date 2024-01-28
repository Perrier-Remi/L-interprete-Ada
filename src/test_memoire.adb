with Memoire; use Memoire;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Memoire is
    mem : T_Memoire;
    var : T_Element_Access;

begin
    --  Initialiser Memoire
    Initialiser(mem);
    pragma Assert (Renvoie_Taille(mem) = 0);

    -- Test création d'une variable entière
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Entier, Valeur_Entier => 0), To_Unbounded_String("variable a"), False);
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Nom = To_Unbounded_String("variable a"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Valeur.Type_Element = Entier);
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);

    -- Test création d'une variable caractère
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'b'), To_Unbounded_String("variable b"), False);
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Nom = To_Unbounded_String("variable b"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Valeur.Type_Element = Caractere);
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Valeur.Valeur_Caractere = 'b');


    -- Test création d'une variable chaine de caractères
    Memoire.Creer_Variable(mem, new T_Element'(Type_Element => Chaine, Valeur_chaine => To_Unbounded_String("ada")), To_Unbounded_String("variable c"), False);
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Nom = To_Unbounded_String("variable c"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Valeur.Type_Element = Chaine);
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Valeur.Valeur_Chaine = To_Unbounded_String("ada"));

    -- Test Renvoie_Variable
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 0);
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Nom = To_Unbounded_String("variable a"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Valeur.Type_Element = Entier);
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Valeur.Valeur_Caractere = 'b');
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Nom = To_Unbounded_String("variable b"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Valeur.Type_Element = Caractere);
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Valeur.Valeur_Chaine = To_Unbounded_String("ada"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Nom = To_Unbounded_String("variable c"));
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Valeur.Type_Element = Chaine);

    -- Test d'affection d'une valeur à une variable entière
    var := new T_Element'(Type_Element => Entier, Valeur_Entier => 5);
    Memoire.Affectation_Variable(mem, 1, var);
    pragma Assert (Memoire.Renvoie_Variable(mem, 1).Valeur.Valeur_Entier = 5);

    -- Test d'affection d'une valeur à une variable caractère
    var := new T_Element'(Type_Element => Caractere, Valeur_Caractere => 'd');
    Memoire.Affectation_Variable(mem, 2, var);
    pragma Assert (Memoire.Renvoie_Variable(mem, 2).Valeur.Valeur_Caractere = 'd');

    -- Test d'affection d'une valeur à une variable chaine de caractères
    var := new T_Element'(Type_Element => Chaine, Valeur_Chaine => To_Unbounded_String("abcd"));
    Memoire.Affectation_Variable(mem, 3, var);
    pragma Assert (Memoire.Renvoie_Variable(mem, 3).Valeur.Valeur_Chaine = To_Unbounded_String("abcd"));

    -- Test Renvoie_Tab_Variable
    pragma Assert (Renvoie_Tab_Variable(mem)(1).Valeur.Valeur_Entier = 5);
    pragma Assert (Renvoie_Tab_Variable(mem)(1).Nom = To_Unbounded_String("variable a"));
    pragma Assert (Renvoie_Tab_Variable(mem)(1).Valeur.Type_Element = Entier);
    pragma Assert (Renvoie_Tab_Variable(mem)(2).Valeur.Valeur_Caractere = 'd');
    pragma Assert (Renvoie_Tab_Variable(mem)(2).Nom = To_Unbounded_String("variable b"));
    pragma Assert (Renvoie_Tab_Variable(mem)(2).Valeur.Type_Element = Caractere);
    pragma Assert (Renvoie_Tab_Variable(mem)(3).Valeur.Valeur_Chaine = To_Unbounded_String("abcd"));
    pragma Assert (Renvoie_Tab_Variable(mem)(3).Nom = To_Unbounded_String("variable c"));
    pragma Assert (Renvoie_Tab_Variable(mem)(3).Valeur.Type_Element = Chaine);

    -- Test Renvoie_Taille
    pragma Assert (Renvoie_Taille(mem) = 3);

   null;
end Test_Memoire;
