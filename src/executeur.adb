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
            when others =>
                valDest := null;
            end case;
        end if;
        if (valSource1.Type_Element = Entier) and (typeVarDest = Booleen) then 
            case operateur is
            when -7 =>
                valDest.Valeur_Booleen := valSource1.Valeur_Entier = valSource2.Valeur_Entier;
            when -8 =>
                valDest.Valeur_Booleen := valSource1.Valeur_Entier < valSource2.Valeur_Entier;
            when -9 =>
                valDest.Valeur_Booleen := valSource1.Valeur_Entier > valSource2.Valeur_Entier;
            when others =>
                valDest := null;
            end case;
        end if;
        if (valSource1.Type_Element = Booleen) and (typeVarDest /= Entier) then 
            case operateur is
            when -10 =>                
                valDest.Valeur_Booleen := valSource1.Valeur_Booleen or valSource2.Valeur_Booleen;
            when -11 =>
                valDest.Valeur_Booleen := valSource1.Valeur_Booleen and valSource2.Valeur_Booleen;
            when others =>
                valDest := null;
            end case;
        end if;
        
        if (valDest = null) then
            raise erreur_code_intermediaire;
        else
            Memoire.Affectation_Variable(varDest, valDest, mem);
        end if;
    end;

end executeur;
