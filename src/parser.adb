with Ada.Text_IO; use Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
with Memoire; Use Memoire;

package body Parser is

   ------------------Fonction interne au package 
    type T_Donnee_Label is record
         Nom : Unbounded_String; --Nom du label
      Ligne : Integer; --Ligne ou se trouve le label
      Position : Integer; -- Position du label
   end record;
   
   type T_Tab_Label is array (1..100) of T_Donnee_Label; --Taille du tableau défini arbitrairement
   
   type T_Label is record
         Tab_label : T_Tab_Label; --tableau contenant les labels
         Taille : Integer; --taille du tableau qui est défini
   end record;
   
   
   
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
      Ancien_Taille_Instancier : Integer := Correspondance_Var.Taille;
   begin
      Tab_ligne := Split_String (ligne);
      --Put_Line( Integer'Image(Tab_ligne.Taille));
      for i in 1..Tab_ligne.Taille loop
         if To_String(Tab_ligne.Tab_Split_String(i)) = ":" then 
            Etat := 1;
            Indice := i; -- recuperer indice de :
            Correspondance_Var.Taille :=  Correspondance_Var.Taille + (i-1); --augmenter la taille pour les variables instanciers
            if To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Entier" or To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Booleen" then
               for y in (Ancien_Taille_Instancier+1)..(Correspondance_Var.Taille) loop
                  Creer_Variable(new T_Element'(Type_Element => Entier, Valeur_Entier => 0), Correspondance_Var.Tab_Nom_Variabe(y), True, Ma_Memoire);
               end loop;
            end if ;
         elsif To_String(Tab_ligne.Tab_Split_String(i)) = "<-" then
            if To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Entier" or To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Booleen" then
               for y in (Ancien_Taille_Instancier+1)..(Correspondance_Var.Taille) loop
                  Affectation_Variable(y, new T_Element'(Type_Element => Entier, Valeur_Entier => Indice  + 1), Ma_Memoire);
               end loop;
            end if;
         else
            null;
         end if;
         
            
         if Etat = 0 then --recup nom variable et instancier correspondance entre nom et code
            Nom_var := Tab_ligne.Tab_Split_String(i);
            if To_String(Nom_var)(To_String(Nom_var)'Length) = ',' then
               -- enlever le dernier caractere
               Nom_var := To_Unbounded_String(To_String(Nom_var)(1 .. To_String(Nom_var)'Length - 1));
            end if;
              
            Correspondance_Var.Tab_Nom_Variabe(i+Correspondance_Var.Taille) := Nom_var;
            --Put_Line (To_String(Nom_var));
         end if;
                 
      end loop;
         
   end Instancier_Variable;
   
   
   procedure Check_Variable (Tab_Instru : in out T_Instruction; Correspondance_Variable : in T_Correspondance_Variable; Variable : in String; Indice : in out Integer) is 
      A : Integer;
   begin
      A :=  Integer'Value(Variable);
      --Put_Line (Integer'Image(A) & " " & Integer'Image(Indice));
      if Indice = 2 then 
         Tab_Instru(5) := 1;
         Tab_Instru(2) := A;
      elsif Indice = 4 then 
         Tab_Instru(6) := 1;
         Tab_Instru(4) := A;
      else
         null;
      end if;
        
   exception
      when CONSTRAINT_ERROR =>
         
         for i in 1..Correspondance_Variable.Taille loop
            if Variable = To_String(Correspondance_Variable.Tab_Nom_Variabe(i)) then 
               --Put_Line (Variable);
               --Put_Line (To_String(Correspondance_Variable.Tab_Nom_Variabe(i)));
               --Put_Line ("exception ok");
               --Put_Line (Integer'Image(Indice));
               Tab_Instru(Indice) := i;
               Indice := Indice + 1 ;
            end if;
         end loop;
      
   end Check_Variable;
      
   
   procedure Check_Label (Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Label : in String; Num_Ligne : Integer; Renvoie_Ligne_Label: out Integer; Renvoie_Position_Label : out Integer ) is 
      Nombre : Integer;
      Val : Character;
   begin
      Val := Label(Label'Last);
      --Put_Line (Label);
      --Put(Val);
      --New_Line;
      Nombre := Character'Pos(Val);
      --Put_Line (Integer'Image(Nombre));
      for i in 1..Label_GOTO.Taille loop
         if To_String(Label_GOTO.Tab_label(i).Nom) = Label then
            Renvoie_Ligne_Label := Label_GOTO.Tab_label(i).Ligne;
            Renvoie_Position_Label := Label_GOTO.Tab_label(i).Position;
         end if;
      end loop;
      Label_Ligne.Taille := Label_Ligne.Taille +1;
      Label_Ligne.Tab_label(Label_Ligne.Taille).Nom :=To_Unbounded_String(Label);
      Label_Ligne.Tab_label(Label_Ligne.Taille).Ligne := Num_Ligne;
        
   exception
      when CONSTRAINT_ERROR =>
         Put_Line ("Error check_label " & Label);
   end Check_Label;
   
   procedure Goto_Label (Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Label : in String; Num_Ligne : in Integer; Position : in Integer; Renvoie_Ligne_Label : out Integer) is
      Nombre : Integer;
      Valeur : Character; 
      begin
      Valeur := Label(Label'Last);
      
      Nombre := Character'Pos(Valeur);
      for i in 1..Label_Ligne.Taille loop
         if To_String(Label_Ligne.Tab_label(i).Nom) = Label then
            Renvoie_Ligne_Label := Label_Ligne.Tab_label(i).Ligne;
         end if;
      end loop;
      
         Label_GOTO.Taille := Label_GOTO.Taille + 1;
         Label_GOTO.Tab_label(Label_GOTO.Taille).Nom := To_Unbounded_String(Label);
         Label_GOTO.Tab_label(Label_GOTO.Taille).Ligne := Num_Ligne;
         Label_GOTO.Tab_label(Label_GOTO.Taille).Position := Position;
         
         exception
      when CONSTRAINT_ERROR =>
         Put_Line ("Error GOTO_label" & Label);
   end Goto_Label;
   
   
   
   procedure Convertir_Instruction (Programme : in out T_Programme; Ligne_Split : in T_Split_String; Correspondance_Variable : in T_Correspondance_Variable; Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Num_Ligne : in Integer) is 
      --modif le Tab_Ligne_Split
      Indice : Integer := 1;
      Tab_Instru : T_Instruction := Programme.Tab_Instruction(Programme.Taille);
      Renvoie_Ligne_Label : Integer := 0;
      Renvoie_Position_Label : Integer := 0;
   begin
      --Put_Line ("Convertir Instruction" & Integer'Image(Ligne_Split.Taille));
      for i in 1..Ligne_Split.Taille loop
         --New_Line;
         --Put_Line (Integer'Image(i));
         Put_Line (Integer'Image(Indice));
         --Put_Line (To_String(Line));
         if To_String(Ligne_Split.Tab_Split_String(i)) = "IF" then
            Tab_Instru(Indice) := -1;
            Indice := Indice +1;
         elsif To_String(Ligne_Split.Tab_Split_String(i)) = "GOTO" then
            Tab_Instru(Indice) := -2;
            Indice := Indice +1;
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "+" then
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
         elsif To_String(Ligne_Split.Tab_Split_String(i))(1) = 'L' and Indice = 1  then
            Put_Line ((Integer'Image (Programme.Taille)) & " " & (Integer'Image(Renvoie_Position_Label)));
            Check_Label (Label_Ligne, Label_GOTO, To_String(Ligne_Split.Tab_Split_String(i)), Num_Ligne, Renvoie_Ligne_Label, Renvoie_Position_Label);
            Put_Line ("Check_Label");
            Put_Line ((Integer'Image (Programme.Taille)) & " " & (Integer'Image(Renvoie_Position_Label)));
             New_Line;
               if Renvoie_Ligne_Label /= 0 and Renvoie_Position_Label /= 0 then 
               Programme.Tab_Instruction(Renvoie_Ligne_Label)(Renvoie_Position_Label) := Programme.Taille ;
               Put_Line (Integer'Image(Renvoie_Position_Label));
               Put_Line ("yes " & Integer'Image(Programme.Tab_Instruction(Renvoie_Ligne_Label)(Renvoie_Position_Label) ));
                  Renvoie_Ligne_Label := 0;
                  Renvoie_Position_Label := 0;
               end if;
            
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "FIN" then
            null; --tableau de (0, 0, 0, 0, 0, 0) déjà défini 
         elsif To_String(Ligne_Split.Tab_Split_String(i))(1) = 'L' and then Tab_Instru(Indice-1) = -2 then --
            Put_Line ((Integer'Image (Programme.Taille)) & " " & (Integer'Image(Renvoie_Position_Label)));
            Goto_Label (Label_Ligne, Label_GOTO, To_String(Ligne_Split.Tab_Split_String(i)), Programme.Taille, Indice, Renvoie_Ligne_Label);
            Put_Line ("Label_GOTO");
            Put_Line ((Integer'Image (Programme.Taille)) & " " & (Integer'Image(Renvoie_Position_Label)));
            New_Line;
            if Renvoie_Ligne_Label /= 0 then 
               Put_Line ("yo ici" & Integer'Image(Renvoie_Ligne_Label));
               Tab_Instru(Indice) := Renvoie_Ligne_Label;
               Renvoie_Ligne_Label := 0;
            end if;
            null;
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "<-" then
               null;
            else 
               Check_Variable (Tab_Instru, Correspondance_Variable, To_String(Ligne_Split.Tab_Split_String(i)), Indice);
         end if;
      end loop;
      --Put_Line("Out loop");
      --for i in 1..6 loop 
      --   Put_Line (Integer'Image(Tab_Instru(i)));
      --end loop;
      Programme.Tab_Instruction(Programme.Taille) := Tab_Instru;
      
   end Convertir_Instruction;
   
   
    procedure Analyse_Ligne (ligne : in Unbounded_String; Programme : in out T_Programme; Correspondance_Variable : in T_Correspondance_Variable; Label_Ligne : in out T_Label; Label_GOTO : in out T_Label; Num_Ligne : in Integer) is
      Tab_ligne : T_Split_String;
      
   begin
      Tab_ligne := Split_String (To_String(ligne));
      --Put_Line ("analyse ligne" & Integer'Image(Tab_ligne.Taille));
      Convertir_Instruction (Programme, Tab_ligne,Correspondance_Variable, Label_Ligne, Label_GOTO, Num_Ligne);
                            
   end Analyse_Ligne;
   
      
   -------------Fin fonction interne package----------------
   
   
   procedure Lire_Fichier(nom_fichier : in String; Programme: out T_Programme; Correspondance_Variable : out T_Correspondance_Variable; Ma_Memoire : out T_Memoire) is
      
      F : File_type ;
      File_Name : constant String := "code_inter_facto.txt";
      Ligne : Unbounded_String;
      Label_Ligne : T_Label;
      Label_GOTO : T_Label;
      
      begin
      --Initialiser le tableau qui aura les instructions 
      Initialiser_Programme (Programme);
      --Initialiser le tableau qui aura la correspondance entre le nom de la variable et son code
      Initialiser_Correspondance_Var (Correspondance_Variable);
      -- Initialiser la memoire ou seront instancier les variables
      Initialiser(Ma_Memoire);
      --Initialiser les variables pour convertir les labels en ligne 
      Initialiser_Label(Label_Ligne);  
      Initialiser_Label(Label_GOTO);  
                          --Lecture du fichier
      Open (F, In_File, nom_fichier);
      while not End_Of_File (F) loop
         Ligne :=  To_Unbounded_String(Get_Line (F));
         
         --Instanciée le tableau correspondance nom variable et code (indice dans le tableau)
         --Put_Line (To_String(Ligne)(1..9));
         if To_String(Ligne)(1..9) = "Programme" then
            --Put_Line (To_String(Ligne));
            Ligne :=  To_Unbounded_String(Get_Line (F));
            while To_String(Ligne) /= "Debut" loop
               --New_Line;
               --Put_Line ("*****Instancier Correspondance_Variable****");
               Instancier_Variable (To_String(Ligne), Correspondance_Variable, Ma_Memoire);
               --Afficher_Memoire (Ma_Memoire);
               --Put_Line (Integer'Image(Correspondance_Variable.Taille));
               Ligne :=  To_Unbounded_String(Get_Line (F));
            end loop;
         end if;
         
            if To_String(Ligne) = "Debut" then
            while To_String(Ligne) /= "Fin" loop
               --Put_Line ("Instancier Programme");
               Ligne :=  To_Unbounded_String(Get_Line (F));
               Put_Line (To_String(Ligne));
               Programme.Taille := Programme.Taille +1;
               --Put_Line (Integer'Image(Programme.Taille));
               --New_Line;
               Analyse_Ligne (Ligne, Programme, Correspondance_Variable, Label_Ligne, Label_GOTO, Programme.Taille);
               --Ajout de Instruction dans le tableau
               end loop;
            end if;
      end loop;
      Close (F);
   
   end Lire_Fichier;
   
   
   
   procedure Renvoyer_Resultat_Programme (Programme : in T_Programme) is 
      F2 : File_type ;
   begin
      Create(F2, Out_File, "Resultat_Programme.txt");
      for i in 1..Programme.Taille loop
         -- Convertir chaque élément du tableau en chaîne de caractères
         for j in Programme.Tab_Instruction(i)'Range loop
            Put(F2, Integer'Image(Programme.Tab_Instruction(i)(j)));
            if j < Programme.Tab_Instruction(i)'Last then
               Put(F2, ' '); -- Ajouter un espace entre les éléments
            end if;
         end loop;
         New_Line(F2);
         --Put_Line (F2, Programme.Tab_Instruction(i));
      end loop;
      Close (F2);
      null;
   end Renvoyer_Resultat_Programme;
   
end Parser;
