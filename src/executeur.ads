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
    
    
    -- effectuer une opération avec deux variables sources et écrire le résultat dans une variable destination
    -- src1 et src2 peuvent représenter une variable ou une constante
    -- src1 est une constante si src1Const est vrai (1) sinon (0) src1 représente une variable, pareil pour src2
    procedure operation(memoire : in out T_Memoire; varDest : in Integer; src1 : in Integer; src2 : in Integer; operateur : in integer; src1Const : in integer; src2Const : in integer);
    
    
    
end Executeur;
