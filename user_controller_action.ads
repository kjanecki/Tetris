package User_Controller_Action is
    type Action_Type is (Move_Left, Move_Right, Rotate_Left, Rotate_Right, Speed_Up, Restart, Quit);

    protected Action is
        procedure Set (A: in Action_Type);
        entry Get (A: in out Action_Type);
        private
            action: Action_Type;
            setted: boolean := false;
    end Action;

end User_Controller_Action;