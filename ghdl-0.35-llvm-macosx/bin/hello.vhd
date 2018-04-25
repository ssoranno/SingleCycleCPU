se std.textio.all; --  Imports the standard textio package.
    entity hello_world is
    end hello_world;
     
    architecture behaviour of hello_world is
    begin
      process
          variable l : line;
      begin
          write (l, String'("Hello world!"));
          writeline (output, l);
          wait;
      end process;
    end behaviour;
