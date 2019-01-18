
package body output is

    task body Screen is

        package Int_IO is new Ada.Text_IO.Integer_IO (Num => Integer);

        procedure color_p is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(0,1);
            Put(";");
            Int_IO.Put(31,2);
            Put("m");
        end color_p;

        -- \033[31m
        -- "\e]P9E33636"    

        procedure clear_p is
        begin
            Put(ASCII.ESC & "[2J"); 
        end clear_p;

        procedure move_p(to : Position) is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(to.Y,1);
            Put(";");
            Int_IO.Put(to.X,1);
            Put("H");
        end move_p;

        procedure putString_p(str : String) is
        begin
            Ada.Text_IO.Put(str);
        end putString_p;

        procedure draw_p(pos : Position; str : String) is
        begin
            move_p(pos);
            putString_p(str);
        end draw_p;

        procedure writeFrame_p(width : Integer; height : Integer; pos : out Position; previewPos : out Position) is
        begin
            for i in 1..(height-1) loop
                move_p((X => 1, Y => i)); Put("#");
                move_p((X => width, Y => i)); Put("#");
            end loop;
            New_Line;
            for i in 1..width loop
                Put("#");
            end loop;

            for i in 1..15 loop
                for j in 1..height loop
                    if i > 2 and i < 13 and j > 6 and j < height-2 then
                        draw_p((X => width+i, Y => j)," ");
                    else
                        draw_p((X => width+i, Y => j),"#");
                    end if;
                end loop;
            end loop;
            previewPos.x := width+4;
            previewPos.y := 7;

            draw_p((x=>width+2, y=>3)," Score:     ");
            pos.x := width + 10;
            pos.y := 3;
        end writeFrame_p;

    doQuit : Boolean := false;
    begin
        loop
            select 
                accept quit do
                    doQuit := true;
                end quit;
            or
                accept clear do
                    clear_p;
                end clear;
            or
                accept color do
                    color_p;
                end color;
            or
                accept move(to : Position) do
                    move_p(to);
                end move;
            or
                accept putString(str : String) do
                    putString_p(str);
                end putString;
            or
                accept draw(pos : Position; str : String) do
                    draw_p(pos, str);
                end draw;
            or
                accept writeFrame(width : Integer; height : Integer; pos : out Position; previewPos : out Position) do
                    writeFrame_p(width, height, pos, previewPos);
                end writeFrame;
            or
                delay until Clock + Duration(1);
            end select;

            if doQuit = true then
                exit;
            end if;
        end loop;
    end Screen;

end output;