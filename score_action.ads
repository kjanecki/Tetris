package Score_Action is

    protected Action is
        procedure Save (V: in Integer);
        entry Get (V: in out Integer; C: in out boolean);
        private
            score: Integer := 0;
            changed: boolean := false;
    end Action;

end Score_Action;