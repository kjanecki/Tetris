
with Ada.Text_IO, Ada.Calendar, Colors;
use Ada.Text_IO, Ada.Calendar;

package output is

    h : constant Integer := 50;
    w  : constant Integer := 80;
    subtype Height is Integer range 1..h;
    subtype Width is Integer range 1..w;

    type Position is record
        x : Width;
        y : Height;
    end record;

    task Screen is
        entry clear; 
        entry move(to : Position);
        entry putString(str : String);
        entry draw(pos : Position; str : String);
        entry writeFrame(width : Integer; height : Integer; pos : out Position; previewPos : out Position);
        entry quit;
        entry displayGameOverMsg;
    end Screen;

end output;