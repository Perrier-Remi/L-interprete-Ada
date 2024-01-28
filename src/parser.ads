WITH Ada.Text_IO , Ada.Strings.Unbounded, Memoire;
USE Ada.Text_IO , Ada.Strings.Unbounded, Memoire;

package Parser is
   ------------------------Cr√©ation des types ------------------------------------------------
   
<<<<<<< HEAD
   --Cr√©ation des types pour cr√©e le tableau d'instruction √©quivalent au programme
=======
   --CrÈation des types pour crÈe le tableau d'instruction Èquivalent au programme
>>>>>>> cf40a2f (parser ok)
   NB_INSTRUCTIONS : Constant Integer := 9;
   MAX_LIGNES_PROGRAMME : Constant Integer := 1000;
   type T_Instruction is array (1..NB_INSTRUCTIONS) of Integer;
   type T_Tab_Instruction is array (1..MAX_LIGNES_PROGRAMME) of T_Instruction;
   
   type T_Programme is record
         Tab_Instruction : T_Tab_Instruction; --tableau contenant les instructions
         Taille : Integer; --taille du tableau qui est d√©fini
   end record;
   
  
   procedure Lire_Fichier (nom_fichier : in String; Programme: out T_Programme; Ma_Memoire : out T_Memoire);
   
   
   procedure Renvoyer_Resultat_Programme (Programme : in T_Programme);


end Parser;
