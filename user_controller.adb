with panel;

package body User_Controller is 
    task body Get_Input is
        option: character;
        setted: boolean;
        TimeDelay: Time := Clock;

        begin
        loop
            Text_IO.Get_Immediate(option, setted);
            if setted then
                case option is
                    when 'a' => Action.Set(Move_Left);
                    when 'd' => Action.Set(Move_Right);
                    when 'q' => Action.Set(Rotate_Left);
                    when 'e' => Action.Set(Rotate_Right);
                    when 's' => Action.Set(Speed_Up);
                    when 'R' => Action.Set(Restart);
                    when 'Q' => Action.Set(Quit);
                    when others => null;
                end case;
            end if;
            TimeDelay := TimeDelay + milliseconds(10);
            delay until TimeDelay;
        end loop;
    end Get_Input;

    task body Execute is
        option: Action_Type;
        TimeDelay: Time := Clock;

        begin
        loop
            Action.Get(option);
            case option is
                when Move_Left => panel.moveFallingBrickLeft;
                when Move_Right => panel.moveFallingBrickRight;
                when Rotate_Left => panel.rotateFallingBrickLeft;
                when Rotate_Right => panel.rotateFallingBrickRight;
                when Speed_Up => null;
                when Restart => null;
                when Quit => null;
            end case;
            TimeDelay := TimeDelay + milliseconds(10);
            delay until TimeDelay;
        end loop;
    end Execute;

end User_Controller;