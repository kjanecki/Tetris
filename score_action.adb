package body Score_Action is
  protected body Action is
    procedure Save(V: in Integer) is
    begin
        score := V;
        changed := true;
    end Save;

    entry Get(V: in out Integer; C: in out boolean) when changed is
    begin
      V := score;
      C := changed;
      changed := false;
    end Get;
  end Action;

end Score_Action;