-- Player
-- require 'TCW/powers'
require 'engine/entity'
require 'TCW/bullets'
require 'constants'

player = {} -- contain the methods
playerAttrs = {} -- contain the attributes

--- Player
function player.init(image, x, y)
	-- init all the playerAttrs vars
	playerAttrs = entity.initEntity(image, x, y) -- create an entity
	playerAttrs.speed = 100

	playerAttrs.weapon = weapons[1] -- create weapon
	bullets.createBulletTable('player', playerAttrs.weapon)

	playerAttrs.life = 1 -- life of the player

	playerAttrs.power = {
		w = powers.getPowerList()[1],
		x = powers.getPowerList()[2],
		c = powers.getPowerList()[3],
	}

end

function player.move(vx, vy)
	entity.moveEntity(playerAttrs, vx, vy) -- move the playerAttrs
end

function player.testCollision(e_list)
	for i,e in pairs(e_list) do -- check collision between a list of entity and the playerAttrs
		if entity.checkEntityCollision(playerAttrs, e) then
			playerAttrs.life = playerAttrs.life - 1
		end
	end
end

-- Bullets
function player.fire()
	bullets.addBullet('player', playerAttrs.x, playerAttrs.y)
end

function player.updateBulletTimer(dt)
	-- for the cadence of the shoot
	bullets.updateTimer('player', dt)
end

function player.moveBullets(dt)
	bullets.moveBullet('player', dt)
end

function player.testBulletCollision(e_list)
	bullets.testCollision('player', e_list)
end

-- Power
function player.initPower()
	for key, powerAttrs in pairs(playerAttrs.power) do
		powerAttrs.p_timer = 0
		powerAttrs.p_timer2 = 0
		powerAttrs.can_use = true
		powerAttrs.in_use = false
	end
end

function player.usePower(key)
	if playerAttrs.power[key].can_use == true then
		pcall(playerAttrs.power[key].active)
		playerAttrs.power[key].can_use = false
		playerAttrs.power[key].in_use = true
	end
end

function player.updatePowerTimer(dt)
	for key, powerAttrs in pairs(playerAttrs.power) do
		if powerAttrs.can_use == false then
			powerAttrs.p_timer = powerAttrs.p_timer + dt
			if powerAttrs.p_timer > powerAttrs.cadence then
				powerAttrs.can_use = true
				powerAttrs.p_timer = 0
			end
		end

		if powerAttrs.in_use == true then
			powerAttrs.p_timer2 = powerAttrs.p_timer2 + dt
			if powerAttrs.p_timer2 > powerAttrs.duration then
				pcall(powerAttrs.unactive)
				powerAttrs.p_timer2 = 0
				powerAttrs.in_use = false
			end
		end
	end
end




-- Attributes
function player.getX()
	return playerAttrs.x
end

function player.getY()
	return playerAttrs.y
end

function player.getSpeed()
	return playerAttrs.speed
end

function player.getEntityImage()
	return playerAttrs.image
end

function player.getBulletList()
	return bulletTables['player'].bullets
end

function player.setWeapon(weapon_name)
	playerAttrs.weapon = weapons[weapon_name]
	bullets.setWeapon('player', playerAttrs.weapon)
end
