with Ada.Text_IO;
use Ada.Text_IO;

package body output is

    package Int_IO is new Ada.Text_IO.Integer_IO (Num => Integer);

    protected body Screen is

        procedure clear is
        begin
            Put(ASCII.ESC & "[2J"); 
        end clear;

        procedure move(to : Position) is
        begin
            New_Line;
            Put(ASCII.ESC & "[");
            Int_IO.Put(to.Y,1);
            Put(";");
            Int_IO.Put(to.X,1);
            Put("H");
        end move;

        procedure putString(str : String) is
        begin
            Ada.Text_IO.Put(str);
        end putString;

        procedure draw(pos : Position; str : String) is
        begin
            move(pos);
            putString(str);
        end draw;

    end Screen;

    procedure writeFrame(height : Integer; width : Integer) is
    begin
        for i in 1..(height-1) loop
            Screen.move((X => 1, Y => i)); Put("#");
            Screen.move((X => width, Y => i)); Put("#");
        end loop;
        New_Line;
        for i in 1..width loop
            Put("#");
        end loop;
    end writeFrame;
    
end output;