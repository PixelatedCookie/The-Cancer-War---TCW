require 'engine/entity'
require 'constants'

bullets = {}
bulletTables = {}

function bullets.createBulletTable(name, weapon)

  bulletTables[name] = {}
  bulletTables[name].weapon = weapon
  bulletTables[name].bullets = {}
  bulletTables[name].timer = 0
  bulletTables[name].can_use = true

end

function bullets.addBullet(tableName, x, y)

  if bulletTables[tableName].can_use == true then
    local bullet = entity.initEntity(bulletTables[tableName].weapon.image, x, y)
    table.insert(bulletTables[tableName].bullets, bullet)
    bulletTables[tableName].can_use = false
  end
  
end

function bullets.testCollision(tableName, tableEntity)
  for e1, a1 in pairs(bulletTables[tableName].bullets) do
    for e2, a2 in pairs(tableEntity) do
      if entity.checkEntityCollision(a1, a2) then
        table.remove(bulletTables[tableName].bullets, e1)
        table.remove(tableEntity, e2)
      end
    end
  end
end

function bullets.moveBullet(tableName, dt)

  for entity, attrs in pairs(bulletTables[tableName].bullets) do
    attrs.y = attrs.y - bulletTables[tableName].weapon.speed * dt
    if attrs.y > window['height'] then
      table.remove(bulletTables[tableName].bullets, entity)
    end
  end

end

function bullets.updateTimer(tableName, dt)

  bulletTables[tableName].timer = bulletTables[tableName].timer + dt
  if bulletTables[tableName].timer > bulletTables[tableName].weapon.cadence then
    bulletTables[tableName].can_use = true
    bulletTables[tableName].timer = 0
  end

end

function bullets.setWeapon(name, weapon)

  bulletTables[name].weapon = weapon

end
