package body Bricks_Generator is

    procedure TerminateGenerator is
    begin
        Generate.quit;
    end TerminateGenerator;

    function Get_Rand_Type return Positive is
        type types_range is range 1..7;
        package Rand_Types is new Ada.Numerics.Discrete_Random(types_range);
        use Rand_Types;
        Gen: Generator;
    begin
        Reset(Gen);
        return Positive(Random(Gen));
    end Get_Rand_Type;

    procedure Initialize_New_Brick(b: in out Brick) is
        Bricks_List: Brick_List;
    begin
        Get_Bricks_List(Bricks_List);
        b.type_value := Get_Rand_Type;
        b.rotation_value := 1;
        b.points := Bricks_List(b.type_value)(b.rotation_value);
    end Initialize_New_Brick;

    task body Generate is
        TimeDelay: Time := Clock;
        b: Brick;
        doQuit : Boolean := false;
    begin
        loop
            if not is_buf_full then
                Initialize_New_Brick(b);
                BrickBuffer.CircularBuffer.add(b);
                Action.Add(b, is_buf_full);    
            end if;

            TimeDelay := TimeDelay + milliseconds(2000);
            select
                accept quit do
                    doQuit := true;
                end quit;
            or
                delay until TimeDelay;
            end select;

            if doQuit = true then
                exit;
            end if;

        end loop;
    end Generate;
    
    procedure Get(b: in out Brick) is
    begin
        Action.Get(b, is_buf_full);
    end Get;

end Bricks_Generator;