
package body buffer is

    protected body CircularBuffer is
        procedure add(elem : Element_Type) is
        begin
            if not full then
                buff(s) := elem;
                capacity := capacity - 1;

                if s = max then
                    s := 1;
                end if;
                s := s + 1;
                if capacity > 0 then
                    empty := false;
                else
                    full := true;
                end if;    
            end if;
        end add;

        procedure get(elem : out Element_Type) is
        begin
            if not empty then
                elem := buff(e);
                if e = max then
                    e := 1;
                end if;
                e := e + 1;
                capacity := capacity + 1;
                if capacity < max then
                    full := false;
                else
                    empty := true;
                end if;
            end if;
        end get;

        procedure preview(elem : out Element_Type) is
        begin
            if not empty then
                elem := buff(e);
            end if;
        end preview;

        function isEmpty return Boolean is
        begin
            return empty;
        end isEmpty;

    end CircularBuffer;
end buffer;
