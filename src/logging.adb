package body Logging is
   task body Log is
      use Ada.Text_IO;
      Verbosity : Verbosity_Level := Log_Error;
   begin
      loop
         select
            accept Set_Verbosity (User_Verbosity : Verbosity_Level) do
               Verbosity := User_Verbosity;
            end Set_Verbosity;
         or
            accept Info (Text : String; Suffix : String := 1*Ada.Characters.Latin_1.LF) do
               if Verbosity >= Log_Info then
                  Put (Standard_Error, Text & Suffix);
               end if;
            end Info;
         or
            accept Error (Text : String; Suffix : String := 1*Ada.Characters.Latin_1.LF) do
               if Verbosity >= Log_Error then
                  Put_Line (Standard_Error, Text & Suffix);
               end if;
            end Error;
         or
            terminate;
         end select;
      end loop;
   end Log;
end Logging;
