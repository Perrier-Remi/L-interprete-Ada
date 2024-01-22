WITH Ada.Text_IO , Ada.Strings.Unbounded, Memoire;
USE Ada.Text_IO , Ada.Strings.Unbounded, Memoire;

package Parser is
   ------------------------Création des types ------------------------------------------------
   
   --Création des types pour crée le tableau d'instruction équivalent au programme
   NB_INSTRUCTIONS : Constant Integer := 6;
   MAX_LIGNES_PROGRAMME : Constant Integer := 1000;
   type T_Instruction is array (1..NB_INSTRUCTIONS) of Integer;
   type T_Tab_Instruction is array (1..MAX_LIGNES_PROGRAMME) of T_Instruction;
   
   type T_Programme is record
         Tab_Instruction : T_Tab_Instruction; --tableau contenant les instructions
         Taille : Integer; --taille du tableau qui est défini
   end record;
   
   --Création des Variables utilisé pour la correspondance entre le nom de variable est le code (position dans la liste).
   MAX_NB_VARIABLES : Constant Integer := 100;
   
   type T_Tab_Nom_Variable is array (1..MAX_NB_VARIABLES) of Unbounded_String;
   
   type T_Correspondance_Variable is record
         Tab_Nom_Variabe : T_Tab_Nom_Variable; --tableau contenant les noms 
         Taille : Integer; --taille du tableau qui est défini
   end record;
   
   type T_Split_String_Tab is array (1..100) of Unbounded_String;
   
   type T_Split_String is record
      Tab_Split_String : T_Split_String_Tab;
      Taille : Integer;
   end record;
   
   ----------------------------------------------------------------------------
  
   procedure Lire_Fichier (nom_fichier : in String; Programme: out T_Programme;Correspondance_Variable : out T_Correspondance_Variable; Ma_Memoire : out T_Memoire);
   
   
   procedure Renvoyer_Resultat_Programme (Programme : in T_Programme);


end Parser;
