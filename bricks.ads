package Bricks is
    type Offset_List is array(Positive range 1..7, Positive range 1..2) of Integer;

    type Point is record
            x : Positive;
            y : Positive;
    end record;

    type Points_List is array(Positive range 1..4) of Point;

    type Brick is record
        type_value: Positive := 1;
        rotation_value: Positive := 1;
        points: Points_List;
    end record;

    type Brick_Points is array(Positive range 1..4) of Points_List;
    
    type Brick_List is array(Positive range 1..7) of Brick_Points;

    procedure Rotate_Right(b: in out Brick; x: in out Integer);
    procedure Rotate_Left(b: in out Brick; x: in out Integer);
    procedure Get_Bricks_List(list: in out Brick_list);

    private
    procedure Change_X(x: in out Integer; type_value: in Integer; rotation_value: in Integer);

    O: constant Brick_Points :=
        (1..4 => ((1, 1), (2, 1), (1, 2), (2, 2)));

    LR: constant Brick_Points :=
        (((1, 1), (1, 2), (1, 3), (2, 3)),
        ((1, 1), (2, 1), (3, 1), (1, 2)),
        ((2, 1), (3, 1), (3, 2), (3, 3)),
        ((3, 2), (1, 3), (2, 3), (3, 3)));

    LL: constant Brick_Points :=
        (((2, 1), (2, 2), (2, 3), (1, 3)),
        ((1, 1), (1, 2), (2, 2), (3, 2)),
        ((1, 1), (2, 1), (1, 2), (1, 3)),
        ((1, 1), (2, 1), (3, 1), (3, 2)));

    T: constant Brick_Points :=
        (((1, 1), (2, 1), (3, 1), (2, 2)),
        ((3, 1), (2, 2), (3, 2), (3, 3)),
        ((2, 2), (1, 3), (2, 3), (3, 3)),
        ((1, 1), (1, 2), (2, 2), (1, 3)));

    SL: constant Brick_Points :=
        (((2, 1), (3, 1), (1, 2), (2, 2)),
        ((2, 1), (2, 2), (3, 2), (3, 3)),
        ((2, 1), (3, 1), (1, 2), (2, 2)),
        ((2, 1), (2, 2), (3, 2), (3, 3)));

    SR: constant Brick_Points :=
        (((1, 1), (2, 1), (2, 2), (3, 2)),
        ((3, 1), (2, 2), (3, 2), (2, 3)),
        ((1, 1), (2, 1), (2, 2), (3, 2)),
        ((3, 1), (2, 2), (3, 2), (2, 3)));

    I: constant Brick_Points :=
        (((1, 1), (1, 2), (1, 3), (1, 4)),
        ((1, 1), (2, 1), (3, 1), (4, 1)),
        ((1, 1), (1, 2), (1, 3), (1, 4)),
        ((1, 1), (2, 1), (3, 1), (4, 1)));

    Bricks_List: constant Brick_List := 
        (O, LR, LL, T, SL, SR, I);

    xs: constant Offset_List :=
        ((0, 0),
         (0, -1),
         (0, -1),
         (0, -1),
         (0, -1),
         (0, -1),
         (0, -2));
        
end Bricks;