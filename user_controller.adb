with panel;
with tetris;
with Ada.Text_IO;

package body User_Controller is 

    procedure quitGame is
    begin
        panel.game.quit;
        Get_Input.quit;
    end quitGame;

    task body Get_Input is
        option: character;
        setted: boolean;
        TimeDelay: Time := Clock;
        doQuit : boolean := false;
        begin
        loop
            TimeDelay := TimeDelay + milliseconds(50);
            select
                accept quit do
                    doQuit := true;
                end quit;
            or
                delay until TimeDelay;
            end select;

            if doQuit = true then
                exit;
            end if;

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
        end loop;
    end Get_Input;

    task body Execute is
        option: Action_Type;
        TimeDelay: Time := Clock;
        doQuit : boolean := false;
        begin
        loop
            TimeDelay := TimeDelay + milliseconds(50);
            if option = Quit then
                quitGame;
                exit;
            end if;

            Action.Get(option);
            case option is
                when Move_Left => panel.moveFallingBrickLeft;
                when Move_Right => panel.moveFallingBrickRight;
                when Rotate_Left => panel.rotateFallingBrickLeft;
                when Rotate_Right => panel.rotateFallingBrickRight;
                when Speed_Up => panel.game.speedUp;
                when Restart => panel.game.reset;
                when Quit => null;
            end case;
            delay until TimeDelay;
        end loop;
    end Execute;

end User_Controller;