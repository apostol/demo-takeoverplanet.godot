class_name StarSystemSetings
extends Node

const Size: float = 1600.0
const Planet := {
	"count": {
		"min": 3,
		"max": 10
	},
	"radius": {
		"min": 100,
		"max": 100
	},
	"orbit": {
		"min": 200, #radius.min * 2
		"max": 1000
	}
}
