with Memoire; use Memoire;

package Executeur is

	-- Réaliser un branchement, mettre cp à la valeur souhaité 
	function branchement(valCp : in integer; nouveauCp : in integer) return Integer with
		Post => nouveauCp = valCp;


	-- tester la condition et appeler branchement cp si condition valide sinon exécuter la ligne suivante
    function condition (test : integer; valCp : in integer; nouveauCp : in integer) return integer with
        Post => test /= 0  and (valCp = nouveauCp);
    

    -- affecter une valeur à une variable
    procedure affectation (memoire : in out T_Memoire; variable : in integer; valeur : in integer) with
        Post => Renvoie_Variable(memoire, variable).Valeur = valeur;
    
    
    -- effectuer une opération avec deux valeurs sources et écrire le résultat dans une variable destination
    -- src1 et src2 sont des constantes
    procedure operation(memoire : in out T_Memoire; varDest : in Integer; src1 : in Integer; src2 : in Integer; operateur : in integer);
    
    
    
end Executeur;
