note
	description: "Summary description for {MONOPOLY_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MONOPOLY_GAME

create
	make

feature {NONE}
	make(p: INTEGER)
		require
			from_two_to_six_players: 2<=p and p<=6
		do
			create winners.make(0)
			create players.make(0)
			across 1 |..| p as i loop
				print("Player #"+i.item.out+", enter your name: ")
				Io.read_line
				--TODO: check length
				players.force(create {PLAYER}.make(Io.last_string.twin))
			end

			create screen.make
			create map.make(players, screen)
			map.insert
		ensure
			players.count = p
			winners.count = 0
		end

feature
	k: INTEGER = 1000
	map: MAP
	screen: SCREEN
	players: ARRAYED_LIST[PLAYER]
	winners: ARRAYED_LIST[PLAYER]
	play
		local
			number_of_rounds_done, d1, d2, max: INTEGER
			current_player: PLAYER
			r: RAND
			t: TILE
			s: STRING
		do
			number_of_rounds_done := 0
			from until players.count-map.eliminated.players.count=1 or number_of_rounds_done>=100 loop
				across players as p loop current_player:=p.item
					if not map.eliminated.players.has(current_player) then
						create r.make
						d1 := r.roll_dice
						d2 := r.roll_dice
						
						current_player.output(screen)

						screen.change_message(current_player.name + "'s turn, press Return to roll dice")
						if current_player.in_jail>0 then
							if current_player.in_jail=1 then
								screen.change_message("It's your 3rd round in jail, so press Return to pay fine")
								s := "f"
							else
								screen.change_message("You are in the jail for " + (4-current_player.in_jail).out + " rounds, what are you going to do? (f to pay a fine / anything else to roll the dice)")
								s := Io.last_string.as_lower
							end
							if s~"f" then
								current_player.change_money(-50*k)
								current_player.set_free
								screen.change_message("You paid 50K RUB, press Return to continue")
							else
								if d1=d2 then
									screen.change_message("You rolled " + d1.out + "/" + d2.out + ", you are free, press Return to make a move")
									current_player.set_free
								else
									screen.change_message("You rolled " + d1.out + "/" + d2.out + ", you staying in the jail, press Return to continue")
								end
							end
						end
						if current_player.in_jail=0 then
							screen.change_message("You rolled " + d1.out + "/" + d2.out + ", press Return to make a move")
										--Io.read_integer
										--dice := Io.last_integer

							across 1 |..| (d1+d2) as moved loop
								screen.freeze(1000)
								t := map.after(map.find_player(current_player))
								map.move_player(current_player, t)
								t.passed(current_player)
							end
							t := map.find_player(current_player)
							t.landed(current_player)
						end

						if current_player.money<0 then
							map.move_player(current_player, map.eliminated)
							across current_player.properties as prop loop
								prop.item.remove_owner
							end
						end
					end
				end
				number_of_rounds_done := number_of_rounds_done + 1
			end

			--finding winner
			max := 0
			across players as p loop
				if p.item.money > max then
					max := p.item.money
				end
			end
			across players as p loop
				if p.item.money=max then
					winners.force(p.item)
				end
			end
		end
end
