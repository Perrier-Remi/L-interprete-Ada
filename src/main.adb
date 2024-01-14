with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
    
    NB_INSTRUCTIONS : Constant Integer := 6;
    MAX_LIGNES_PROGRAMME : Constant Integer := 1000;
    
    type Instruction is array (1..NB_INSTRUCTIONS) of Integer;
    type Programme is array (1..MAX_LIGNES_PROGRAMME) of Instruction;

    T_Prog : Programme;
    
    -- Programme simple
    -- 1 i <- 2
    -- 2 a <- i + 1
    -- 3 b <- i + a
    -- 4 if b goto 6
    -- 5 b <- 0
    -- 6 b <- 12
    -- 7 fin prog (opérateur 0)
    --
    -- variables :
    -- i, a, b : Integer
    procedure Initialiser_Programme is
    begin
        T_Prog(1) := (1,  2, -12, 0, 1, 0);
        T_Prog(2) := (2,  1,  -3, 1, 0, 1);
        T_Prog(3) := (3,  1,  -3, 2, 0, 0);
        T_Prog(4) := (-1, 3,  -2, 6, 0, 1);
        T_Prog(5) := (3,  0, -12, 0, 1, 0);
        T_Prog(6) := (2, 12, -12, 0, 1, 0);
        T_Prog(7) := (0,  0,   0, 0, 0, 0);
    end Initialiser_Programme;
    
    
begin

    null;
    
end Main;
