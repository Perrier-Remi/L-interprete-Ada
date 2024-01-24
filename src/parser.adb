with Ada.Text_IO; use Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
with Memoire; Use Memoire;

package body Parser is

   ----------------Création des variables interne au package ----------------
   
 ------ Création des Variables utilisé pour la correspondance entre le nom de variable est le code (position dans la liste). -------
   MAX_NB_VARIABLES : Constant Integer := 100;
   
   type T_Tab_Nom_Variable is array (1..MAX_NB_VARIABLES) of Unbounded_String;
   
   type T_Correspondance_Variable is record
         Tab_Nom_Variabe : T_Tab_Nom_Variable; --tableau contenant les noms 
         Taille : Integer; --taille du tableau qui est défini
   end record;
   
   ------ Type de données utilisées pour stockées les chaines de caractères en sortie du split
   MAX_NB_MOT_SPLIT : Constant Integer := 100;
   
   type T_Split_String_Tab is array (1..MAX_NB_MOT_SPLIT) of Unbounded_String;
   
   type T_Split_String is record
      Tab_Split_String : T_Split_String_Tab;
      Taille : Integer;
   end record;
   
   --- Type de données utilisées pour stocker les labels ainsi que leur position dans le fichier ------------
   
   MAX_NB_LABEL : Constant Integer := 100;
   
    type T_Donnee_Label is record
         Nom : Unbounded_String; --Nom du label
      Ligne : Integer; --Ligne ou se trouve le label
      Position : Integer; -- Position du label
   end record;
   
   type T_Tab_Label is array (1..MAX_NB_LABEL) of T_Donnee_Label; --Taille du tableau défini arbitrairement -- Tableau de donnée de Label
   
   type T_Label is record
         Tab_label : T_Tab_Label; --tableau contenant les labels
         Taille : Integer; --taille du tableau qui est défini
   end record;
   
   type T_Position_Label is record
      Ligne : Integer;
      Indice : Integer;
      Etat : Integer; --permet de savoir l'etat (ETAT : 0 Correspondance label non trouvé  / Etat : 1 Variable / Etat : 2 Correspondance Label trouvé)
   end record;
   
   
   ----------- Fin définition package -----------------
   

   
   ----------------------------------------------------------- Fonction interne au package ------------------ 
   
   ----------------------------------------Initialiser les types nécessaires ---------
   
