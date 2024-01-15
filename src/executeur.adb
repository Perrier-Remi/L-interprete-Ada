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
    
    procedure affectation (memoire : in out T_Memoire; varDest : in integer; valeur : in integer) is
    begin
        Memoire.Affectation_Variable(varDest, valeur, memoire);
    end;

    procedure operation(memoire : in out T_Memoire; varDest : in Integer; valSource1 : in Integer; valSource2 : in Integer; operateur : in integer) is
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
                resultat := valSource1 = valSource2;
            when -8 =>
                resultat := valSource1 < valSource2;
            when -9 =>
                resultat := valSource1 > valSource2;
            when -10 =>
                resultat := valSource1 or valSource2;
            when -11 =>
                resultat := valSource1 and valSource2;
        end case;
        Memoire.Affectation_Variable(varDest, resultat, memoire);
    end;

end executeur;
