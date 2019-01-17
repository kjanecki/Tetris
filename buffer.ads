
generic
    Max: Positive; 
    type Element_Type is private;

package buffer is

    type local_array is array (1..Max) of Element_Type;

    protected CircularBuffer is
        procedure add(elem : Element_Type);
        procedure get(elem : out Element_Type);
        procedure preview(elem : out Element_Type);
        function isEmpty return Boolean;
        private
            buff : local_array;
            empty : Boolean := true;
            full : Boolean := False;
            s: Integer range 1 .. Max := 1;
            e: Integer range 1 .. Max := 1;
            capacity: Natural := max;
    end CircularBuffer;
        
end buffer;
