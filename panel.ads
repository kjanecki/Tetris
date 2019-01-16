
with Bricks;

package panel is

    height : constant Integer := 12;
    width : constant Integer := 12;

    subtype PanelHeight is Integer range 1..height-1;
    subtype PanelWidth is Integer range 1..width-2;

    subtype GraphValue is Integer range 0..2;

    subtype GraphWidth is Integer range 1..width-1;
    subtype GraphHeight is Integer range 1..height-1;

    type GraphType is array (GraphWidth, GraphHeight) of GraphValue;
    
    protected Graph is
        function getValue(x : GraphWidth; y : GraphHeight) return GraphValue;
        procedure setValue(x : GraphWidth; y : GraphHeight; val : GraphValue);
    private
        gameGraph : GraphType := (others => (others => GraphValue'First));
    end Graph;

    subtype RowCapacity is Integer range 0..width-2;
    maxRowCapacity : RowCapacity := width-2;
    rowCapacities : array(1..height-1) of RowCapacity := (others=> maxRowCapacity);

    type Direction is (Left,Right,Down,Up);

    type PanelPosition is record
        X : PanelWidth;
        Y : PanelHeight;
    end record;

    type FallingBrick is record
        shape : Bricks.Brick;
        x : Integer;
        y : Integer;
    end record;
    
    currentFallingBrick : FallingBrick;

    type Brick is array(Integer range 1..4) of PanelPosition;

    procedure drawElement(pos : PanelPosition; str : String);
    procedure initializeFallingBrick(b : out FallingBrick);
    procedure drawBrick(b : FallingBrick);
    procedure clearBrick(b : FallingBrick);
    function checkMovingPossibility(posx : Integer; posy : Integer) return Boolean;
    procedure moveBrick(b : in out FallingBrick; dir : Direction);
    procedure fallDown(b : in out FallingBrick);
    function isOnGround(b : in FallingBrick) return Boolean;
    function emplaceFallingBrick(b : in FallingBrick) return Boolean;
    procedure deleteFullRows(scoredPoints : in out Integer);
    procedure blink(rowIndex : in PanelHeight);
    procedure fallDownSettledBricks(startingRow : in PanelHeight);
    procedure gameOver;
 
    procedure moveFallingBrickLeft;
    procedure moveFallingBrickRight;
    procedure rotateFallingBrickLeft;
    procedure rotateFallingBrickRight;

    procedure quitGame(str : String);

    task game is
        entry quit;
    end game;
end panel;