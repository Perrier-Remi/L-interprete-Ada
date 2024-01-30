with Memoire; use Memoire;

package Executeur is

    erreur_code_intermediaire : exception;
    
	-- Réaliser un branchement, mettre cp à la valeur souhaité 
    function branchement(nouveauCp : in integer) return Integer with
        Post => branchement'Result = nouveauCp;

	-- Tester la condition et appeler branchement cp si condition valide sinon exécuter la ligne suivante
    function condition (test : integer; valCp : in integer; nouveauCp : in integer) return Integer with
        Post => condition'Result > valCp;

    -- Affecter une valeur à une variable
    procedure affectation (mem : in out T_Memoire; varDest : in integer; valeur : in T_Element_Access) with
        Post => Memoire.Renvoie_Variable(mem, varDest).Valeur = valeur;
    
    -- Effectuer une opération entre deux valeurs sources et écrire le résultat dans la variable destination
    procedure operation(mem : in out T_Memoire; varDest : in Integer; valSource1 : in T_Element_Access; valSource2 : in T_Element_Access; operateur : in integer) with
        Pre => valSource1.Type_Element = valSource2.Type_Element;
    
    procedure lire_ecrire(mem : in out T_Memoire; var : in Integer; operateur : in Integer) with
        Pre => Memoire.Renvoie_Variable(mem, var).Valeur.Type_Element = Caractere or Memoire.Renvoie_Variable(mem, var).Valeur.Type_Element = Entier;
    
end Executeur;
