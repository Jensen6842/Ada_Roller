with Ada.Containers.Vectors;

package Operations is
    
    type RollExpression is record
        faces_count : Integer;
        quantity : Integer;
    end record;

    package RollExpression_Vector is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => RollExpression);
    use RollExpression_Vector;

    function Roller
    (amount : Integer;
     faces  : Integer) return Integer;

    function Parser
    (input  : String) return Vector;

end Operations;