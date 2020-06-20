note
	description: "Summary description for {SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCREEN

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE}
	make
		do
			create data.make_filled(' ', width, height)
			cursor := [1, 1]
			update
		end

feature
	width: INTEGER = 163
	height: INTEGER = 46
	data: ARRAY2[CHARACTER]
	cursor: TUPLE[x, y: INTEGER]

	clear
		do
			system("cls")
			print("%/27/[2J")
		end
		
	empty
		do
			make
			update
		end

	freeze(ms: INTEGER)
		do
			sleep(ms*1000000)
		end

	update
		local
			buffer: STRING
		do
			buffer := ""
			across 1 |..| height as y loop
				across 1 |..| width as x loop
					buffer.append(data[x.item,y.item].out)
				end
				buffer.append("%N")
			end
			clear
			print(buffer)
		end

	move_cursor(x, y: INTEGER)
		require
			in_bounds: in_bounds(x, y)
		do
			cursor := [x, y]
		end

	insert(s: STRING)
		local
			cursor_before: TUPLE[x, y: INTEGER]
		do
			cursor_before:=cursor.twin
			across s as c loop
				if c.item='%N' then
					cursor.x:=cursor_before.x
					cursor.y:=cursor.y+1
				elseif in_bounds(cursor.x,cursor.y) then
					data[cursor.x,cursor.y] := c.item
					cursor.x:=cursor.x+1
				end
			end
			if not in_bounds_x(cursor.x) then
				cursor.x:=width
			end
			if not in_bounds_y(cursor.y) then
				cursor.y:=height
			end
		end

	output(s: STRING)
		do
			insert(s)
			update
		end

	change_message(s: STRING)
		local
			eraser: STRING
		do
			eraser := " "
			eraser.multiply({TILE}.width*4-6)

			move_cursor({TILE}.width+2, {TILE}.height+2)
			insert(eraser)
			move_cursor({TILE}.width+2, {TILE}.height+2)
			output(s)
			Io.read_line
			move_cursor({TILE}.width+2, {TILE}.height+2)
			insert(eraser)
		end

feature --index validity checks
	in_bounds_x(x: INTEGER): BOOLEAN
		do
			Result := 1<=x and x<=width
		end
	in_bounds_y(y: INTEGER): BOOLEAN
		do
			Result := 1<=y and y<=height
		end
	in_bounds(x, y: INTEGER): BOOLEAN
		do
			Result := in_bounds_x(x) and in_bounds_y(y)
		end

invariant
	cursor_in_bounds: in_bounds(cursor.x, cursor.y)

end
