WITH Ada.Text_IO , Ada.Strings.Unbounded, Memoire;
USE Ada.Text_IO , Ada.Strings.Unbounded, Memoire;

package Parser is
   ------------------------Creation des types ------------------------------------------------
   
   --Creation des types pour cree le tableau d'instruction equivalent au programme

   --Creation des types pour cree le tableau d'instruction equivalent au programme
   NB_INSTRUCTIONS : Constant Integer := 9;
   MAX_LIGNES_PROGRAMME : Constant Integer := 1000;
   type T_Instruction is array (1..NB_INSTRUCTIONS) of Integer;
   type T_Tab_Instruction is array (1..MAX_LIGNES_PROGRAMME) of T_Instruction;
   
   type T_Programme is record
         Tab_Instruction : T_Tab_Instruction; --tableau contenant les instructions
         Taille : Integer; --taille du tableau qui est defini
   end record;
   
  
   procedure Lire_Fichier (nom_fichier : in String; Programme: out T_Programme; Ma_Memoire : out T_Memoire);
   
   
   procedure Renvoyer_Resultat_Programme (Programme : in T_Programme);


end Parser;
