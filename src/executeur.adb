with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO; use Text_IO;
with Memoire; use Memoire;

package body executeur is
    
    function branchement(nouveauCp : in integer) return Integer is
    begin
        return nouveauCp;
    end;
   
    function condition (test : integer; valCp : in integer; nouveauCp : in integer) return integer is
        resultat : Integer;
    begin
        -- si la valeur du test est égale à 0 alors le test est faux, sinon le test est vrai
        if test /= 0 then
            resultat := nouveauCp;
        else
            resultat := valCp + 1;
        end if;
        return resultat;
    end;
    
    procedure affectation (mem : in out T_Memoire; varDest : in integer; valeur : in T_Element_Access) is
    begin
        Memoire.Affectation_Variable(mem, varDest, valeur);
    end;

    procedure operation(mem : in out T_Memoire; varDest : in Integer; valSource1 : in T_Element_Access; valSource2 : in T_Element_Access; operateur : in integer) is
        valDest : T_Element_Access;  -- Variable de destination pour le résultat de l'opération
        typeVarDest : T_Type_Element;  -- Type de la variable de destination
        erreur_code_intermediaire : exception;  -- Code d'erreur en cas de résultat nul
    begin
        valDest := Memoire.Renvoie_Variable(mem, varDest).Valeur;  -- Récupération de la valeur actuelle de la variable de destination
        typeVarDest := valDest.Type_Element;  -- Obtention du type de la variable de destination
                                              
        -- Vérification du type de la source1 (Entier, Caractère, Chaine) et du type de destination (Entier)
        if (valSource1.Type_Element = Entier) and (typeVarDest = Entier) then 
            -- Cas de l'opérateur arithmétique
            case operateur is
            when -3 => 
                valDest.Valeur_Entier := valSource1.Valeur_Entier + valSource2.Valeur_Entier;
            when -4 =>
                valDest.Valeur_Entier := valSource1.Valeur_Entier - valSource2.Valeur_Entier;
            when -5 =>
                valDest.Valeur_Entier := valSource1.Valeur_Entier * valSource2.Valeur_Entier;
            when -6 =>
                valDest.Valeur_Entier := valSource1.Valeur_Entier / valSource2.Valeur_Entier;
            when -7 =>
                valDest.Valeur_Entier := (if valSource1.Valeur_Entier = valSource2.Valeur_Entier then 1 else 0);
            when -8 =>
                valDest.Valeur_Entier := (if valSource1.Valeur_Entier < valSource2.Valeur_Entier then 1 else 0);
            when -9 =>
                valDest.Valeur_Entier := (if valSource1.Valeur_Entier > valSource2.Valeur_Entier then 1 else 0);
            when -10 =>                
                valDest.Valeur_Entier := (if (valSource1.Valeur_Entier /= 0 or valSource2.Valeur_Entier /= 0) then 1 else 0);
            when -11 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Entier /= 0 and valSource2.Valeur_Entier /= 0) then 1 else 0);
            when others =>
                valDest := null;
            end case;
            
            -- Vérification du type de la source1 (Caractère) et du type de destination (Entier)
        elsif (valSource1.Type_Element = Caractere) and (typeVarDest = Entier) then 
            -- Cas des opérateurs de comparaison pour les caractères
            case operateur is
            when -7 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Caractere = valSource2.Valeur_Caractere) then 1 else 0);
            when -8 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Caractere < valSource2.Valeur_Caractere) then 1 else 0);
            when -9 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Caractere > valSource2.Valeur_Caractere) then 1 else 0);
            when others =>
                valDest := null;
            end case;
            
            -- Vérification du type de la source1 (Chaine) et du type de destination (Entier)
        elsif (valSource1.Type_Element = Chaine) and (typeVarDest = Entier) then 
            -- Cas des opérateurs de comparaison pour les chaînes de caractères
            case operateur is
            when -7 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Chaine = valSource2.Valeur_Chaine) then 1 else 0);
            when -8 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Chaine < valSource2.Valeur_Chaine) then 1 else 0);
            when -9 =>
                valDest.Valeur_Entier := (if (valSource1.Valeur_Chaine > valSource2.Valeur_Chaine) then 1 else 0);
            when others =>
                valDest := null;
            end case;
            
            -- Vérification du type de la source1 (Chaine) et du type de destination (Chaine)
        elsif (valSource1.Type_Element = Chaine) and (typeVarDest = Chaine) then 
            -- Cas de la concaténation de chaînes
            case operateur is
            when -3 =>
                valDest.Valeur_Chaine := valSource1.Valeur_Chaine & valSource2.Valeur_Chaine;
            when others =>
                valDest := null;
            end case;
            
            -- Aucune correspondance de type
        else
            valDest := null;
        end if;
        
        -- Vérification du résultat null
        if (valDest = null) then
            raise erreur_code_intermediaire;
        else
            Memoire.Affectation_Variable(mem, varDest, valDest);  -- Affectation du résultat dans la mémoire
        end if;
        
    end operation;
    
    procedure lire_ecrire(mem : in out T_Memoire; var : in Integer; operateur : in Integer) is
        val : T_Element_Access;
        typeVar : T_Type_Element;
        input : Character;
    begin
        -- variable lu ou écrite
        val := Memoire.Renvoie_Variable(mem, var).Valeur;
        typeVar := val.Type_Element;
        
        -- Ecrire ()
        if (operateur = -14) then
            if (typeVar = Caractere) then
                Put_Line(Character'Image(val.Valeur_Caractere));
            elsif (typeVar = Entier) then
                Put_Line(Integer'Image(val.Valeur_Entier));
            end if;
        -- Lire ()
        elsif (operateur = -15) then
            Get(input);	
            if (typeVar = Caractere) then
                Memoire.Affectation_Variable(mem, var, new T_Element'(Type_Element => Caractere, Valeur_Caractere => input));
            elsif (typeVar = Entier) then
                Memoire.Affectation_Variable(mem, var, new T_Element'(Type_Element => Entier, Valeur_Entier => Integer'Value((1 => input))));
            end if;
        end if;
    end;
end executeur;
