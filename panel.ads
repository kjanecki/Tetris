
with buffer;
with output;
use output;
with Ada.Text_IO;
with Ada.Calendar;
use Ada.Calendar;
with bricks_generator;
with Bricks, Score;

package panel is

    height : constant Integer := 14;
    width : constant Integer := 12;

    subtype PanelHeight is Integer range 1..height-1;
    subtype PanelWidth is Integer range 1..width-2;

    subtype GraphValue is Integer range 0..2;

    subtype GraphWidth is Integer range 1..width-2;
    subtype GraphHeight is Integer range 1..height-1;

    type GraphType is array (GraphWidth, GraphHeight) of GraphValue;
    
    protected Graph is
        function getValue(x : GraphWidth; y : GraphHeight) return GraphValue;
        procedure setValue(x : GraphWidth; y : GraphHeight; val : GraphValue);
        procedure reset;
    private
        gameGraph : GraphType := (others => (others => GraphValue'First));
    end Graph;

    type RowsToBlinkArray is array(1..4) of GraphHeight;

    type RowsToBlink is record 
        buff : RowsToBlinkArray;
        rowsNumber : integer;
    end record;

    package BlinkBuffer is new buffer(max => 2, element_type => RowsToBlink);

    subtype RowCapacity is Integer range 0..GraphWidth'Last;
    maxRowCapacity : RowCapacity := RowCapacity'Last;
    rowCapacities : array(GraphHeight) of RowCapacity := (others=> maxRowCapacity);

    type RowsArray is array(PanelHeight'Range) of boolean;

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
    procedure findFullRows(r : in out RowsArray);
    procedure blink(rowIndex : in PanelHeight);
    procedure fallDownSettledBricks(rows : RowsToBlink; r : in out RowsArray);
    procedure gameOver;
 
    procedure moveFallingBrickLeft;
    procedure moveFallingBrickRight;
    procedure rotateFallingBrickLeft;
    procedure rotateFallingBrickRight;

    procedure quitGame(str : String);

    task blinker is
        entry quit;
    end blinker;    

    task game is
        entry deleteRows(rows : RowsToBlink);
        entry speedUp;
        entry reset;
        entry quit;
    end game;
end panel;