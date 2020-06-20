note
	description: "Summary description for {PROPERTY_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DO_NOTHING_TILE

inherit
	TILE

create
	make_with_caption

feature {NONE}
	make_with_caption(a_caption: STRING; a_x,a_y: INTEGER; a_screen: SCREEN; a_map: MAP)
		do
			caption := a_caption
			make(a_x, a_y, a_screen, a_map)
		ensure
			caption = a_caption
			x=a_x
			y=a_y
			screen = a_screen
			map = a_map
		end

feature
	caption: STRING
	passed(p: PLAYER)
		do
			do_nothing
		end
	landed(p: PLAYER)
		do
			do_nothing
			--p.change_money(-999999)
			screen.change_message("Press Return to switch to next player")
		end

end
