with Ada.Text_IO; use Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;

package body Parser is
    
    function Split_String(input : in String) return T_Split_String_Tab is
        index_tab : Integer := 1;
        index_str : Integer := 1;
        longueur_str : Integer;
        splited_string : T_Split_String_Tab;
        mot_courrant : Unbounded_String;
    begin
        longueur_str := input'Last;
        mot_courrant := To_Unbounded_String("");
        while index_str <= longueur_str loop
            if input(index_str) = ' ' then
                splited_string(index_tab) := mot_courrant;
                mot_courrant := To_Unbounded_String("");
                index_tab := index_tab + 1;
            else
                Append(mot_courrant, input(index_str));
            end if;
            index_str := index_str + 1;
            Put_Line(To_String(mot_courrant));
        end loop;
        return splited_string;
    end Split_String;
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
   

   
     
   

   
   procedure Instancier_Variable (Ligne : in String; Correspondance_Var : in out T_Correspondance_Variable) is 
      Taille_chaine : Integer;
      Debut : Integer;
      Fin : Integer;
      
   begin
      ---Taille_chaine := Ligne'Length;
      ---for i in 1..Taille_chaine loop
      ---   if i <= Taille_chaine then
      ---      Debut := 1;
      ---      Fin := 1;
      ---      if Ligne(i) /= ' ' then 
      ---         Fin := i;
      ---      elsif Ligne(i) = ' 'then
      ---         null;
      ---      end if;
      ---   end if;"""
         
               
              
      ---end loop;
      null;
         
   end Instancier_Variable;
   
   
   
   function Analyse_Ligne (ligne : in String) return T_Instruction is
      Instruction : T_Instruction;
      
   begin
      
      Instruction := (0,0,0,0,0,0);
      return Instruction;
   end Analyse_Ligne;
   -------------Fin fonction interne package----------------
   
   
   procedure Lire_Fichier(nom_fichier : in String; Programme: out T_Programme; Correspondance_Variable : out T_Correspondance_Variable) is
      
      F : File_type ;
      File_Name : constant String := "code_inter_facto.txt";
      Ligne : Unbounded_String;
      
         Instruction : T_Instruction;
      
      begin
      --Initialiser le tableau qui aura les instructions 
      Initialiser_Programme (Programme);
      --Initialiser le tableau qui aura la correspondance entre le nom de la variable et son code
      Initialiser_Correspondance_Var (Correspondance_Variable);
      --Lecture du fichier
      Open (F, In_File, nom_fichier);
      while not End_Of_File (F) loop
         Ligne :=  To_Unbounded_String(Get_Line (F));
         
         --Instanciée le tableau correspondance nom variable et code (indice dans le tableau)
         Put_Line (To_String(Ligne)(1..9));
            if To_String(Ligne)(1..9) = "Programme" then
            while To_String(Ligne) /= "Debut" loop
               New_Line;
               Put_Line ("*****Instancier Correspondance_Variable****");
               Ligne :=  To_Unbounded_String(Get_Line (F));
               Instancier_Variable (To_String(Ligne), Correspondance_Variable);
            end loop;
         end if;
         
            if To_String(Ligne) = "Debut" then
            while To_String(Ligne) /= "Fin" loop
               Put_Line ("Instancier Programme");
               Ligne :=  To_Unbounded_String(Get_Line (F));
               Put_Line (To_String(Ligne));
               Instruction := Analyse_Ligne (To_String(Ligne));
               --Ajout de Instruction dans le tableau
               Programme.Taille := Programme.Taille +1;
                  Programme.Tab_Instruction(Programme.Taille) := Instruction;
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
