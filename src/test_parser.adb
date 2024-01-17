WITH Ada.Text_IO ; USE Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
WITH Parser; USE Parser;


procedure test_parser is
   Programme_1 : T_Programme;
   Correspondance_Variable_1 : T_Correspondance_Variable;
begin
   Lire_Fichier("code_inter_facto.txt", Programme_1, Correspondance_Variable_1);
end test_parser;
