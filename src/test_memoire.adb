with Memoire; use Memoire;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Memoire is
   -- Déclarer une variable pour tester le package Memoire
   Ma_Memoire : T_Memoire;
   --Tab_Variable_Result : T_Tab_Variable;
   Ma_Variable_Result : T_Variable;

   -- Déclarer d'autres variables nécessaires pour les tests
   Code_Test_1 : constant Integer := 1;
   Valeur_Test_1 : constant Integer := 42;
   Nom_Test_1 : Unbounded_String := To_Unbounded_String("Variable_Test");
   Code_Test_2 : constant Integer := 2;
   Valeur_Test_2 : constant Integer := 26;
   Nom_Test_2 : Unbounded_String := To_Unbounded_String("Variable_B");


begin
   -- Initialiser Memoire
   Initialiser(Ma_Memoire);

   --Test taille mémoire
   Put_Line("Taille de T_Variable : " & Integer'Image(Renvoie_Taille(Ma_Memoire)));
   pragma Assert (Renvoie_Taille(Ma_Memoire) = 0);

   --Implementer deux variable
   Creer_Variable(Code_Test_1, Valeur_Test_1, Nom_Test_1, Ma_Memoire);
   Creer_Variable(Code_Test_2, Valeur_Test_2, Nom_Test_2, Ma_Memoire);

   --Test taille mémoire instancié
   Put_Line("Taille de T_Variable : " & Integer'Image(Renvoie_Taille(Ma_Memoire)));
   pragma Assert (Renvoie_Taille(Ma_Memoire) = 2);

   --Recupérer la variable de code 1
   Ma_Variable_Result := Renvoie_Variable(Ma_Memoire, Code_Test_1);
   pragma Assert (Ma_Variable_Result.Code = Code_Test_1);
   pragma Assert (Ma_Variable_Result.Valeur = Valeur_Test_1);
   pragma Assert (To_String(Ma_Variable_Result.Nom) = To_String(Nom_Test_1));

   --Modifier valeur variable code = 1
   Affectation_Variable(Code_Test_1, Valeur_Test_1 + 10, Ma_Memoire);

   --Recupérer tableau de Tab_Variable
   --Tab_Variable_Result := Renvoie_Tab_Variable(Ma_Memoire);

   -- Afficher le tableau de variable
   Afficher_Memoire (Ma_Memoire);
   --Put_Line("Affichage du tabeau des Variable :");
   --for I in 1..Renvoie_Taille(Ma_Memoire) loop
    --     Put_Line(" Variable " & Integer'Image(I) & " :");
    --     Put_Line("Code : " & Integer'Image(Tab_Variable_Result(I).Code));
    --     Put_Line("Valeur : " & Integer'Image(Tab_Variable_Result(I).Valeur));
    --     Put_Line("Nom : " & To_String(Tab_Variable_Result(I).Nom));
      --end loop;

   --Afficher le code max et donc aussi la taille de la mémoire
   New_Line;
   Put_Line("Le code max est"& Integer'Image(Renvoie_Code_Max(Ma_Memoire)));
   pragma Assert (Renvoie_Code_Max(Ma_Memoire) = 2);

end Test_Memoire;
