with Bricks, Buffer;
use Bricks;

package Bricks_Generator_Action is
    package BrickBuffer is new buffer(max => 3, element_type => Brick);

    protected Action is
        procedure Add (b: in Brick; i: in out boolean);
        entry Get (b: in out Brick; i: in out boolean);
        entry preview (b: in out Brick; i: in out boolean);
        private
            is_full: boolean := false;
            is_empty: boolean := true;
            capacity: Integer := 3;
    end Action;
        
end Bricks_Generator_Action;