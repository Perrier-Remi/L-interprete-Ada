with Executeur; use Executeur;
with Memoire; use Memoire;

package body Interpreteur is

    function retourner_valeur(memoire : in T_Memoire; variable : in Integer; const : in Integer) return Integer is
        valeur : Integer;
    begin 
        if const = 0 then
            valeur := Memoire.Renvoie_Variable(Memoire, variable);   
        else
            valeur := variable;
        end if;
    end;    
    
    function parametrer_branchement(memoire : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        valeur : Integer;
    begin
        valeur := retourner_valeur(memoire, instruction(2), instruction(5));
        return Executeur.branchement(cp, valeur);
    end;   

    function parametrer_condition(memoire : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        test : Integer;
        valeur : Integer;
    begin
        test := retourner_valeur(memoire, instruction(2), instruction(5));
        valeur := retourner_valeur(memoire, instruction(4), instruction(6));        
        return Executeur.condition(test, cp, valeur);
    end;

    function parametrer_affectation(memoire : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource : Integer;
    begin
        valSource := retourner_valeur(memoire, instruction(2), instruction(5));
        Executeur.affectation(memoire, varDest, valSource);
        return cp + 1;
    end;

    function parametrer_operation(memoire : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource1 : Integer;
        valSource2 : Integer;
    begin
        valSource1 := retourner_valeur(memoire, instruction(2), instruction(5));
        valSource2 := retourner_valeur(memoire, instruction(4), instruction(6));
        Executeur.operation(memoire, varDest, valSource1, valSource2, instruction(3));
        return cp + 1;
    end;

    function programme_fini(instruction : in T_Instruction) return Boolean is
    begin
        return instruction(1) = 0 and instruction(3) = 0;
    end;
    
    function executer_ligne(instruction : in T_Instruction; cp : in out Integer) return Integer is
        test : Integer;
        var1 : Integer;
        var2 : Integer;
        fin_programme : Integer;
    begin
        
        if (programme_fini) then
            fin_programme := 1;
        else
            fin_programme := 0;
        end if;

        -- branchement
        if instruction(1) = -2 then
            cp := parametrer_branchement(instruction, cp);
        -- condition
        elsif instruction(1) = -1 and instruction (3) = -2 then
            cp := parametrer_condition(instruction, cp);
        -- affectation
        elsif instruction(1) = -1 and instruction (3) = -2 then
            cp := parametrer_affectation(instruction, cp);
        -- operation
        elsif instruction(3) < 0 then
            cp := parametrer_operation(instruction, cp);
        end if;
        
    end;
    
end Interpreteur;
