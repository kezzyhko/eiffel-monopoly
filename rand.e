note
	description: "Summary description for {MY_RANDOM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAND

create
	make

feature {NONE}
	r: RANDOM
	make
		local
	    	t: TIME
		do
	    	create t.make_now
	    	create r.set_seed(t.compact_time)
	    	r.start
		end

feature
	roll_dice: INTEGER
	    do
	    	Result := randint(1,4)
		end

	randint(min, max: INTEGER): INTEGER
	    do
	    	r.forth
	    	Result := r.item \\ (max-min) + min
		end
end
