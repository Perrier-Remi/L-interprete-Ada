WITH Ada.Text_IO ; USE Ada.Text_IO;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
WITH Parser; USE Parser;
with Memoire; use Memoire;

procedure test_parser is
   Programme_1 : T_Programme;
   Correspondance_Variable_1 : T_Correspondance_Variable;
   Memoire1 : T_Memoire;
begin
   Lire_Fichier("code_test.txt", Programme_1, Correspondance_Variable_1, Memoire1);
end test_parser;
