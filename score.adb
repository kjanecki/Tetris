package body Score is 
    task body Save_Score is
        score_value: Integer;
        score_changed: boolean;
        TimeDelay: Time := Clock;

        begin
        loop
            TimeDelay := TimeDelay + milliseconds(5000);
            Action.Get(score_value, score_changed);
            if(score_changed) then
                Stream_IO.Create(file, Stream_IO.Out_File, name);
                stream :=  Stream_IO.Stream(file);
                Integer'Write(stream, score_value);
                 Stream_IO.Close(File);
            end if;
            delay until TimeDelay;
        end loop;
    end Save_Score;

end Score;