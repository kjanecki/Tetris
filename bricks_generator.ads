with Ada.Real_Time, Ada.Numerics, Ada.Numerics.Discrete_Random, Bricks_Generator_Action, Bricks;
use Ada.Real_Time, Bricks_Generator_Action, Bricks;
with buffer;

package Bricks_Generator is
    package BrickBuffer is new buffer(max => 3, element_type => Brick);

    procedure Get(b: in out Brick);

    private
        is_buf_full: boolean;
        function Get_Rand_Type return Positive;
        procedure Initialize_New_Brick(b: in out Brick);
        task Generate;

end Bricks_Generator;