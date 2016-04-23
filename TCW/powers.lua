-- Powers
-- Info : U = Unactive

require 'TCW/monsters'
require 'TCW/player'

powers = {} -- method of powers
memory = {} -- save the vars value before update

function powers.getPowerList()
		powers_list = {} -- list of powers
		powers_list[1] = {name = 'slowtime', cadence = 10, duration = 5, active = powers.setSlowTime, unactive = powers.setSlowTimeU}
		powers_list[2] = {name = 'stoptime',cadence = 10, duration = 5, active = powers.stopTime, unactive = powers.stopTimeU}
		powers_list[3] = {name = 'acceleratetime', cadence = 10, duration = 5, active = powers.accelerateTime, unactive = powers.accelerateTimeU}
		return powers_list
end

----------------------- TIME -------------------------
-- Slow the time (ennemy)
function powers.setSlowTime()
	memory['spawn_frequency'] = spawn_frequency
	spawn_frequency = 5
end

function powers.setSlowTimeU()
	spawn_frequency = memory['spawn_frequency']
	table.remove(memory, memory['spawn_frequency'])
end

-- Stop the time (ennemy)
function powers.stopTime()
	memory['speed'] = attrs['speed']
	for i, e in pairs(monsters_list) do
		e.speed = 0
	end
	attrs['speed'] = 0
end

function powers.stopTimeU()
	for i, e in pairs(monsters_list) do
		e.speed = memory['speed']
	end
	attrs['speed'] = memory['speed']
	table.remove(memory, memory['speed'])
end

-- Accelerate the time (bullets)
function powers.accelerateTime()
	memory['w_speed'] = playerAttrs.weapon['speed']
	memory['h_speed'] = playerAttrs.speed
	playerAttrs.weapon['speed'] = playerAttrs.weapon['speed'] + 5
	playerAttrs.speed = playerAttrs.speed + 50
end

function powers.accelerateTimeU()
	playerAttrs.weapon['speed'] = memory['w_speed']
	playerAttrs.speed = memory['h_speed']
	table.remove(memory, memory['w_speed'])
	table.remove(memory, memory['h_speed'])
end
