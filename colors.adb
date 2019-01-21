package body Colors is
        procedure black is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(30,2);
            Put("m");
        end black;

        procedure red is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(31,2);
            Put("m");
        end red;

        procedure green is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(32,2);
            Put("m");
        end green;

        procedure orange is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(33,2);
            Put("m");
        end orange;

        procedure blue is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(34,2);
            Put("m");
        end blue;

        procedure purple is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(35,2);
            Put("m");
        end purple;     

        procedure cyan is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(36,2);
            Put("m");
        end cyan;   

        procedure light_gray is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(37,2);
            Put("m");
        end light_gray;  

        procedure dark_gray is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(30,2);
            Put("m");
        end dark_gray;

        procedure light_red is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(31,2);
            Put("m");
        end light_red;

        procedure light_green is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(32,2);
            Put("m");
        end light_green;

        procedure yellow is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(33,2);
            Put("m");
        end yellow;

        procedure light_blue is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(34,2);
            Put("m");
        end light_blue;

        procedure light_purple is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(35,2);
            Put("m");
        end light_purple;

        procedure light_cyan is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(36,2);
            Put("m");
        end light_cyan;

        procedure white is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(1,1);
            Put(";");
            Int_IO.Put(37,2);
            Put("m");
        end white;

        procedure set_random_color is
        Random_Color: Integer;
        begin
            Random_Color := Integer(Random(Gen));
            case Random_Color is
                when 1 => green;
                when 2 => orange;
                when 3 => purple;
                when 4 => cyan;
                when 5 => light_purple;
                when 6 => light_cyan;
                when others => null;
            end case;
        end set_random_color;

        begin
            Reset(Gen);

end Colors;