with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

package Memoire is

    type T_Type_Element is (Entier, Caractere, Booleen);

    type T_Element (Type_Element : T_Type_Element) is record
        case Type_Element is
            when Entier =>
                Valeur_Entier : Integer;
            when Caractere =>
                Valeur_Caractere : Character;
            when Booleen =>
                Valeur_Booleen : Boolean;
        end case;
    end record;
    
    type T_Element_Access is access all T_Element;

    type T_Variable is record
        Nom: Unbounded_String;
        Valeur : T_Element_Access;
        Code : Integer;
        ConstMachine : Boolean;
    end record;

    type T_Tab_Variable is array (1..100) of T_Variable;


   type T_Memoire is record
         Tab_var : T_Tab_Variable; --tableau contenant les variables
         Taille : Integer; --taille du tableau qui est défini
   end record;   


	-- Initialiser la structure de donné composé d'un tableau et d'une Valeur Taille qui nous indique la taille du tableau défini
   --procedure Initialiser(Variable : out T_Variable);
   


   procedure Initialiser (Memoire : out T_Memoire) with
   Post => Memoire.Taille = 0;

	-- Créer une variable avec son code, sa valeur et son nom passé en paramètre
   --procedure Creer_Variable (Code : in integer; Valeur : in integer; Nom : in Unbounded_String;  Variable : in out T_Variable) with
   procedure Creer_Variable (Valeur : in T_Element_Access; Nom : in Unbounded_String; ConstMachine : in Boolean; Memoire : in out T_Memoire); --with
     --Post => ((Memoire.Tab_var(Memoire.Taille).Nom = Nom) and (Memoire.Tab_var(Memoire.Taille).Valeur = Valeur));
   --        Le dernier �l�ment de Tab_Var a le code, la valeur et le nom sp�cifi�s.

	-- Affecter la variable avec la valeur pass� en param�tre et appelle de la fonction affecter du bon package
   procedure Affectation_Variable (Code : in integer; Valeur : in T_Element_Access; Memoire : in out T_Memoire);

   --Renvoie la variable correspondante au code passé en paramètre
   function Renvoie_Variable (Memoire : in T_Memoire; Code : in integer) return T_Variable;-- with
   -- Check pour post condition renvoie variable correspondante au code
   --Post => Renvoie_Variable'Result.Code = Code;

   --Renvoie tous le tableau de variable
   function Renvoie_Tab_Variable (Memoire : in T_Memoire) return T_Tab_Variable ;

   --Renvoie la valeur maximun du code, le code maximun est stocké dans le dernier enregistrement
   function Renvoie_Code_Max (Memoire : in T_Memoire) return Integer;
   --Check post condition renvoie code du dernier record défini
   
   function Renvoie_Taille (Memoire : in T_Memoire) return Integer;
   
   --Afficher la memoire 
   procedure Afficher_Memoire (Memoire : in T_Memoire);
    
end Memoire;
