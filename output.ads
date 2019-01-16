
with Ada.Text_IO;
use Ada.Text_IO;

package output is

    h : constant Integer := 50;
    w  : constant Integer := 80;
    subtype Height is Integer range 1..h;
    subtype Width is Integer range 1..w;

    type Position is record
        x : Width;
        y : Height;
    end record;

    protected Screen is

        procedure clear; 
        procedure move(to : Position);
        procedure putString(str : String);
        procedure draw(pos : Position; str : String);
    end Screen;

    procedure writeFrame(width : Integer; height : Integer; pos : out Position);

end output;