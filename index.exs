defmodule P do

    def loop() do

	receive do

	    {:print, parent, str} ->
		IO.puts "From parent process: #{str}"
		send parent, :ok
		loop()

	    :get -> IO.puts "GET job"
		loop()

	    :create -> IO.puts "CREATE job"
		loop()

	    :update -> IO.puts "UPDATE job"
		loop()

	    :delete -> IO.puts "DELETE job"
		loop()

	    :stop -> IO.puts "Bye!"

	end


    end

    def loop(pid) do

	data = String.trim IO.gets "1: get; \n2: create; \n3: update; \n4: delete; \n5: stop; \n_: print\nYour action:\n"

	case data do

	    "1" -> send pid, :get; loop pid
	    "2" -> send pid, :create; loop pid
	    "3" -> send pid, :update; loop pid
	    "4" -> send pid, :delete; loop pid
	    "5" -> send pid, :stop
	     _ -> send pid, {:print, self(), data}

		receive do

	            :ok -> :read

		end

		loop pid

	end

    end

end

p1 = spawn fn -> P.loop() end

P.loop p1
