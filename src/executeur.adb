with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO; use Text_IO;
with Memoire; use Memoire;

package body executeur is
    
    function branchement(valCp : in integer; nouveauCp : in integer) return Integer is
    begin
        return nouveauCp;
    end;
   
    function condition (test : integer; valCp : in integer; nouveauCp : in integer) return integer is
        resultat : Integer;
    begin
        if test /= 0 then
            resultat := nouveauCp;
        else
            resultat := valCp + 1;
        end if;
        return resultat;
    end;
    
    procedure affectation (mem : in out T_Memoire; varDest : in integer; valeur : in T_Element_Access) is
    begin
        Memoire.Affectation_Variable(varDest, valeur, mem);
    end;

    procedure operation(mem : in out T_Memoire; varDest : in Integer; valSource1 : in T_Element_Access; valSource2 : in T_Element_Access; operateur : in integer) is
        valDest : T_Element_Access;
        typeVarDest : T_Type_Element;
        erreur_code_intermediaire : exception;
    begin
        valDest := Memoire.Renvoie_Variable(mem, varDest).Valeur;
        typeVarDest := valDest.Type_Element;
        if (valSource1.Type_Element = Entier) and (typeVarDest = Entier) then 
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
        elsif (valSource1.Type_Element = Caractere) and (typeVarDest = Entier) then 
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
        elsif (valSource1.Type_Element = Chaine) and (typeVarDest = Entier) then 
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
        elsif (valSource1.Type_Element = Chaine) and (typeVarDest = Chaine) then 
            case operateur is
                when -3 =>
                    valDest.Valeur_Chaine := valSource1.Valeur_Chaine & valSource2.Valeur_Chaine;
                when others =>
                    valDest := null;
            end case;
        else
            valDest := null;
        end if;
        
        if (valDest = null) then
            raise erreur_code_intermediaire;
        else
            Memoire.Affectation_Variable(varDest, valDest, mem);
        end if;
    end;
    
    procedure lire_ecrire(mem : in out T_Memoire; varDest : in Integer; operateur : in Integer) is
        valDest : T_Element_Access;
        typeVarDest : T_Type_Element;
        input : Character;
    begin
        valDest := Memoire.Renvoie_Variable(mem, varDest).Valeur;
        typeVarDest := valDest.Type_Element;
        
        -- Ecrire ()
        if (operateur = -14) then
            if (typeVarDest = Caractere) then
                Put_Line(Character'Image(valDest.Valeur_Caractere));
            elsif (typeVarDest = Entier) then
                Put_Line(Integer'Image(valDest.Valeur_Entier));
            end if;
        -- Lire ()
        elsif (operateur = -15) then
            Get(input);	
            if (typeVarDest = Caractere) then
                Memoire.Affectation_Variable(varDest, new T_Element'(Type_Element => Caractere, Valeur_Caractere => input), mem);
            elsif (typeVarDest = Entier) then
                Memoire.Affectation_Variable(varDest, new T_Element'(Type_Element => Entier, Valeur_Entier => Integer'Value((1 => input))), mem);
            end if;
        end if;
    end;
end executeur;
