WITH Ada.Text_IO ; USE Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
WITH Parser; USE Parser;
with Memoire; use Memoire;

procedure test_parser is
   Programme_1 : T_Programme;
   Memoire1 : T_Memoire;
   Programme_2 : T_Programme;
   Memoire2 : T_Memoire;
   Last : Integer;
   Choix : String(1..128);

   procedure test_code_factoriel (Programme_1 : in out T_Programme; Memoire1 : in out T_Memoire) is
      begin
      Lire_Fichier("code_inter_facto.txt", Programme_1, Memoire1);
      --Lire_Fichier("bbu.txt", Programme_1, Memoire1);
      --test initialisation de variable
      pragma assert ( Programme_1.Tab_Instruction(1) = (1,7,0,0,0,0,0,0,0), "ligne 1 fausse");
      pragma assert ( Programme_1.Tab_Instruction(2) = (2,8,0,0,0,0,0,0,0), "ligne 2 fausse" );
      --test If et GOTO avec label
      pragma assert ( Programme_1.Tab_Instruction(7) = (-1,6,-2,9,0,1,0,0,0), "ligne 7 fausse L1 IF T3 GOTO L3 ");
      pragma assert ( Programme_1.Tab_Instruction(8) = (-2,15,0,0,1,0,0,0,0), "ligne 8 fausse GOTO L2 ");
      --test affectation
      pragma assert ( Programme_1.Tab_Instruction(9) = (3,3,-5,2,0,0,0,0,0), "ligne 9 fausse L3 Fact <- Fact * i" );
      pragma assert ( Programme_1.Tab_Instruction(12) = (5,2,-7,1,0,0,0,0,0), "ligne 12 fausse T2 <- i = n" );
   end test_code_factoriel;

   procedure test_parser (Programme_2 : in out T_Programme; Memoire2 : in out T_Memoire) is
      begin
      Lire_Fichier("code_test_parser.txt", Programme_2, Memoire2);
      --test initialisation de variable
      pragma assert ( Programme_2.Tab_Instruction(1) = (1,16,0,0,0,0,0,0,0), "ligne 1 fausse" );
      pragma assert ( Memoire2.Tab_var(3).Valeur.Valeur_Caractere = 'a', "erreur affectaction variable caractere_1");
      pragma assert ( Programme_2.Tab_Instruction(10) = (5,20,0,0,0,0,2,0,0), "ligne 10 fausse L3 Tab1(2) <- 2");

      --test sur chaine de caratere
      pragma assert ( Programme_2.Tab_Instruction(4) = (2,4,-7,18,0,0,0,0,0), "T1 <- chaine_test = je suis un test ");
      --pragma assert ( Programme_1.Tab_Instruction(8) = (-2,15,0,0,1,0), "ligne 8 fausse GOTO L2 ");
      --test affectation
      --pragma assert ( Programme_1.Tab_Instruction(9) = (3,3,-5,2,0,0), "ligne 9 fausse L3 Fact <- Fact * i" );
      --pragma assert ( Programme_1.Tab_Instruction(12) = (5,2,-7,1,0,0), "ligne 12 fausse T2 <- i = n" );
   end test_parser;

begin
   Put_Line("    ----- Test Parser ada -----");
   Put_Line("Tester le parser quel fichier de test voulez-vous utiliser ?");
   Put_Line(" Choix 1 : Fichier de Test de la factoriel");
   Put_Line(" Choix 2 : Fichier de Test du parser (code_test_parser.txt");
   Put("Votre choix : ");
   Get_Line(choix, last);
   while (last /= 1) or else ((choix(1) /= '1') and then (choix(1) /= '2')) loop
            Put("Choix invalide, nouveau choix : ");
            Get_Line(choix, last);
   end loop;
   New_Line;
   if choix(1) = '1' then
          test_code_factoriel (Programme_1, Memoire1);

          Afficher_Memoire (Memoire1);
          Renvoyer_Resultat_Programme (Programme_1);
       else
       test_parser (Programme_2, Memoire2);
       Afficher_Memoire (Memoire2);
       Renvoyer_Resultat_Programme (Programme_2);
       null;
   end if;
   New_Line;
   Put_Line ("Un Fichier Resultat_Programme.txt a été crée avec les codes des instructions correspondant au Programme en sortie du parser. ");
   --Lire_Fichier("code_test_tab.txt", Programme_1, Memoire1);
   --Afficher_Memoire (Memoire1);
   --Renvoyer_Resultat_Programme (Programme_1);
end test_parser;
