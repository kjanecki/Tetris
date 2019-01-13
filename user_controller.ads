with Ada.Real_Time, User_Controller_Action, Text_IO;
use Ada.Real_Time, User_Controller_Action;

package User_Controller is
  task Get_Input;
  task Execute;
end User_Controller;