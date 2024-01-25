with Executeur; use Executeur;
with Memoire; use Memoire;
with Parser; use Parser;

package body interpreteur is
    
    function parametrer_branchement(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        valeur : Integer;
    begin
        valeur := instruction(2);
        return Executeur.branchement(cp, valeur);
    end;   

    function parametrer_condition(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        test : Integer;
        valeur : Integer;
    begin
        test := Memoire.Renvoie_Variable(mem, instruction(2)).Valeur.Valeur_Entier;
        valeur := instruction(4);
        return Executeur.condition(test, cp, valeur);
    end;

    function parametrer_affectation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource : T_Element_Access;
        erreur_code_intermediaire : exception;
    begin
        varDest := instruction(1);
        valSource := Memoire.Renvoie_Variable(mem, instruction(2)).Valeur;
        
        -- si le type de destination est différent du type source → lever une exception
        if Memoire.Renvoie_Variable(mem, varDest).Valeur.Type_Element /= valSource.Type_Element then
            raise erreur_code_intermediaire;
        else
            Executeur.affectation(mem, varDest, valSource);
        end if;
        
        return cp + 1;
    end;

    function parametrer_operation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource1 : T_Element_Access;
        valSource2 : T_Element_Access;
        operateur : Integer;
        erreur_code_intermediaire : exception;
    begin
        varDest := instruction(1);
        valSource1 := Memoire.Renvoie_Variable(mem, instruction(2)).Valeur;
        valSource2 := Memoire.Renvoie_Variable(mem, instruction(4)).Valeur;
        operateur := instruction(3);
        
        if valSource1.Type_Element /= valSource2.Type_Element then
            raise erreur_code_intermediaire;
        else
            Executeur.operation(mem, varDest, valSource1, valSource2, operateur);
        end if;
        return cp + 1;
    end;
    
    function parametrer_lire_ecrire(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        operateur : Integer;
    begin
        varDest := instruction(2);
        operateur := instruction(1);
        
        Executeur.lire_ecrire(mem, varDest, operateur);
        return cp + 1;
    end;

    function programme_fini(instruction : in T_Instruction) return Boolean is
    begin
        return instruction(1) = 0 and instruction(3) = 0;
    end;
    
    function executer_ligne(mem : in out T_Memoire; instruction : in T_Instruction; cp : in out Integer) return Boolean is
        erreur_code_intermediaire : exception;
    begin
        -- branchement
        if instruction(1) = -2 then
            cp := parametrer_branchement(mem, instruction, cp);
        -- condition
        elsif instruction(1) = -1 and then instruction (3) = -2 then
            cp := parametrer_condition(mem, instruction, cp);
        -- affectation
        elsif instruction(1) > 0  and then instruction(3) = 0 and then instruction(4) = 0 then
            cp := parametrer_affectation(mem, instruction, cp);
        -- operation
        elsif instruction(3) < 0 then
            cp := parametrer_operation(mem, instruction, cp);
        -- lire ou ecrire sur le terminal
        elsif instruction (1) = -14 or else instruction(1) = -15 then
            cp := parametrer_lire_ecrire(mem, instruction, cp);
        -- NULL
        elsif instruction(1) = -13 then
            cp := cp + 1;
        end if;
        
        return programme_fini(instruction);
        
    exception 
        when erreur_code_intermediaire =>
            return True;
    end;
    
end interpreteur;
