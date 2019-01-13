with output;
use output;
with Ada.Text_IO;
with Ada.Calendar;
use Ada.Calendar;
with bricks_generator;

package body panel is

    protected body Graph is
        function getValue(x : GraphWidth; y : GraphHeight) return GraphValue is
        begin
            return gameGraph(x,y);
        end getValue;

        procedure setValue(x : GraphWidth; y : GraphHeight; val : GraphValue) is
        begin
            gameGraph(x,y) := val;
        end setValue;
    end Graph;

    procedure drawElement(pos : PanelPosition; str : String) is
    begin
        Screen.draw((x => pos.x*2, y => pos.y), str);
    end drawElement;

    procedure initializeFallingBrick(b : out FallingBrick) is
    begin
        b.y := 0;
        b.x := 3;
        bricks_generator.get(b.shape);
    end initializeFallingBrick;

    procedure drawBrick(b : FallingBrick) is
    it : PanelPosition;
    begin
        for i in 1..b.shape.points'Last loop
            it := (x => b.shape.points(i).x+b.x, y => b.shape.points(i).y+b.y);
            rowCapacities(it.y) := rowCapacities(it.y) - 1;
            drawElement(it, "[]");  
            Graph.setValue(it.x, it.y, 1);                     
        end loop;
    end drawBrick;

    procedure clearBrick(b : FallingBrick) is
    it : PanelPosition;
    begin
        for i in 1..b.shape.points'Last loop
            it := (b.shape.points(i).x+b.x, y => b.shape.points(i).y+b.y);
            rowCapacities(it.y) := rowCapacities(it.y) + 1;
            drawElement(it,"  ");       
            Graph.setValue(it.x, it.y, 0);                
        end loop;
    end clearBrick;

    function checkMovingPossibility(posx : Integer; posy : Integer) return Boolean is
    begin
        if posx < PanelWidth'First or posx > PanelWidth'Last then
            return false;
        elsif Graph.getValue(posx, posy) = 2 then
            return false;
        end if;
        return true;
    end checkMovingPossibility;

    procedure moveBrick(b : in out FallingBrick; dir : Direction) is
    xStep : Integer := 0;
    yStep : Integer := 0;
    isMovingPossible : Boolean := true;
    posx : Integer;
    posy : Integer;
    begin
        case dir is
            when Left => xStep := -1;
            when Right => xStep := 1;
            when Down => yStep := 1;
            when Up => yStep := -1;
        end case;
        if dir = Left or dir = Right then
            for i in b.shape.points'range loop
                posx := b.shape.points(i).x + b.x + xStep; 
                posy := b.shape.points(i).y + b.y + yStep;
                if checkMovingPossibility(posx, posy) = false then
                    isMovingPossible := false;
                    exit;
                end if;
            end loop;   
        end if;

        if isMovingPossible = true then
            b.x := b.x + xStep;
            b.y := b.y + yStep;
        end if;
    end moveBrick;

    function isOnGround(b: in FallingBrick) return Boolean is
    begin
        
        for i in 1..b.shape.points'Last loop
            if b.shape.points(i).y+b.y = PanelHeight'Last then
                return true;
            elsif Graph.getValue(b.shape.points(i).x+b.x, (b.shape.points(i).y+b.y)+1) = 2 then 
                return true;
            end if;  
        end loop;

        return false;
    end isOnGround;

    procedure fallDown(b: in out FallingBrick) is
    begin
        clearBrick(b);
        moveBrick(b,Down);
        drawBrick(b);
    end fallDown;

    function emplaceFallingBrick(b : in FallingBrick) return Boolean is
    begin
        for i in 1..b.shape.points'last loop
            if b.shape.points(i).y+b.y = 1 then
                gameOver;
                return false;
            end if;
            Graph.setValue(b.shape.points(i).x+b.x, b.shape.points(i).y+b.y, 2);
        end loop;
        return true;
    end emplaceFallingBrick;

    procedure deleteFullRows is
    begin
        for i in reverse PanelHeight'Range loop
            while rowCapacities(i) = 0 loop
                blink(i);
                fallDownSettledBricks(i);
            end loop;
        end loop;
    end deleteFullRows;

    procedure blink(rowIndex : in PanelHeight) is

    begin
        for i in 1..7 loop
            if i mod 2 = 0 then
                Screen.draw((X => PanelWidth'First + 1, Y=> rowIndex), "[][][][][][][][][][]");
            else
                Screen.draw((X => PanelWidth'First + 1, Y=> rowIndex), "                    ");
            end if;
            delay(Duration(0.2));
        end loop;
        for i in PanelWidth'Range loop
            Graph.setValue(i, rowIndex, 0);
        end loop;
        rowCapacities(rowIndex) := maxRowCapacity;
    end blink;
    
    procedure fallDownSettledBricks(startingRow : in PanelHeight) is
    r : PanelHeight;
    begin
        r := startingRow - 1;
        while rowCapacities(r) < maxRowCapacity loop
            for i in PanelWidth'Range loop
                if Graph.getValue(i,r) = 2 then
                    Graph.setValue(i,r,0);
                    drawElement((x => i, y => r),"  "); 
                    drawElement((x => i, y => r+1),"[]");
                    Graph.setValue(i,r+1, 2);
                end if;
            end loop;
            rowCapacities(r+1) := rowCapacities(r);
            rowCapacities(r) := maxRowCapacity;
            r := r - 1;
        end loop;
    end fallDownSettledBricks;

    procedure gameOver is
    begin
        Screen.clear;
        Ada.Text_IO.Put_Line("Game Over.");
    end gameOver;

    procedure moveFallingBrickLeft is
    begin
        clearBrick(currentFallingBrick);
        moveBrick(currentFallingBrick, Left);
        drawBrick(currentFallingBrick);
    end moveFallingBrickLeft;

    procedure moveFallingBrickRight is
    begin
        clearBrick(currentFallingBrick);
        moveBrick(currentFallingBrick, Right);
        drawBrick(currentFallingBrick);
    end moveFallingBrickRight;

    procedure rotateFallingBrickLeft is
    B : bricks.Brick;
    isRotationPossible : Boolean := true;
    newx : Integer := 0;
    begin
        b := currentFallingBrick.shape;
        newx := currentFallingBrick.x;
        bricks.Rotate_Left(b, newx);
        
        for i in b.points'Range loop
            if checkMovingPossibility(b.points(i).x + newx,
                b.points(i).y + currentFallingBrick.y) = false then
                isRotationPossible := false;
                exit;
            end if;
        end loop;

        if isRotationPossible = true then
            clearBrick(currentFallingBrick);
            currentFallingBrick.shape := b;
            currentFallingBrick.x := newx;
            drawBrick(currentFallingBrick);
        end if;
    end rotateFallingBrickLeft;

    procedure rotateFallingBrickRight is
    B : bricks.Brick;
    isRotationPossible : Boolean := true;
    newx : Integer := 0;
    begin
        b := currentFallingBrick.shape;
        bricks.Rotate_Right(b, newx);
        
        for i in b.points'Range loop
            if checkMovingPossibility(b.points(i).x + currentFallingBrick.x,
                b.points(i).y + currentFallingBrick.y) = false then
                isRotationPossible := false;
                exit;
            end if;
        end loop;

        if isRotationPossible = true then
            clearBrick(currentFallingBrick);
            currentFallingBrick.shape := b;
            -- currentFallingBrick.x := newx;
            drawBrick(currentFallingBrick);
        end if;
    end rotateFallingBrickRight;

    procedure main is
    D : Duration := 0.3;
    T : Time;
    begin

        initializeFallingBrick(currentFallingBrick);
        Screen.clear;
        writeFrame(12,22);
        drawBrick(currentFallingBrick);
        delay(Duration(1));

        gameLoop: loop
            T := Clock;
            if isOnGround(currentFallingBrick) = true then
                if emplaceFallingBrick(currentFallingBrick) = true then
                    initializeFallingBrick(currentFallingBrick);
                    drawBrick(currentFallingBrick);
                    deleteFullRows;
                else
                    exit gameLoop;
                end if;
            else
                fallDown(currentFallingBrick);
            end if;
            delay until T + D;
            delay D;
        end loop gameLoop;
    end main;
end panel;