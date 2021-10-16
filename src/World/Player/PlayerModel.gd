extends Node

export var player_id: int = 0 #идентификатор игрока
export var player_name := "Unknown"
export var ships = {} #количество кораблей на каждой планете
export var is_primary = false #Это текущий игрок, который играет с телефона?

var color: ColorRect


