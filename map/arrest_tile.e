note
	description: "Summary description for {PROPERTY_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARREST_TILE

inherit
	TILE

create
	make

feature
	caption: STRING = "GO TO JAIL"
	passed(p: PLAYER)
		do
			do_nothing
		end
	landed(p: PLAYER)
		do
			screen.change_message("Press Return and go to jail")
			map.move_player(p, map.tiles[6])
			p.arrest
			p.output(screen)
			screen.change_message("Press Return to switch to next player")
		end

end
