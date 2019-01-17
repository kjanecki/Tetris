with Ada.Real_Time, Ada.Numerics, Ada.Numerics.Discrete_Random, Bricks_Generator_Action, Bricks;
use Ada.Real_Time, Bricks_Generator_Action, Bricks;

package Bricks_Generator is
    procedure Get(b: in out Brick);
    procedure TerminateGenerator;    
    procedure preview(b: in out Brick);

    private
        is_buf_full: boolean;        
        type types_range is range 1..7;
        package Rand_Types is new Ada.Numerics.Discrete_Random(types_range);
        use Rand_Types;
        Gen: Generator;
        function Get_Rand_Type return Positive;
        procedure Initialize_New_Brick(b: in out Brick);
        task Generate is
            entry quit;
        end Generate;

end Bricks_Generator;