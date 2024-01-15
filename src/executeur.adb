with Memoire; use Memoire;

package body executeur is
    
    function integer_value(input : in Boolean) return Integer is
    begin
        if input then
            return 1;
        else
            return 0;
        end if;
    end;

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
    
    procedure affectation (mem : in out T_Memoire; varDest : in integer; valeur : in integer) is
    begin
        Memoire.Affectation_Variable(varDest, valeur, mem);
    end;

    procedure operation(mem : in out T_Memoire; varDest : in Integer; valSource1 : in Integer; valSource2 : in Integer; operateur : in integer) is
        resultat : Integer;
    begin
        case operateur is
            when -3 => 
                resultat := valSource1 + valSource2;
            when -4 =>
                resultat := valSource1 - valSource2;
            when -5 =>
                resultat := valSource1 * valSource2;
            when -6 =>
                resultat := valSource1 / valSource2;
            when -7 =>
                resultat := integer_value(valSource1 = valSource2);
            when -8 =>
                resultat := integer_value(valSource1 < valSource2);
            when -9 =>
                resultat := integer_value(valSource1 > valSource2);
            when -10 =>                
                resultat := integer_value(valSource1 /= 0 or valSource2 /= 0);
            when -11 =>
                resultat := integer_value(valSource1 /= 0 and valSource2 /= 0);
            when others => 
                null;
        end case;
        Memoire.Affectation_Variable(varDest, resultat, mem);
    end;

end executeur;
