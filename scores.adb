package body Scores is 
    task body Save_Score is
        score_value: Integer;
        score_changed: boolean;
        TimeDelay: Time := Clock;
        doQuit : boolean := false;
        begin
        loop
            TimeDelay := TimeDelay + milliseconds(5000);
            select 
                accept quit do
                    doQuit := true;
                end quit;
            or
                accept save_now do
                    Action.Get(score_value, score_changed);
                    if(score_changed) then
                        Ada.Text_IO.Create(Log, Ada.Text_IO.Out_File, "score.txt");
                        -- Ada.Text_IO.Put(Log, ASCII.ESC & "[1;1H");
                        IntIO.Put(Log, Integer(score_value));
                        Ada.Text_IO.Close(Log);

                        -- Stream_IO.Create(file, Stream_IO.Out_File, name);
                        -- stream :=  Stream_IO.Stream(file);
                        -- Integer'Write(stream, score_value);
                        --  Stream_IO.Close(File);
                    end if;
                end save_now;
            or  
                delay until TimeDelay;
            end select;

            if doQuit = true then
                exit;
            end if;
        end loop;
    end Save_Score;

end Scores;