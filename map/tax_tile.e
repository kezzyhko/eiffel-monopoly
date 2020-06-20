note
	description: "Summary description for {PROPERTY_TILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAX_TILE

inherit
	TILE

create
	make

feature
	caption: STRING = "INCOME TAX PAY 10%%"
	passed(p: PLAYER)
		do
			do_nothing
		end
	landed(p: PLAYER)
		local
			tax: INTEGER
		do
			tax := p.money//10
			p.change_money(-tax)
			screen.change_message("You landed on tax tile, so you should pay " + tax.out + "RUB, press Return to do it")
			p.output(screen)
			screen.change_message("You paid " + tax.out + "RUB, press Return to switch to next player")
		end

end
