-- Ennemy
require 'engine/entity'
require 'constants'

attrs = {speed = 5, touch = false} -- attributes of monster
monsters = {} -- methods
monsters_list = {} -- contain all the monsters
timer = 0 -- timer to spawn
spawn_frequency = 1 -- monster spawn frequency
can_spawn = false -- if monster can spawn

function monsters.add(image, x, y, speed, m)
	if can_spawn == true then -- add monster to list
		monsters_list[table.getn(monsters_list)+1] = entity.initEntity(image, x, y)
		for i, attr in pairs(attrs) do
			monsters_list[table.getn(monsters_list)][i] = attr
		end
		monsters_list[table.getn(monsters_list)]['mouvement'] = m
		can_spawn = false
	end
end

function monsters.initSpawnTimer()
	timer = 0 -- reset timer
end

function monsters.updateSpawnTimer(dt)
	timer = timer + dt -- update timer & test if the monster can spawn
	if timer > spawn_frequency then
		can_spawn = true
		monsters.initSpawnTimer()
	end
end

function monsters.move(p)
	for i, e in pairs(monsters_list) do -- move all the monsters
		if e.mouvement == 'simple' then
			entity.moveEntity(e, 0, e.speed)
			if e.y > window['height'] then
				e.touch = true
			end
		elseif e.mouvement == 'turn' then
			if e.x > window['width'] or e.x < 0 then
				e.speed = -e.speed
			end
			entity.moveEntity(e, e.speed, 0)
		elseif e.mouvement == 'pounce' then
			monsters.specialMove1(e, p)
		end
	end
end

function monsters.specialMove1(monster, player)
	-- pounce on the ennemy
	local px = player.getX()
	local py = player.getY()

	local mx = monster.x
	local my = monster.y

	local vx = 0
	local vy = 0

	if mx > px then
			vx = -monster.speed
	elseif mx < px then
		  vx = monster.speed
	end

	if my > py then
		  vy = -monster.speed
	elseif my < py then
		  vy = monster.speed
	end

	entity.moveEntity(monster, vx, vy)

end

function monsters.verifTouch()
	local r = false
	for i, e in pairs(monsters) do
		if e.touch == true then
			r = true
			break
		end
	end
	return r
end