------------ Instancier le Tableau d'Intruction ----------------
   
   function Creer_Tab_Instruction return T_Tab_Instruction is
        Tab_Instruction : T_Tab_Instruction := (others => (others => 0));
   begin
      return Tab_Instruction;
   end Creer_Tab_Instruction;
   
   procedure Initialiser_Programme (Programme : out T_Programme) is
   begin
      Programme.Taille := 0;
      Programme.Tab_Instruction := Creer_Tab_Instruction;
   end Initialiser_Programme;
   
   ---------------- Initialiser le tableau pour les correspondance de variable -------------------------
   
   function Creer_Tab_Nom_Var return T_Tab_Nom_Variable is
        Tab_Nom_Var: T_Tab_Nom_Variable := (others => To_Unbounded_String(""));
   begin
      return Tab_Nom_Var;
   end Creer_Tab_Nom_Var;
   
   procedure Initialiser_Correspondance_Var (Correspondance_Var : out T_Correspondance_Variable) is
   begin
      Correspondance_Var.Taille := 0;
      Correspondance_Var.Tab_Nom_Variabe := Creer_Tab_Nom_Var;
   end Initialiser_Correspondance_Var;
   
   -------------- Initialiser le type pour la fonction split -------------------
   function Creer_Tab_Split_String return T_Split_String_Tab is
        Split_String_Tab : T_Split_String_Tab := (others => To_Unbounded_String(""));
   begin
      return Split_String_Tab;
   end Creer_Tab_Split_String;
   
   
   procedure Initialiser_T_Split_String  (Split : out T_Split_String) is
   begin
      Split.Taille := 0;
      Split.Tab_Split_String := Creer_Tab_Split_String;
   end Initialiser_T_Split_String;
   
   -------------- Initialiser le type pour les labels ------------------
   
   
   function Creer_Tab_label return T_Tab_Label is
        Label : T_Tab_Label := (others => (Nom => To_Unbounded_String(""), Ligne => 0, Position => 1));
   begin
      return Label;
   end Creer_Tab_label;
   
   
   procedure Initialiser_Label  (Label : out T_Label) is
   begin
      Label.Taille := 0;
      Label.Tab_label := Creer_Tab_label;
   end Initialiser_Label;
   
   
   ----- Fin Initialiser le type pour les labels ------------------------
   

   function Split_String(input : in String) return T_Split_String is
        index_tab : Integer := 1;
        index_str : Integer := 1;
        longueur_str : Integer;
        splited_string : T_Split_String;
        mot_courrant : Unbounded_String;
   begin
      Initialiser_T_Split_String (splited_string); 
        longueur_str := input'Last;
        mot_courrant := To_Unbounded_String("");
        while index_str <= longueur_str loop
            if input(index_str) = ' ' then
            splited_string.Tab_Split_String(index_tab) := mot_courrant;
            splited_string.Taille := splited_string.Taille +1;
                mot_courrant := To_Unbounded_String("");
                index_tab := index_tab + 1;
            else
                Append(mot_courrant, input(index_str));
            end if;
            index_str := index_str + 1;
      end loop;
      splited_string.Tab_Split_String(index_tab) := mot_courrant;
      splited_string.Taille := splited_string.Taille +1;
      
      return splited_string;
    end Split_String;
     
   

   
   procedure Instancier_Variable (ligne : in String; Correspondance_Var : in out T_Correspondance_Variable; Ma_Memoire : in out T_Memoire) is 
      
      Tab_ligne : T_Split_String;
      Indice : Integer;
      Nom_var : Unbounded_String;
      Etat : Integer := 0;
      Ancien_Taille_Instancier : Constant Integer := Correspondance_Var.Taille;
      
   begin
      Tab_ligne := Split_String (ligne); --split la ligne afin de récupérer les différents mots 
      -- Parcourir le tableau résultant pour traiter chaque mot.
                                         
      for i in 1..Tab_ligne.Taille loop
         -- Test pour reconnaitre les ':' qui signifie que nous avons les noms de variables avant et le type après
         if To_String(Tab_ligne.Tab_Split_String(i)) = ":" then 
            Etat := 1;
            Indice := i; -- recuperer de l'indice du caractère ':'
            Correspondance_Var.Taille :=  Correspondance_Var.Taille + (i-1); --augmenter la taille pour les variables instanciers
            if To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Entier" or To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Booleen" then --Test pour connaitre le type des variables
               for y in (Ancien_Taille_Instancier+1)..(Correspondance_Var.Taille) loop
                  Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), Correspondance_Var.Tab_Nom_Variabe(y), False, Ma_Memoire);
               end loop;
            end if ;
         -- Recherche '<-' pour rechercher une potentiel affectation.  
         elsif To_String(Tab_ligne.Tab_Split_String(i)) = "<-" then
            if To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Entier" or To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Booleen" then --Test pour connaitre le type des variables à affecter
               for y in (Ancien_Taille_Instancier+1)..(Correspondance_Var.Taille) loop
                  Affectation_Variable(y, new T_Element'(Type_Element => Entier, Valeur_Entier => Indice + 1), Ma_Memoire);
               end loop;
            end if;
         else
            null;
         end if;
         
         -- Si Etat = 0 alors on instancie correspondcance Nom Variable   
         if Etat = 0 then --recup nom variable et instancier correspondance entre nom et code
               Nom_var := Tab_ligne.Tab_Split_String(i);
            --Enlever la virgule en dernier caractère si elle est présente
            if To_String(Nom_var)(To_String(Nom_var)'Length) = ',' then 
               -- enlever le dernier caractere
               Nom_var := To_Unbounded_String(To_String(Nom_var)(1 .. To_String(Nom_var)'Length - 1));
            end if;
            -- Instancié le tableau   
            Correspondance_Var.Tab_Nom_Variabe(i+Correspondance_Var.Taille) := Nom_var;
            --Put_Line (To_String(Nom_var));
         end if;
                 
      end loop;
         
   end Instancier_Variable;
   
   
   function Est_Variable ( Correspondance_Variable : in T_Correspondance_Variable; Variable : in String) return Integer is
      Result : Integer := 0;
   begin
      --parcourir le tableau de variable pour voir si variable est dedans
       for i in 1..Correspondance_Variable.Taille loop
            if Variable = To_String(Correspondance_Variable.Tab_Nom_Variabe(i)) then 
               Result := i;
            end if;
      end loop;
      return Result;
   end Est_Variable;
   
   
   
   procedure Check_Variable (Tab_Instru : in out T_Instruction; Correspondance_Variable : in T_Correspondance_Variable; Memoire : in out T_Memoire; Variable : in String; Indice : in out Integer) is 
      Nombre : Integer;
      Result : Integer;
      Nom_Var : Unbounded_String;
   begin
      Result := Est_Variable (Correspondance_Variable, Variable);
      if Result > 0 then 
         Tab_Instru(Indice) := Result;
         Indice := Indice + 1;
         
      else
         Nombre :=  Integer'Value(Variable);
         Nom_Var := To_Unbounded_String("Var_Prog" & Integer'Image(Memoire.Taille+1));
         Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => Nombre), Nom_Var , True, Memoire);
         Tab_Instru(Indice) := Memoire.Taille; 
     end if;
      
      
   exception
      when CONSTRAINT_ERROR =>
         null;
           
      
   end Check_Variable;
      
   
   procedure Check_Label (Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Label : in String; Position_Label : in out T_Position_Label; Correspondance_Variable : in T_Correspondance_Variable ) is 
      Nombre : Integer;
      Val : Character;
      Result : Integer;
      
   begin
      -- test pour savoir s'il s'agit d'une variable 
      Result := Est_Variable (Correspondance_Variable, Label);
      -- Si result > 0 alors Label est une variable donc
      if Result > 0 then 
         Position_Label.Indice := Result;
         Position_Label.Etat := 1; -- signifie que Label est une variable
      end if;
      
      if Position_Label.Etat = 0 then
         -- Test pour savoir s'il s'agit d'un label commence par L et fini par un entier 
         Val := Label(Label'Last);
         Nombre := Character'Pos(Val);
         
         Label_Ligne.Taille := Label_Ligne.Taille +1;
         Label_Ligne.Tab_label(Label_Ligne.Taille).Nom :=To_Unbounded_String(Label);
         Label_Ligne.Tab_label(Label_Ligne.Taille).Ligne := Position_Label.Ligne;
         
         --Test pour savoir si le label est déjà référencé. 
         for i in 1..Label_GOTO.Taille loop
            if To_String(Label_GOTO.Tab_label(i).Nom) = Label then
               Position_Label.Ligne := Label_GOTO.Tab_label(i).Ligne;
               Position_Label.Indice := Label_GOTO.Tab_label(i).Position;
               Position_Label.Etat := 2;
            end if;
         end loop;
      end if;
      
        
   exception
      when CONSTRAINT_ERROR =>
         null;
   end Check_Label;
   
   procedure Goto_Label (Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Label : in String; Positon_Label : in out T_Position_Label; Correspondance_Variable : in T_Correspondance_Variable) is
      Nombre : Integer;
      Valeur : Character; 
      Result : Integer;
   begin
      -- test pour savoir s'il s'agit d'une variable 
      Result := Est_Variable (Correspondance_Variable, Label);
      -- Si result > 0 alors Label est une variable donc
      if Result > 0 then 
         Positon_Label.Indice := Result; -- signifie que Label est une variable
         Positon_Label.Etat := 1;
      end if;
      if Positon_Label.Etat = 0 then 
         Valeur := Label(Label'Last); --test si le caractére est un entier 
         Nombre := Character'Pos(Valeur);
      
         Label_GOTO.Taille := Label_GOTO.Taille + 1;
         Label_GOTO.Tab_label(Label_GOTO.Taille).Nom := To_Unbounded_String(Label);
         Label_GOTO.Tab_label(Label_GOTO.Taille).Ligne := Positon_Label.Ligne;
         Label_GOTO.Tab_label(Label_GOTO.Taille).Position := Positon_Label.Indice;
      
         for i in 1..Label_Ligne.Taille loop
            if To_String(Label_Ligne.Tab_label(i).Nom) = Label then
               Positon_Label.Ligne := Label_Ligne.Tab_label(i).Ligne;
               Positon_Label.Etat := 2;
            end if;
         end loop;
      end if;
      
      exception
      when CONSTRAINT_ERROR =>
         null;
   end Goto_Label;
   
   
   
   procedure Convertir_Instruction (Programme : in out T_Programme; Ligne_Split : in T_Split_String; Correspondance_Variable : in T_Correspondance_Variable; Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Memoire : in out T_Memoire) is 
      
      Indice : Integer := 1;
      Tab_Instru : T_Instruction := Programme.Tab_Instruction(Programme.Taille); --récupérer le tableau d'entier correspond à la ligne (tableau de 0)
      Position_Label : T_Position_Label;
   begin
      Position_Label.Ligne := 0;
      Position_Label.Indice := 0;
      Position_Label.Etat := 0;
      
      for i in 1..Ligne_Split.Taille loop
         
         if To_String(Ligne_Split.Tab_Split_String(i)) = "IF" then
            Tab_Instru(Indice) := -1;
            Indice := Indice +1;
            
         elsif To_String(Ligne_Split.Tab_Split_String(i)) = "GOTO" then
            Tab_Instru(Indice) := -2;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "+" or To_String(Ligne_Split.Tab_Split_String(i)) = "&" then
            Tab_Instru(Indice) := -3;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "-" then
            Tab_Instru(Indice) := -4;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "*" then 
            Tab_Instru(Indice) := -5;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "/" then 
            Tab_Instru(Indice) := -6;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "=" then
            Tab_Instru(Indice) := -7;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "<" then
            Tab_Instru(Indice) := -8;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = ">" then
            Tab_Instru(Indice) := -9;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "OR" then
            Tab_Instru(Indice) := -10;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "AND" then
            Tab_Instru(Indice) := -11;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "NOPB" then
            Tab_Instru(Indice) := -12;
            Indice := Indice +1;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "NULL" then
            Tab_Instru(Indice) := -13;
            Indice := Indice +1;
            
         -- Si le mot commence par 1 et qu'il est en première position de la ligne. 
         elsif To_String(Ligne_Split.Tab_Split_String(i))(1) = 'L' and Indice = 1  then
            -- Appelle de la fonctionn Check_Label pour rechercher une correspondance avec un label déjà référencé. 
            Position_Label.Ligne := Programme.Taille;
            Position_Label.Indice := Indice;
            Position_Label.Etat := 0;
            
            Check_Label (Label_Ligne, Label_GOTO, To_String(Ligne_Split.Tab_Split_String(i)), Position_Label, Correspondance_Variable);
            
            -- Si la procédure a renvoyé un numéro de ligne et une position. Elle a donc trouvé une correspondance avec un autre label déjà référebncé.    
            if Position_Label.Etat = 2 then 
               Programme.Tab_Instruction(Position_Label.Ligne)(Position_Label.Indice) := Programme.Taille;
               --Ajout du 1 pour indiqué qu'il s'agit d'une constante et non d'une variable
               if Position_Label.Indice = 2 then --si la constante est en 2 position
                  Programme.Tab_Instruction(Position_Label.Ligne)(5) := 1 ;
               elsif Position_Label.Indice = 4 then --si la constante est en 4 position
                  Programme.Tab_Instruction(Position_Label.Ligne)(6) := 1 ;
               else
                  null;
               end if;
            elsif Position_Label.Etat = 1 then
                  Tab_Instru(Indice) := Position_Label.Indice;
               Indice := Indice + 1;
            else 
               null;
            end if;
            
         elsif To_String(Ligne_Split.Tab_Split_String(i)) = "FIN" then
            null; --tableau de (0, 0, 0, 0, 0, 0) déjà défini
            
         -- Si le mot commence par L et que le mot précédent était un GOTO (-2)
         elsif To_String(Ligne_Split.Tab_Split_String(i))(1) = 'L' and then Tab_Instru(Indice-1) = -2 then
            --Appelle de la fonction Goto_Label
            Position_Label.Ligne := Programme.Taille;
            Position_Label.Indice := Indice;
            Position_Label.Etat := 0;
            
            Goto_Label (Label_Ligne, Label_GOTO, To_String(Ligne_Split.Tab_Split_String(i)), Position_Label, Correspondance_Variable);
            
            -- Si la fonction précédent à renvoie une ligne donc il y a correspondance entre 2 label. On affecte donc le tableau d'entier avec la ligne du label que reférence le label.
            if Position_Label.Etat = 2 then 
               -- On référence la ligne que point le label. 
               Tab_Instru(Indice) := Position_Label.Ligne;
               
                --Ajout du 1 en colone 5 ou 6 pour indiquer qu'il s'agit d'une constante et non d'une variable
               if Indice = 2 then --si la constante est en 2 position
                  Tab_Instru(5) := 1 ;
               elsif Indice = 4 then --si la constante est en 4 position
                  Tab_Instru(6) := 1 ;
               else
                  null;
               end if;
               Indice := Indice +1; -- Ajout de 1 à Indice
            elsif Position_Label.Etat = 1 then
                  Tab_Instru(Indice) := Position_Label.Indice;
               Indice := Indice +1; -- Ajout de 1 à Indice
            else
               null;                  
            end if;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "<-" then
            null;
            
            else 
               Check_Variable (Tab_Instru, Correspondance_Variable, Memoire, To_String(Ligne_Split.Tab_Split_String(i)), Indice);
         
         end if;
      end loop;
      -- Ajout du tableau d'entier au sein du programme à la ligne correspondante 
      Programme.Tab_Instruction(Programme.Taille) := Tab_Instru; 
   end Convertir_Instruction;
   
   
    procedure Analyse_Ligne (ligne : in Unbounded_String; Programme : in out T_Programme; Correspondance_Variable : in T_Correspondance_Variable; Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Memoire : in out T_Memoire) is
      
      Tab_ligne : T_Split_String;
      
   begin
      -- Convertir la ligne en mot 
      Tab_ligne := Split_String (To_String(ligne));
      -- Apelle de la fonction convertir_instruction pour convertir la ligne en tableau d'entier
      Convertir_Instruction (Programme, Tab_ligne,Correspondance_Variable, Label_Ligne, Label_GOTO, Memoire);                    
   end Analyse_Ligne;
   
      
   -------------Fin fonction interne package----------------
   
   
   procedure Lire_Fichier(nom_fichier : in String; Programme: out T_Programme; Ma_Memoire : out T_Memoire) is
      
      F : File_type ;
      Correspondance_Variable : T_Correspondance_Variable;
      Ligne : Unbounded_String;
      Label_Ligne : T_Label;
      Label_GOTO : T_Label;
      
   begin
      -------------------------------Initialiser les variables nécessaire ----------------------------------------------
      
      --Initialiser le tableau qui aura les instructions 
      Initialiser_Programme (Programme);
      
      --Initialiser le tableau qui aura la correspondance entre le nom de la variable et son code
      Initialiser_Correspondance_Var (Correspondance_Variable);
      
      -- Initialiser la memoire ou seront instancier les variables
      Initialiser(Ma_Memoire);
      
      --Initialiser les variables pour convertir les labels en ligne 
      Initialiser_Label(Label_Ligne);  
      Initialiser_Label(Label_GOTO);  
      
      -------------------------- Fin initialiser Variables ---------------------------------------------------
      
      --Lecture du fichier
      Open (F, In_File, nom_fichier);
      while not End_Of_File (F) loop
         --Obtenir la ligne suivante 
         Ligne :=  To_Unbounded_String(Get_Line (F));
         
         -- Si ligne = Programme ... c'est le début du programme
         if To_String(Ligne)(1..9) = "Programme" then
            -- Obtenir la ligne
            Ligne :=  To_Unbounded_String(Get_Line (F));
            -- Tant que ligne != Debut on est sur la définition de variable
            while To_String(Ligne) /= "Debut" loop
               --Appelle de la fonction instancier variable
               Instancier_Variable (To_String(Ligne), Correspondance_Variable, Ma_Memoire);
               --obtenir la ligne suivante
               Ligne :=  To_Unbounded_String(Get_Line (F));
            end loop;
         end if;
         -- Si ligne = Debut On passe à la creation de notre tableau d'instruction 
         if To_String(Ligne) = "Debut" then
            -- Tant que ligne != Fin nous avons des instruction de notre programme
            while To_String(Ligne) /= "Fin" loop
               --obtenir la ligne suivante
               Ligne :=  To_Unbounded_String(Get_Line (F));
               --Augmenter la taille du programme instancié de 1
               Programme.Taille := Programme.Taille +1;
               -- Appelle de la procédure analyse ligne pour convertir la ligne en un tableau d'entier qui correspond aux instructions de la ligne
               Analyse_Ligne (Ligne, Programme, Correspondance_Variable, Label_Ligne, Label_GOTO, Ma_Memoire);
               end loop;
            end if;
      end loop;
      Close (F);
   
   end Lire_Fichier;
   
   
   
   procedure Renvoyer_Resultat_Programme (Programme : in T_Programme) is
      
      F2 : File_type ; -- creation du type pour le fichier
      
   begin
      Create(F2, Out_File, "Resultat_Programme.txt"); --Creation du fichier
      --Parcourir le fichier et afficher chaque tableau d'entier
      for i in 1..Programme.Taille loop
         -- Convertir chaque élément du tableau en chaîne de caractères
         for j in Programme.Tab_Instruction(i)'Range loop
            Put(F2, Integer'Image(Programme.Tab_Instruction(i)(j)));
            if j < Programme.Tab_Instruction(i)'Last then
               Put(F2, ' '); -- Ajouter un espace entre les éléments
            end if;
         end loop;
         New_Line(F2);
      end loop;
      Close (F2); --fermeture du fichier
      null;
   end Renvoyer_Resultat_Programme;
   
end Parser;
