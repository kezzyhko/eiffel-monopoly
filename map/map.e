note
	description: "Summary description for {MAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAP

create
	make

feature {NONE}
	k: INTEGER = 1000
	screen: SCREEN
	make(players: ARRAYED_LIST[PLAYER]; a_screen: SCREEN)
		do
			screen := a_screen
			create tiles.make(0)
			create eliminated.make_with_caption("ELIMINATED", 5,5, screen,Current)
			tiles.force(create {START_TILE}.make_with_players(players, 6,6, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Christ the Redeemer", 60*k,2*k, 5,6, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Luang Pho To", 60*k,4*k, 4,6, screen,Current))
			tiles.force(create {TAX_TILE}.make(3,6, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Alyosha monument", 80*k,4*k, 2,6, screen,Current))
			tiles.force(create {DO_NOTHING_TILE}.make_with_caption("JAIL", 1,6, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Tokyo Wan Kannon", 100*k,6*k, 1,5, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Luangpho Yai", 120*k,8*k, 1,4, screen,Current))
			tiles.force(create {CHANCE_TILE}.make(1,3, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("The Motherland", 160*k,12*k, 1,2, screen,Current))
			tiles.force(create {DO_NOTHING_TILE}.make_with_caption("FREE PARKING", 1,1, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Awaji Kannon", 60*k,18*k, 2,1, screen,Current))
			tiles.force(create {CHANCE_TILE}.make(3,1, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Rodina-Mat' Zovyot!", 260*k,22*k, 4,1, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Great Buddha of Thailand", 280*k,22*k, 5,1, screen,Current))
			tiles.force(create {ARREST_TILE}.make(6,1, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Laykyun Setkyar", 320*k,28*k, 6,2, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Spring Temple Buddha", 360*k,35*k, 6,3, screen,Current))
			tiles.force(create {CHANCE_TILE}.make(6,4, screen,Current))
			tiles.force(create {PROPERTY_TILE}.make_with_price("Statue of Unity", 400*k,50*k, 6,5, screen,Current))
		end

feature
	tiles: ARRAYED_LIST[TILE]
	eliminated: DO_NOTHING_TILE

	insert
		do
			across tiles as tile loop
				tile.item.insert
			end
			eliminated.insert
		end

	move_player(p: PLAYER; t: TILE)
		do
			across tiles as tile loop
				if tile.item.players.has(p) then
					tile.item.players.prune_all(p)
					tile.item.insert
				end
			end
			t.players.force(p)
			t.insert
			screen.update
		end

	find_player(p: PLAYER): TILE
		do
			Result := tiles[1] --I HATE VOID SAFETY
			across tiles as tile loop
				if tile.item.players.has(p) then
					Result := tile.item
				end
			end
		end

	after(t: TILE): TILE
		do
			tiles.start
			tiles.search(t)
			tiles.forth
			if tiles.off then
				tiles.start
			end
			Result := tiles.item
		end
end
