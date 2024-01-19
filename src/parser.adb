with Ada.Text_IO; use Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
with Memoire; Use Memoire;

package body Parser is

   ------------------Fonction interne au package 
   
   
   --function Analyse_Ligne (Ligne : in Unbounded_String) return T_Instruction;
   
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
                  Creer_Variable(0, Correspondance_Var.Tab_Nom_Variabe(y), Ma_Memoire);
               end loop;
            end if ;
         elsif To_String(Tab_ligne.Tab_Split_String(i)) = "<-" then
            if To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Entier" or To_String(Tab_ligne.Tab_Split_String(Indice+1)) = "Booleen" then
               for y in (Ancien_Taille_Instancier+1)..(Correspondance_Var.Taille) loop
                  Affectation_Variable(y, Indice + 1, Ma_Memoire);
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
      Put_Line (Integer'Image(A) & " " & Integer'Image(Indice));
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
      
            
   
   
   procedure Convertir_Instruction (Tab_Instru : in out T_Instruction; Ligne_Split : in T_Split_String; Correspondance_Variable : in T_Correspondance_Variable) is 
      --modif le Tab_Ligne_Split
      Indice : Integer := 1;
      
   begin
      --Put_Line ("Convertir Instruction" & Integer'Image(Ligne_Split.Taille));
      for i in 1..Ligne_Split.Taille loop
         --New_Line;
         --Put_Line (Integer'Image(i));
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
            elsif To_String(Ligne_Split.Tab_Split_String(i)) = "FIN" then
               null; --tableau de (0, 0, 0, 0, 0, 0) déjà défini 
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
      
      
   end Convertir_Instruction;
   
   
    procedure Analyse_Ligne (ligne : in Unbounded_String; Instruction : in out T_Instruction; Correspondance_Variable : in T_Correspondance_Variable) is
      Tab_ligne : T_Split_String;
      
   begin
      Tab_ligne := Split_String (To_String(ligne));
      --Put_Line ("analyse ligne" & Integer'Image(Tab_ligne.Taille));
      Convertir_Instruction (Instruction, Tab_ligne,Correspondance_Variable);
                            
   end Analyse_Ligne;
   
      
   -------------Fin fonction interne package----------------
   
   
   procedure Lire_Fichier(nom_fichier : in String; Programme: out T_Programme; Correspondance_Variable : out T_Correspondance_Variable; Ma_Memoire : out T_Memoire) is
      
      F : File_type ;
      File_Name : constant String := "code_inter_facto.txt";
      Ligne : Unbounded_String;
      
      begin
      --Initialiser le tableau qui aura les instructions 
      Initialiser_Programme (Programme);
      --Initialiser le tableau qui aura la correspondance entre le nom de la variable et son code
      Initialiser_Correspondance_Var (Correspondance_Variable);
      -- Initialiser la memoire ou seront instancier les variables
      Initialiser(Ma_Memoire);
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
               Put_Line ("Instancier Programme");
               Ligne :=  To_Unbounded_String(Get_Line (F));
               --Put_Line (To_String(Ligne));
               Programme.Taille := Programme.Taille +1;
               Put_Line (Integer'Image(Programme.Taille));
               New_Line;
               Analyse_Ligne (Ligne, Programme.Tab_Instruction(Programme.Taille), Correspondance_Variable);
               --Ajout de Instruction dans le tableau
               end loop;
            end if;
      end loop;
      Close (F);
   
   end Lire_Fichier;
   
   
   
   procedure Afficher_Programme (Programme : in T_Programme) is 
   begin
      null;
   end Afficher_Programme;
   
end Parser;
