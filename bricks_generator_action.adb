package body Bricks_Generator_Action is
  protected body Action is
    procedure Add(b: in Brick; i: in out boolean) is
    begin
      if not is_full then
        BrickBuffer.CircularBuffer.add(b);
        is_empty := false;
        capacity := capacity + 1;

        if(capacity < 3) then
          is_full := false;
        else
          is_full := true;
        end if;
        
        i := is_full;
      end if;
    end Add;

    entry Get (b: in out Brick; i: in out boolean) when not is_empty is
    begin
        BrickBuffer.CircularBuffer.get(b);
        is_full := false;
        i := false;
        capacity := capacity - 1;

        if(capacity > 0) then
          is_empty := false;
        else
          is_empty := true;
        end if;

    end Get;
  end Action;

end Bricks_Generator_Action;