with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
		V := null;
	end Initialiser;


	procedure Detruire (V: in out T_Vecteur_Creux) is
	begin
        Free(V);
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		return V = null;	-- TODO : à changer
	end Est_Nul;


    function Composante (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
    begin
        if V = Null then
            return -1.0;
        elsif V.all.Indice = Indice then
            return V.all.Valeur;
        else
            return Composante_Recursif (V.all.Suivant, Indice);
        end if;
    end Composante;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer ;
                     Valeur : in Float ) is
        VCour : T_Vecteur_Creux;
        VPrec : T_Vecteur_Creux;
    begin
        VPrec := null;
        VCour := V;

        while (VCour /= null and then VCour.all.Indice < Indice) loop
            VPrec := VCour;
            VCour := VCour.all.Suivant;
        end loop;

        if (VPrec = null) then
            V := new T_Cellule'(Indice, Valeur, null);
        elsif (VCour = null) then
            VPrec.all.Suivant := new T_Cellule'(Indice, Valeur, null);
        elsif VCour.all.Indice > Indice then
            VPrec.all.Suivant := new T_Cellule'(Indice, Valeur, VCour);
        else
            VCour.all.Valeur := Valeur;
        end if;
    end Modifier;



	function Sont_Egaux (V1, V2 : in T_Vecteur_Creux) return Boolean is
	begin
        if (V1 = null and V2 = null) then
            return True;
        elsif (V1 /= null and V2 /= null) then
            return V1.Valeur = V2.Valeur and
                   V1.Indice = V2.Indice and
                    Sont_Egaux_Recursif (V1.Suivant, V2.Suivant);
        else
            return False;
        end if;
	end Sont_Egaux;


	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;


end Vecteurs_Creux;
