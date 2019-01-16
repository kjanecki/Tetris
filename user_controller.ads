with Ada.Real_Time, User_Controller_Action, Text_IO, Panel;
use Ada.Real_Time, User_Controller_Action;

package User_Controller is

  procedure quitGame;

  task Get_Input is
    entry quit;
  end Get_Input;
  task Execute;
end User_Controller;