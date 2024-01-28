with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package Memoire is    
    
    ----- definition des types pour la mémoire ------------
    type T_Type_Element is (Entier, Caractere, Chaine, Tableau);
    
    type T_Element (Type_Element : T_Type_Element) is record
        case Type_Element is
            when Entier =>
                Valeur_Entier : Integer;
            when Caractere =>
                Valeur_Caractere : Character;
            when Chaine =>
                Valeur_Chaine : Unbounded_String;
            when Tableau =>
                Valeur_Taille_Tableau : Integer;
        end case;
    end record;
    
    type T_Element_Access is access all T_Element;
    
    type T_Variable is record
        Nom: Unbounded_String;
        Valeur : T_Element_Access;
        Code : Integer;
        ConstMachine : Boolean;
    end record;
    
    type T_Tab_Variables is array (1..500) of T_Variable;
    
    
    type T_Memoire is record
        Tab_var : T_Tab_Variables; --tableau contenant les variables
        Taille : Integer; --taille du tableau de variables
    end record;   
    
    
    -- Initialiser la structure de donné composé d'un tableau et de sa taille (indiquant taille du tableau)
    procedure Initialiser (Memoire : out T_Memoire) with
        Post => Memoire.Taille = 0;
    
    -- Créer une variable avec son code, sa valeur et son nom passé en paramètre
    procedure Creer_Variable (Memoire : in out T_Memoire; Valeur : in T_Element_Access; Nom : in Unbounded_String; ConstMachine : in Boolean) with
        Post => ((Memoire.Tab_var(Memoire.Taille).Nom = Nom) and (Memoire.Tab_var(Memoire.Taille).Valeur = Valeur));
    
    -- Affecter la variable avec la valeur pass� en param�tre et appelle de la fonction affecter du bon package
    procedure Affectation_Variable (Memoire : in out T_Memoire; Code : in integer; Valeur : in T_Element_Access) with
        Post => (Memoire.Tab_var(Code).Valeur = Valeur);
    
    -- Renvoie la variable correspondante au code passé en paramètre
    function Renvoie_Variable (Memoire : in T_Memoire; Code : in integer) return T_Variable with
        Post => Renvoie_Variable'Result.Code = Code;
    
    -- Renvoie le tableau contenant toutes les variables
    function Renvoie_Tab_Variable (Memoire : in T_Memoire) return T_Tab_Variables with
        Post => Renvoie_Tab_Variable'Result = Memoire.Tab_var;
        
    -- Fonction donnant la taille de la mémoire
    function Renvoie_Taille (Memoire : in T_Memoire) return Integer with
        Post => Renvoie_Taille'Result = Memoire.Taille;
    
    -- Procedure permettant d'afficher la memoire 
    procedure Afficher_Memoire (Memoire : in T_Memoire);
    
    
end Memoire;
