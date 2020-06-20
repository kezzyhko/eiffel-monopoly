note
	description: "Summary description for {PROPERTY_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHANCE_TILE

inherit
	TILE

create
	make

feature
	caption: STRING = "CHANCE"
	passed(p: PLAYER)
		do
			do_nothing
		end
	landed(p: PLAYER)
		local
			r: RAND
			m: INTEGER
		do
			create r.make
			m := r.randint(-30*k, 20*k)*10
			p.change_money(m)
			if m>0 then
				screen.change_message("You are very lucky and you will got " + m.out + "RUB, press Return to continue")
				p.output(screen)
				screen.change_message("press Return to switch to next player")
			elseif m<0 then
				screen.change_message("Sorry, you will lost " + (-m).out + "RUB, press Return to continue")
				p.output(screen)
				screen.change_message("press Return to switch to next player")
			else
				screen.change_message("Random decided not to change anything, press Return to switch to next player")
			end
		end

end
