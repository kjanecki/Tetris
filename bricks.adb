package body Bricks is
    procedure Change_X(x: in out Integer; type_value: in Integer; rotation_value: in Integer) is
    tmp_x: Integer;
    begin
        tmp_x := x;
        if (rotation_value mod 2 = 0) then
            x := tmp_x - xs(type_value, 2);
        else
            x := tmp_x + xs(type_value, 2);
        end if;
    end Change_X;

    procedure Rotate_Right(b: in out Brick; x: in out Integer) is
        rot_val: Integer;
    begin
        Change_X(x, b.type_value, b.rotation_value);
        rot_val := b.rotation_value;
        rot_val := rot_val mod 4 + 1;
        b := Brick'(points=>Bricks_List(b.type_value)(rot_val), type_value=>b.type_value, rotation_value=>rot_val);
    end Rotate_Right;

    procedure Rotate_Left(b: in out Brick; x: in out Integer) is
        rot_val: Integer;
    begin
        Change_X(x, b.type_value, b.rotation_value);
        rot_val := b.rotation_value;
        rot_val := rot_val - 1;
        if rot_val = 0 then
            rot_val := 4;
        end if;
        b := Brick'(points=>Bricks_List(b.type_value)(rot_val), type_value=>b.type_value, rotation_value=>rot_val);
    end Rotate_Left;

    procedure Get_Bricks_List(list: in out Brick_List) is
    begin
        list := Bricks_List;
    end Get_Bricks_List;
end bricks;