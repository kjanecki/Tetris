with Bricks;
use Bricks;
with Buffer;

package Bricks_Generator_Action is
    package BrickBuffer is new buffer(max => 3, element_type => Brick);

    protected Action is
        procedure Add (b: in Brick; is_buf_full: in out boolean);
        entry Get (b: in out Brick; is_buf_full: in out boolean);
        private
            is_full: boolean;
            is_empty: boolean;
            -- buf: Circular_Buffer;
    end Action;
        
end Bricks_Generator_Action;