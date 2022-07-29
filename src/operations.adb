with Ada.Containers.Vectors;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Fixed;
with Ada.Text_IO;

package body Operations is    

    function Roller
    (amount : Integer;
     faces  : Integer) return Integer is
         package Rand_Int is new Ada.Numerics.Discrete_Random(Integer);
        use Rand_Int;
        gen : Generator;
        num : Integer := 0;
        I : Integer := amount;
    begin
        while I > 0 loop
            reset(gen);
            num := num + (random(gen) mod faces + 1);
            I := I - 1;
        end loop;
        return num;
    end Roller;

    function Parser
    (input  : String) return Vector is
        str : String (1 .. input'Length) := input;
        substr : String (1 .. input'Length) := (others => ' ');

        type TermMode is (AmountMode, FacesMode);
        mode : TermMode := AmountMode;
        isEmpty : Boolean := True;
        
        Terms : Vector;

        currentTerm : RollExpression := (0, 0);
    begin
        for i in str'Range loop
            -- Amount has been found
            if str(i) = 'd' then
                currentTerm.quantity := Integer'Value(substr);
                substr := (others => ' ');
                isEmpty := True;
                mode := FacesMode;
            elsif str(i) = ' ' or str(i) = '+' then
                -- Term is a value
                if mode = AmountMode and then isEmpty = False then
                    currentTerm.faces_count := 1;
                    currentTerm.quantity := Integer'Value(substr);
                    Terms.Append(currentTerm);
                    currentTerm.faces_count := 0;
                    currentTerm.quantity := 0;
                    substr := (others => ' ');
                    isEmpty := True;
                    mode := FacesMode;
                -- Faces have been found
                elsif mode = FacesMode and then isEmpty = False then
                    currentTerm.faces_count := Integer'Value(substr);
                    Terms.Append(currentTerm);
                    currentTerm.faces_count := 0;
                    currentTerm.quantity := 0;
                    substr := (others => ' ');
                    isEmpty := True;
                    mode := AmountMode;
                end if;
            else
                substr(i) := str(i);
                if isEmpty then
                    isEmpty := False;
                end if;
            end if;
        end loop;
        -- Term is a value
        if mode = AmountMode and then isEmpty = False then
            currentTerm.faces_count := 1;
            currentTerm.quantity := Integer'Value(substr);
            Terms.Append(currentTerm);
        -- Faces have been found
        elsif mode = FacesMode and then isEmpty = False then
            currentTerm.faces_count := Integer'Value(substr);
            Terms.Append(currentTerm);
        end if;
        return Terms;
    end Parser;

end Operations;