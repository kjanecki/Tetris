package body Bricks_Generator_Action is
  protected body Action is
    procedure Add(b: in Brick; is_buf_full: in out boolean) is
    begin
      if not is_full then
        BrickBuffer.CircularBuffer.Add(b);
        is_buf_full := is_full;
      end if;
    end Add;

    entry Get (b: in out Brick; is_buf_full: in out boolean) when not is_empty is
    begin
        -- buf.Get(b, is_full, is_empty);
        BrickBuffer.CircularBuffer.get(b);
        is_buf_full := is_full;
    end Get;
  end Action;

end Bricks_Generator_Action;