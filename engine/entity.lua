-- Entity module, for create, move and check collision between images
entity = {}

function entity.initEntity(image_src, x, y)

	m_entity = {}
	
	m_entity.image = love.graphics.newImage(image_src)

	m_entity.x = x
	m_entity.y = y
	m_entity.w = m_entity.image:getWidth()
	m_entity.h = m_entity.image:getHeight()

	return m_entity
end

function entity.moveEntity(m_entity, vx, vy)
	m_entity.x = m_entity.x + vx
	m_entity.y = m_entity.y + vy

	return m_entity
end

function entity.checkEntityCollision(entity_1, entity_2)
	return entity_1.x < entity_2.x+entity_2.w and
         entity_2.x < entity_1.x+entity_1.w and
         entity_1.y < entity_2.y+entity_2.h and
         entity_2.y < entity_1.y+entity_1.h
end
