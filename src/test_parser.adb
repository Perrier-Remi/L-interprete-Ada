WITH Ada.Text_IO ; USE Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
WITH Parser; USE Parser;
with Memoire; use Memoire;

procedure test_parser is
   Programme_1 : T_Programme;
   Memoire1 : T_Memoire;
   Programme_2 : T_Programme;
   Memoire2 : T_Memoire;

   procedure test_code_factoriel (Programme_1 : in out T_Programme; Memoire1 : in out T_Memoire) is
      begin
      Lire_Fichier("code_inter_facto.txt", Programme_1, Memoire1);
      --Lire_Fichier("bbu.txt", Programme_1, Memoire1);
      --test initialisation de variable
      pragma assert ( Programme_1.Tab_Instruction(1) = (1,7,0,0,0,0), "ligne 1 fausse");
      pragma assert ( Programme_1.Tab_Instruction(2) = (2,8,0,0,0,0), "ligne 2 fausse" );
      --test If et GOTO avec label
      pragma assert ( Programme_1.Tab_Instruction(7) = (-1,6,-2,9,0,1), "ligne 7 fausse L1 IF T3 GOTO L3 ");
      pragma assert ( Programme_1.Tab_Instruction(8) = (-2,15,0,0,1,0), "ligne 8 fausse GOTO L2 ");
      --test affectation
      pragma assert ( Programme_1.Tab_Instruction(9) = (3,3,-5,2,0,0), "ligne 9 fausse L3 Fact <- Fact * i" );
      pragma assert ( Programme_1.Tab_Instruction(12) = (5,2,-7,1,0,0), "ligne 12 fausse T2 <- i = n" );
   end test_code_factoriel;

   procedure test_parser (Programme_2 : in out T_Programme; Memoire2 : in out T_Memoire) is
      begin
      Lire_Fichier("code_test_parser.txt", Programme_2, Memoire2);
      --test initialisation de variable
      --pragma assert ( Programme_1.Tab_Instruction(1) = (1,7,0,0,0,0), "ligne 1 fausse");
      --pragma assert ( Programme_1.Tab_Instruction(2) = (2,8,0,0,0,0), "ligne 2 fausse" );
      --test If et GOTO avec label
      --pragma assert ( Programme_1.Tab_Instruction(7) = (-1,6,-2,9,0,1), "ligne 7 fausse L1 IF T3 GOTO L3 ");
      --pragma assert ( Programme_1.Tab_Instruction(8) = (-2,15,0,0,1,0), "ligne 8 fausse GOTO L2 ");
      --test affectation
      --pragma assert ( Programme_1.Tab_Instruction(9) = (3,3,-5,2,0,0), "ligne 9 fausse L3 Fact <- Fact * i" );
      --pragma assert ( Programme_1.Tab_Instruction(12) = (5,2,-7,1,0,0), "ligne 12 fausse T2 <- i = n" );
   end test_parser;

begin
   --test_code_factoriel (Programme_1, Memoire1);
   test_parser (Programme_2, Memoire2);
   --pragma Assert (To_String(Memoire1.Tab_var().Valeur.Valeur_Chaine) = "bufeeb", );
   Afficher_Memoire (Memoire2);
   Renvoyer_Resultat_Programme (Programme_2);
   --Put_Line (Integer'Image(Programme_1.Taille));
end test_parser;
