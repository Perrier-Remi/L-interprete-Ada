with Memoire; use Memoire;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Memoire is
   -- D�clarer une variable pour tester le package Memoire
   Ma_Variable : T_Variable;
   Tab_Variable_Result : T_Tab_Variable;
   Ma_Variable_Result : T_Donee_Variable;

   -- D�clarer d'autres variables n�cessaires pour les tests
   Code_Test_1 : constant Integer := 1;
   Valeur_Test_1 : constant Integer := 42;
   Nom_Test_1 : Unbounded_String := To_Unbounded_String("Variable_Test");
   Code_Test_2 : constant Integer := 2;
   Valeur_Test_2 : constant Integer := 26;
   Nom_Test_2 : Unbounded_String := To_Unbounded_String("Variable_B");


begin
   -- Initialiser Memoire
   Initialiser(Ma_Variable);

   --Test taille m�moire
   Put_Line("Taille de T_Variable : " & Integer'Image(Renvoie_Taille(Ma_Variable)));
   pragma Assert (Renvoie_Taille(Ma_Variable) = 0);

   --Implementer deux variable
   Creer_Variable(Code_Test_1, Valeur_Test_1, Nom_Test_1, Ma_Variable);
   Creer_Variable(Code_Test_2, Valeur_Test_2, Nom_Test_2, Ma_Variable);

   --Test taille m�moire instanci�
   Put_Line("Taille de T_Variable : " & Integer'Image(Renvoie_Taille(Ma_Variable)));
   pragma Assert (Renvoie_Taille(Ma_Variable) = 2);

   --Recup�rer la variable de code 1
   Ma_Variable_Result := Renvoie_Variable(Code_Test_1, Ma_Variable);
   pragma Assert (Ma_Variable_Result.Code = Code_Test_1);
   pragma Assert (Ma_Variable_Result.Valeur = Valeur_Test_1);
   pragma Assert (To_String(Ma_Variable_Result.Nom) = To_String(Nom_Test_1));

   --Modifier valeur variable code = 1
   Affectation_Variable(Code_Test_1, Valeur_Test_1 + 10, Ma_Variable);

   --Recup�rer tableau de Tab_Variable
   Tab_Variable_Result := Renvoie_Tab_Variable(Ma_Variable);

   -- Afficher le tableau de variable
   Put_Line("Affichage du tabeau des Variable :");
   for I in 1..Renvoie_Taille(Ma_Variable) loop
         Put_Line("Variable " & Integer'Image(I) & " :");
         Put_Line("Code : " & Integer'Image(Tab_Variable_Result(I).Code));
         Put_Line("Valeur : " & Integer'Image(Tab_Variable_Result(I).Valeur));
         Put_Line("Nom : " & To_String(Tab_Variable_Result(I).Nom));
      end loop;

   --Afficher le code max et donc aussi la taille de la m�moire
   Put_Line("Le code max est"& Integer'Image(Renvoie_Code_Max(Ma_Variable)));
   pragma Assert (Renvoie_Code_Max(Ma_Variable) = 2);

end Test_Memoire;
