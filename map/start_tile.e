note
	description: "Summary description for {PROPERTY_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	START_TILE

inherit
	TILE

create
	make_with_players

feature {NONE}
	make_with_players(a_players: ARRAYED_LIST[PLAYER]; a_x, a_y: INTEGER; a_screen: SCREEN;a_map: MAP)
		do
			make(a_x, a_y, a_screen, a_map)
			players := a_players.twin
		ensure
			players ~ a_players
			x = a_x
			y = a_y
			screen = a_screen
			map = a_map
		end

feature
	caption: STRING = "GO"
	passed(p: PLAYER)
		do
			p.change_money(200*k)
			screen.change_message("You passed start tile, press Return to collect 200K RUB")
			p.output(screen)
			screen.change_message("You collected 200K RUB, press Return to switch to next player")
		end
	landed(p: PLAYER)
		do
			do_nothing
		end

end
