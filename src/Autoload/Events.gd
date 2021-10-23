# Autoloaded singleton that holds signals that would be troublesome to wire in a
# local parent or a scene owner.
# 
# This keeps objects passed through setup functions or unsafe accessors at a
# lower count, and can be replaced with simpler `Events.connect` calls.
extends Node

#signal player_died
#signal quit_requested

signal on_player_lose
signal on_player_win

signal node_spawned(node)

signal star_system_is_spawned(star_system) # звездная система образовалась - появилась во вселенной

# была выбрана планета на которой мы фокусируемся на данный момент
signal planet_is_selected(planet)
# На планету нажали и держат
signal planet_is_touching(planet, time_left)
#Запущены боты с планеты
signal planet_is_ship_launched(source, target, count)
signal planet_is_spawned(object) # Планета появилась
signal planet_is_depleted # Планета опустошена (нет ресурсов)
signal planet_free(planet) # Планета без владельца
signal planet_died # Планета уничтожена
signal planet_is_occupied(planet, owner) # Планета захвачена
signal planet_is_attacked(planet, ship) # Планета атакована
signal planet_is_damaged(target, damage, shooter) # Планета получила урон
signal planet_resource_changed(planet, value) # Изменение количества ресурсов на планете
signal planet_population_changed(planet, value) # Изменение количества населения на планете
signal planet_ship_changed(planet, value) # Количество кораблей на планете изменилось


# была выбрана звезда на которой мы фокусируемся на данный момент
signal star_is_selected(star)

#объект выбран для трекинга по камере. Объект должен быть GameObject
signal object_is_tracking(game_object)

#enum UpgradeChoices { HEALTH, SPEED, CARGO, MINING, WEAPON }
#enum UITypes { UPGRADE, QUIT }
