with Ada.Command_Line;
with Ada.Containers.Vectors;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Operations;

procedure Main is
    I : Integer := 1;
    inputString : Ada.Strings.Unbounded.Unbounded_String;
    inputIterator : Integer;

    testString : Ada.Strings.Unbounded.Unbounded_String;

    use Operations.RollExpression_Vector;
    Terms : Vector;

    result : Integer;
    total : Integer := 0;

begin

    if Ada.Command_Line.Argument_Count > 0 and then Ada.Command_Line.Argument(1) = "-t" then
        testString := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Command_Line.Argument(2));
        Terms := Operations.Parser(Ada.Strings.Unbounded.To_String(testString));
        inputIterator := Integer'Value(Ada.Command_Line.Argument(3));
    else
        Ada.Text_IO.Put("Input your expression: ");
        Ada.Text_IO.Unbounded_IO.Get_Line(inputString);
        Terms := Operations.Parser(Ada.Strings.Unbounded.To_String(inputString));
        Ada.Text_IO.Put("How many times do you want to run?: ");
        Ada.Integer_Text_IO.Get(inputIterator);
    end if;

    for j in 1 .. inputIterator loop
        Ada.Text_IO.New_Line;
        if Ada.Command_Line.Argument_Count > 0 and then Ada.Command_Line.Argument(1) = "-t" then
            Ada.Text_IO.Put_Line("Expression: " & Ada.Strings.Unbounded.To_String(testString));
        else
            Ada.Text_IO.Put_Line("Expression: " & Ada.Strings.Unbounded.To_String(inputString));
        end if;
        for i in Terms.First_Index .. Terms.Last_index loop
            if Terms(i).faces_count = 1 then
                result := Terms(i).quantity;
                Ada.Text_IO.Put("     Value:");
                Ada.Text_IO.Put_Line(Integer'Image(result));
            else
                Ada.Text_IO.Put("   Rolling:");
                Ada.Text_IO.Put_Line(Integer'Image(Terms(i).quantity) & "d" & Ada.Strings.Fixed.Trim(Integer'Image(Terms(i).faces_count), Ada.Strings.Left));
                result := Operations.Roller(Terms(i).quantity, Terms(i).faces_count);
                Ada.Text_IO.Put("    Result:");
                Ada.Text_IO.Put_Line(Integer'Image(result));
            end if;
            total := total + result;
        end loop;
        Ada.Text_IO.Put("     Total:");
        Ada.Text_IO.Put_Line(Integer'Image(total));
        Ada.Text_IO.New_Line;
    end loop;
end Main;