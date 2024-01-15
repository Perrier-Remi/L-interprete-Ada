package body executeur is

    function branchement(valCp : in integer; nouveauCp : in integer) return Integer is
    begin
        null;
        return 0;
    end;
   
    function condition (test : integer; valCp : in integer; nouveauCp : in integer) return integer is
    begin
        null;
        return 0;
    end;
    
    procedure affectation (memoire : in out T_Memoire; variable : in integer; valeur : in integer) is
    begin
        null;
    end;

    procedure operation(memoire : in out T_Memoire; varDest : in Integer; src1 : in Integer; src2 : in Integer; operateur : in integer; src1Const : in integer; src2Const : in integer) is
    begin
        null;
    end;

end executeur;
