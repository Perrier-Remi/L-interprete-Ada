with Ada.Text_IO; use Ada.Text_IO;

package body Memoire is
    
    function Creer_Donee_Variable (Code : in Integer; Valeur : in T_Element_Access; Nom : in Unbounded_String; ConstMachine : in Boolean) return T_Variable is
        Variable : T_Variable;
    begin
        Variable.Code := Code;
        Variable.Valeur := Valeur;
        Variable.Nom := Nom;
        Variable.ConstMachine := ConstMachine;
        return Variable;
    end Creer_Donee_Variable;
    
    -- Initialisation d'une mémoire vide, de taille 0 et contenant aucuns éléments
    procedure Initialiser (Memoire : out T_Memoire) is
        Tab_Variables : T_Tab_Variables;
    begin
        Memoire.Taille := 0;
        Memoire.Tab_var := Tab_Variables;
    end Initialiser;
    
    
    -- Créer une variable avec son code, sa valeur et son nom passé en paramètre
    procedure Creer_Variable (Memoire : in out T_Memoire; Valeur : in T_Element_Access; Nom : in Unbounded_String; ConstMachine : in Boolean) is
    begin
        Memoire.Taille := Memoire.Taille + 1;
        Memoire.Tab_var(Memoire.Taille) := Creer_Donee_Variable(Memoire.Taille , Valeur, Nom, ConstMachine);
    end Creer_Variable;
    
    
    -- Affecter la variable avec la valeur passé en paramètre et appelle de la fonction affecter du bon package
    procedure Affectation_Variable (Memoire : in out T_Memoire; Code : in integer; Valeur : in T_Element_Access) is
    begin
        -- Rechercher la variable correspondante dans le tableau
        --    for I in 1..Memoire.Taille loop
        --        if Memoire.Tab_var(I).Code = Code then
        --            -- Affecter la nouvelle valeur à la variable
        --            Memoire.Tab_var(I).Valeur := Valeur;
        --        end if;
        --    end loop;
        Memoire.Tab_var(Code).Valeur := Valeur;
    end Affectation_Variable;
    
    --Renvoie la variable correspondante au code passé en paramètre
    function Renvoie_Variable (Memoire : in T_Memoire; Code : in integer) return T_Variable is
    begin
        -- Rechercher la variable correspondante dans le tableau
        --      for I in 1.. Memoire.Taille loop
        --         if Memoire.Tab_var(I).Code = Code then
        --           Result := Memoire.Tab_var(I);
        --            exit;
        --         end if;
        --      end loop;
        --      return Result;
        return Memoire.Tab_var(Code);
    end Renvoie_Variable;
    
    --Renvoie tous le tableau de variable
    function Renvoie_Tab_Variable (Memoire : in T_Memoire) return T_Tab_Variables is
    begin
        return Memoire.Tab_var;
    end Renvoie_Tab_Variable;
    
    function Renvoie_Taille (Memoire : in T_Memoire) return Integer is
    begin
        return Memoire.Taille;
    end Renvoie_Taille;
    
    --Afficher la memoire 
    procedure Afficher_Memoire (Memoire : in T_Memoire) is 
        Tab_Variable_Result : T_Tab_Variables;
        variable : T_Element_Access;
        valeur : Unbounded_String;
    begin
        Tab_Variable_Result := Renvoie_Tab_Variable(Memoire);
        Put_Line("Affichage du tabeau des Variables :");
        for I in 1..Renvoie_Taille(Memoire) loop
            variable := Tab_Variable_Result(I).Valeur;
            if (not Tab_Variable_Result(I).ConstMachine) then
                case variable.Type_Element is
                when Entier =>
                    valeur := To_Unbounded_String(Integer'Image(variable.Valeur_Entier));
                when Caractere =>
                    valeur := To_Unbounded_String(Character'Image(variable.Valeur_Caractere));
                when Chaine =>
                    valeur := To_Unbounded_String(" ") & variable.Valeur_Chaine;
                when Tableau =>
                    valeur := To_Unbounded_String(" (");
                    for J in I+1..I+variable.Valeur_Taille_Tableau loop
                        case Tab_Variable_Result(J).Valeur.Type_Element is
                        when Entier =>
                            valeur := valeur & To_Unbounded_String(Integer'Image(Tab_Variable_Result(J).Valeur.Valeur_Entier)) & To_Unbounded_String(",");
                        when Caractere =>
                            valeur := valeur & To_Unbounded_String(Character'Image(Tab_Variable_Result(J).Valeur.Valeur_Caractere)) & To_Unbounded_String(",");
                        when Chaine =>
                            valeur := valeur & Tab_Variable_Result(J).Valeur.Valeur_Chaine;
                        when others =>
                            null;
                        end case;
                    end loop;
                    Delete(valeur, Length(valeur), Length(valeur));
                    valeur := valeur & To_Unbounded_String(" )");
                end case;
                Put_Line("Variable : " & To_String(Tab_Variable_Result(I).Nom)  & " =" & To_String(valeur));
            end if;
        end loop;
        -- Put_Line("Le nombre de variable est"& Integer'Image(Renvoie_Taille(Memoire)));
    end Afficher_Memoire;
    
end Memoire;
