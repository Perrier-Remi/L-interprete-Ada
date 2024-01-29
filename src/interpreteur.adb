with Executeur; use Executeur;
with Memoire; use Memoire;
with Parser; use Parser;

package body interpreteur is
    
    function adresse_memoire(mem : in T_Memoire; code_var : in Integer; code_tab : in Integer) return T_Variable is
        var : T_Variable;
        var_retour : T_Variable;
    begin
        var := Memoire.Renvoie_Variable(mem, code_var);
        if var.Valeur.Type_Element = Tableau then
            var_retour := Memoire.Renvoie_Variable(mem, var.Code + Memoire.Renvoie_Variable(mem, code_tab).Valeur.Valeur_Entier);
        else 
            var_retour := Memoire.Renvoie_Variable(mem, code_var);
        end if;
        return var_retour;
    end;
                   
    function parametrer_branchement(instruction : in T_Instruction) return Integer is
        valeur : Integer;
    begin
        valeur := instruction(2); -- valeur du saut à effectuer
        return Executeur.branchement(valeur);
    end;

    function parametrer_condition(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        test : Integer;
        valeur : Integer;
        var : T_Variable;
    begin
        test := adresse_memoire(mem, instruction(2), instruction(8)).Valeur.Valeur_Entier;
        valeur := instruction(4); -- valeur du saut à effectuer si le test est vrai
        return Executeur.condition(test, cp, valeur);
    end;

    function parametrer_affectation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource : T_Element_Access;
        erreur_code_intermediaire : exception;
    begin
        varDest := adresse_memoire(mem, instruction(1), instruction(7)).Code;
        valSource := adresse_memoire(mem, instruction(2), instruction(8)).Valeur; -- valeur de la variable source
        
        -- si le type de destination est différent du type source, alors on lève une exception
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
        varDest := adresse_memoire(mem, instruction(1), instruction(7)).Code; -- indice de la variable de destination dans la mémoire
        valSource1 := adresse_memoire(mem, instruction(2), instruction(8)).Valeur; -- valeur de la première variable source
        valSource2 := adresse_memoire(mem, instruction(4), instruction(9)).Valeur; -- valeur de la seconde variable source
        operateur := instruction(3); -- code de l'opétateur
        
        -- si les types des deux valeurs sources sont différents, alors on lève une exception
        if valSource1.Type_Element /= valSource2.Type_Element then
            raise erreur_code_intermediaire;
        else
            Executeur.operation(mem, varDest, valSource1, valSource2, operateur);
        end if;
        return cp + 1;
    end;
    
    function parametrer_lire_ecrire(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        var : Integer;
        operateur : Integer;
    begin
        var := adresse_memoire(mem, instruction(2), instruction(8)).Code; -- code de la variable à lire ou écrire
        operateur := instruction(1); -- opérateur valant -14 ou -15 pour lire ou écrire
        
        Executeur.lire_ecrire(mem, var, operateur);
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
            cp := parametrer_branchement(instruction);
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
        -- operation NULL
        elsif instruction(1) = -13 then
            cp := cp + 1;
        end if;
        
        return programme_fini(instruction);
        
    exception 
        when erreur_code_intermediaire =>
            raise erreur_code_intermediaire;
            return True;
    end;
    
end interpreteur;
