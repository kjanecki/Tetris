
package body panel is

    score : Integer := 0;

    protected body Graph is
        function getValue(x : GraphWidth; y : GraphHeight) return GraphValue is
        begin
            return gameGraph(x,y);
        end getValue;

        procedure setValue(x : GraphWidth; y : GraphHeight; val : GraphValue) is
        begin
            gameGraph(x,y) := val;
        end setValue;

        procedure reset is
        begin
            gameGraph := (others => (others => GraphValue'First));
        end reset;
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

    procedure findFullRows(r : in out RowsArray) is
        rows : RowsToBlinkArray := (others => GraphHeight'First);
        rowsNo : Integer := 0;
    begin
        for i in reverse PanelHeight'Range loop
            if rowCapacities(i) = 0 and r(i) /= true then
                r(i) := true;
                rows(rowsNo+1) := i;
                rowsNo := rowsNo + 1;
                score := score + 5;
                Score_Action.Action.Save(score);
                Scores.Save_Score.save_now;
            end if;
        end loop;
    
        if rowsNo /= 0 then    
            BlinkBuffer.CircularBuffer.add((buff => rows, rowsNumber => rowsNo));
        end if;
    end findFullRows;

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
    end blink;
    
    procedure fallDownSettledBricks(rows : RowsToBlink; r : in out RowsArray) is
    fullRows : array(GraphHeight'Range) of Integer := (others => 0);
    cnt : Integer := 0;
    begin
        for i in 1..rows.rowsNumber loop
            fullRows(rows.buff(i)) := 1;
        end loop;

        clearBrick(currentFallingBrick);
        for i in reverse GraphHeight'Range loop
            if fullRows(i) = 0 then
                if cnt /= 0 then
                    for j in GraphWidth'Range loop
                        if Graph.getValue(j,i) = 2 then
                            Graph.setValue(j,i, 0);
                            drawElement((x => j, y => i),"  "); 
                            drawElement((x => j, y => i+cnt),"[]");
                            Graph.setValue(j,i+cnt, 2);
                        end if;
                    end loop;
                    rowCapacities(i+cnt) := rowCapacities(i);   
                end if;
            else
                cnt := cnt + 1;
                rowCapacities(i) := maxRowCapacity;
                r(i) := false;
                for j in PanelWidth'Range loop
                    Graph.setValue(j,i, 0);
                    drawElement((x => j, y => i),"  ");
                end loop;
            end if;
        end loop;
        drawBrick(currentFallingBrick);
    end fallDownSettledBricks;

    procedure gameOver is
    begin
        Screen.clear;
        Screen.putString("Game Over.");
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

    task body blinker is

        procedure blinkRows(rows : RowsToBlink) is
        begin
            for i in 1..7 loop
                for j in 1..rows.rowsNumber loop
                    if i mod 2 = 0 then
                        Screen.draw((X => PanelWidth'First + 1, Y=> rows.buff(j)), "[][][][][][][][][][]");
                    else
                        Screen.draw((X => PanelWidth'First + 1, Y=> rows.buff(j)), "                    ");
                    end if;
                end loop;
                delay(Duration(0.2));
            end loop;
        end blinkRows;

        r : RowsToBlink;
        doQuit : Boolean := false;
    begin
        loop
            select
                accept quit do
                    doQuit := true;
                end quit;
            or
                delay Duration(0.1);
            end select;

            if doQuit = true then
                exit;
            end if;
            
            if BlinkBuffer.CircularBuffer.isEmpty = false then
                BlinkBuffer.CircularBuffer.get(r);
                blinkRows(r);
                game.deleteRows(r);
            end if;
        end loop;
    end blinker;

    procedure quitGame(str : String) is
    begin
        bricks_generator.TerminateGenerator;
        blinker.quit;
        Scores.Save_Score.quit;
        Screen.clear;
        Screen.draw((x=>1, y=>1),str);
        
    end quitGame;

    task body game is
        D : Duration := 0.4;
        T : Time;
        doQuit : Boolean := false;
        scorePos : Position;
        blinkingRows : RowsArray := (others => false);

        procedure init is
        begin
            score := 0;
            Graph.reset;
            rowCapacities := (others => maxRowCapacity);
            initializeFallingBrick(currentFallingBrick);
            Screen.clear;
            writeFrame((2*width)-2,height, scorePos);
            Screen.draw(scorePos, score'Img);
            drawBrick(currentFallingBrick); 
        end init;

    begin
        
        init;
        gameLoop: loop
            T := Clock;
            D := 0.4;
            select
                accept deleteRows(rows : RowsToBlink) do
                    fallDownSettledBricks(rows,blinkingRows);
                end deleteRows;
            or
                accept speedUp do
                    D := Duration(0);
                end speedUp;
            or
                accept reset do
                    init;
                end reset;
            or
                accept quit do
                    doQuit := True;    
                end quit;
            or
                delay until T + D;
            end select;

            if doQuit = true then
                quitGame("Quit game");
                exit gameLoop;
            end if;

            if isOnGround(currentFallingBrick) = true then
                score := score +1;
                Score_Action.Action.Save(score);
                Scores.Save_Score.save_now;
                if emplaceFallingBrick(currentFallingBrick) = true then
                    initializeFallingBrick(currentFallingBrick);
                    drawBrick(currentFallingBrick);
                    findFullRows(blinkingRows);
                    Screen.draw(scorePos, score'Img);
                else
                    init;
                end if;
            else
                fallDown(currentFallingBrick);

            end if;
        end loop gameLoop;
    end game;
end panel;