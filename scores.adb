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
                delay until TimeDelay;
            end select;

            if doQuit = true then
                exit;
            end if;

            Action.Get(score_value, score_changed);
            if(score_changed) then
                Stream_IO.Create(file, Stream_IO.Out_File, name);
                stream :=  Stream_IO.Stream(file);
                Integer'Write(stream, score_value);
                 Stream_IO.Close(File);
            end if;
            
        end loop;
    end Save_Score;

end Scores;