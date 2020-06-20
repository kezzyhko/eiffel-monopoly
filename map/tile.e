note
	description: "Summary description for {TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TILE

feature {NONE}
	x, y: INTEGER
	screen: SCREEN
	map: MAP
	make(a_x, a_y: INTEGER; a_screen: SCREEN; a_map: MAP)
		do
			x:=a_x
			y:=a_y
			create players.make(0)
			screen := a_screen
			map := a_map
		ensure
			x=a_x
			y=a_y
			screen = a_screen
			map = a_map
		end

feature {TILE}
	place: TUPLE[x, y: INTEGER]
		do
			Result := [(x-1)*(width-1)+1, (y-1)*(height-1)+1]
		end

	default_insert
		local
			s1, s2: STRING
		do
			s1:="."
			s1.multiply(width)
			s2:=".%N"
			s2.multiply(height-2)

			--top, left & bottom borders
			screen.move_cursor(place.x, place.y)
			screen.insert(s1+"%N"+s2+s1)

			--right border
			screen.move_cursor(place.x+width-1, place.y+1)
			screen.insert(s2)

			--text inside
			screen.move_cursor(place.x+2, place.y+2)
			screen.insert(caption)

			--players inside
			screen.move_cursor(place.x+2, place.y+5)
			s1:=""
			across players as p loop
				s1.append(p.item.name + " ")
			end
			s2:=" "
			s2.multiply(width-3-s1.count)
			screen.insert(s1+s2)
		end

feature --constants
	k: INTEGER = 1000
	width: INTEGER = 28
	height: INTEGER = 8

feature {MONOPOLY_GAME,MAP}
	caption: STRING
		deferred
		end
	passed(p: PLAYER)
		deferred
		end
	landed(p: PLAYER)
		deferred
		end

	insert
		do
			default_insert
		end

	players: ARRAYED_LIST[PLAYER]
end
