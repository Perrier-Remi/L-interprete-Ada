with Executeur; use Executeur;
with Memoire; use Memoire;

package body Interpreteur is

    function retourner_valeur(mem : in T_Memoire; variable : in Integer; const : in Integer) return Integer is
        valeur : Integer;
    begin 
        if const = 0 then
            valeur := Memoire.Renvoie_Variable(mem, variable).Valeur;   
        else
            valeur := variable;
        end if;
        return valeur;
    end;    
    
    function parametrer_branchement(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        valeur : Integer;
    begin
        valeur := retourner_valeur(mem, instruction(2), instruction(5));
        return Executeur.branchement(cp, valeur);
    end;   

    function parametrer_condition(mem : in T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        test : Integer;
        valeur : Integer;
    begin
        test := retourner_valeur(mem, instruction(2), instruction(5));
        valeur := retourner_valeur(mem, instruction(4), instruction(6));        
        return Executeur.condition(test, cp, valeur);
    end;

    function parametrer_affectation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource : Integer;
    begin
        varDest := instruction(1);
        valSource := retourner_valeur(mem, instruction(2), instruction(5));
        Executeur.affectation(mem, varDest, valSource);
        return cp + 1;
    end;

    function parametrer_operation(mem : in out T_Memoire; instruction : in T_Instruction; cp : in Integer) return Integer is
        varDest : Integer;
        valSource1 : Integer;
        valSource2 : Integer;
    begin
        varDest := instruction(1);
        valSource1 := retourner_valeur(mem, instruction(2), instruction(5));
        valSource2 := retourner_valeur(mem, instruction(4), instruction(6));
        Executeur.operation(mem, varDest, valSource1, valSource2, instruction(3));
        return cp + 1;
    end;

    function programme_fini(instruction : in T_Instruction) return Boolean is
    begin
        return instruction(1) = 0 and instruction(3) = 0;
    end;
    
    function executer_ligne(mem : in out T_Memoire; instruction : in T_Instruction; cp : in out Integer) return Boolean is
    begin
        -- branchement
        if instruction(1) = -2 then
            cp := parametrer_branchement(mem, instruction, cp);
        -- condition
        elsif instruction(1) = -1 and then instruction (3) = -2 then
            cp := parametrer_condition(mem, instruction, cp);
        -- affectation
        elsif instruction(1) > 0 and then instruction(3) = -12 then
            cp := parametrer_affectation(mem, instruction, cp);
        -- operation
        elsif instruction(3) < 0 then
            cp := parametrer_operation(mem, instruction, cp);
        end if;
        
        return programme_fini(instruction);
    end;
    
end Interpreteur;
