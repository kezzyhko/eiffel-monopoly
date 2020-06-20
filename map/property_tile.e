note
	description: "Summary description for {PROPERTY_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_TILE

inherit
	TILE
		redefine
			insert
		end

create
	make_with_price

feature {NONE}
	make_with_price(a_name: STRING; a_price, a_rent: INTEGER; a_x, a_y: INTEGER; a_screen: SCREEN; a_map: MAP)
		require
			price_is_positive: a_price>0
			price_is_a_multiply_of_ten: a_price\\10=0
		do
			caption := a_name
			price := a_price
			rent := a_rent
			make(a_x, a_y, a_screen, a_map)
		ensure
			caption = a_name
			price = a_price
			rent = a_rent
			screen = a_screen
			map = a_map
			x = a_x
			y = a_y
		end

feature {MONOPOLY_GAME}
	remove_owner
		do
			owner := Void
		end

feature
	caption: STRING
	price, rent: INTEGER
	owner: detachable PLAYER

	passed(p: PLAYER)
		do
			do_nothing
		end
	landed(p: PLAYER)
		local
			s: STRING
		do
			if attached owner as o then
				p.change_money(-rent)
				o.change_money(rent)
			else
				if p.money<price then
					screen.change_message("You have not enough money to buy this, press Return to switch to next player")
					s := " "
				else
					screen.change_message("Do you want to buy %"" + caption + "%"? (Y for yes / anything else for no)")
					s := Io.last_string.as_lower
				end
				if Io.last_string.as_lower~"y" then
					p.change_money(-price)
					p.properties.force(Current)
					owner := p
				end
				p.output(screen)
				if Io.last_string.as_lower~"y" then
					screen.change_message("%"" + caption + "%" is yours now, press Return to switch to next player")
				else
					screen.change_message("Ok, press Return to switch to next player")
				end
			end
		end

	insert
		do
			default_insert

			--price inside
			screen.move_cursor(place.x+2, place.y+3)
			screen.insert(price.out + "RUB")
		end

end
