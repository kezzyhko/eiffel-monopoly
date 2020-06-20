note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make

feature {NONE}
	k: INTEGER = 1000
	make(a_name: STRING)
		do
			name := a_name
			money := 1500*k
			create properties.make(0)
		ensure then
			name = a_name
			money = 1500*k
			properties.count = 0
		end

feature {MONOPOLY_GAME,TILE}
	change_money(amount: INTEGER)
		do
			money := money + amount
		end
	arrest
		do
			in_jail := 3
		end
	set_free
		do
			in_jail := 0
		end

feature
	name: STRING
	money: INTEGER
	in_jail: INTEGER
	properties: ARRAYED_LIST[PROPERTY_TILE]

	output(screen: SCREEN)
		local
			eraser: STRING
		do
			screen.move_cursor({TILE}.width+2, {TILE}.height+4)
			eraser := " "
			eraser.multiply({TILE}.width*3-6)
			eraser.append("%N")
			eraser.multiply({TILE}.height*4-8)
			screen.insert(eraser)

			screen.move_cursor({TILE}.width+2, {TILE}.height+4)
			screen.insert("Name: " + name + "%N")
			screen.insert("Money: " + money.out + "%N")
			if in_jail>0 then
				screen.insert("Arrested%N")
			end
			if not properties.is_empty then
				screen.insert("Properties: ")

				screen.move_cursor({TILE}.width+4, {TILE}.height+7)
				across properties as prop loop
					screen.insert(prop.item.caption)
				end
			end
			screen.update
		end
end
