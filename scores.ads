with Ada.Real_Time, Score_Action, Ada, Ada.Text_IO, Ada.Streams, Ada.Streams.Stream_IO;
use Ada.Real_Time, Score_Action, Ada, Ada.Streams;

package Scores is
  package  IntIO is new Ada.Text_IO.Integer_IO (Integer);
  Log : Ada.Text_IO.File_Type;

  task Save_Score is
    entry save_now;
    entry quit;
  end Save_Score;
  private
    name: String := "score.txt";
    file: Stream_IO.File_Type;
    stream: Stream_IO.Stream_Access;
end Scores;