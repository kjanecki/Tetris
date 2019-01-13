package body User_Controller_Action is
  protected body Action is
    procedure Set(A: in Action_Type) is
    begin
      action := A;
      setted := true;
    end Set;

    entry Get (A: in out Action_Type) when setted is
    begin
      A := action;
      setted := false;
    end Get;
  end Action;

end User_Controller_Action;
