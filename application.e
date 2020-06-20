note
	description: "Monopoly application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE}
	make
		local
			game: MONOPOLY_GAME
		do
			print("Amount of players: ")
			Io.read_integer
			create game.make(Io.last_integer)
			game.play
			game.screen.clear
			print("Winners:%N")
			across game.winners as w loop
				print(w.item.name + " - " + w.item.money.out + "RUB%N")
			end
			print("Other Players:%N")
			across game.players as p loop
				if not game.winners.has(p.item) then
					print(p.item.name + " - " + p.item.money.out + "RUB%N")
				end
			end
			
			--search - from cursor
			--lags - buffer
		end

end
