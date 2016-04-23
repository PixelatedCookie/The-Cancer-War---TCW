window = {}
window['height'] = 600
window['width'] = 600
window['title'] = 'The Cancer War'

controls = {}
controls['up'] = {0, -1}
controls['down'] = {0, 1}
controls['right'] = {1, 0}
controls['left'] = {-1, 0}

weapons = {}
weapons[1] = {name = 'Gun', image = 'engine/test/test_engine_image_2.png', speed = 300, damage = 1, cadence = 1}
weapons[2] = {name = 'Shoot Gun', image = 'engine/test/test_engine_image_2.png', speed = 150, damage = 1, cadence = 0.5}
weapons[3] = {name = 'Infinite Gun', image = 'engine/test/test_engine_image_2.png', speed = 300, damage = 1, cadence = 0}
