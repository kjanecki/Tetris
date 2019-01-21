with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

package Colors is
    procedure black;
    procedure red;
    procedure green;
    procedure orange;
    procedure blue;
    procedure purple;
    procedure cyan;
    procedure light_gray;
    procedure dark_gray;
    procedure light_red;
    procedure light_green;
    procedure yellow;
    procedure light_blue;
    procedure light_purple;
    procedure light_cyan;
    procedure white;
    procedure set_random_color;

    private
        package Int_IO is new Ada.Text_IO.Integer_IO (Num => Integer);  
        type colors_range is range 1..6;
        package Rand_Colors is new Ada.Numerics.Discrete_Random(colors_range);
        use Rand_Colors;
        Gen: Generator;

end Colors;