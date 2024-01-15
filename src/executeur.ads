with Memoire; use Memoire;

package Executeur is

	-- Réaliser un branchement, mettre cp à la valeur souhaité 
	function branchement(valCp : in integer; nouveauCp : in integer) return Integer with
		Post => nouveauCp = valCp;


	-- tester la condition et appeler branchement cp si condition valide sinon exécuter la ligne suivante
    function condition (test : integer; valCp : in integer; nouveauCp : in integer) return Integer with
        Post => condition'Result > valCp;
    

    -- affecter une valeur à une variable
    procedure affectation (mem : in out T_Memoire; varDest : in integer; valeur : in integer) with
        Post => Renvoie_Variable(mem, varDest).Valeur = valeur;
    
    
    -- effectuer une opération avec deux valeurs sources et écrire le résultat dans une variable destination
    -- src1 et src2 sont des constantes
    procedure operation(mem : in out T_Memoire; varDest : in Integer; valSource1 : in Integer; valSource2 : in Integer; operateur : in integer);
    
    
    
end Executeur;
