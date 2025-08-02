extends Node2D

@export var dawn_modulate: Color
@export var midday_modulate: Color
@export var dusk_modulate: Color
@export var night_modulate: Color

@onready var _modulate_series: Array[Color] = [
  midday_modulate,
  dusk_modulate,
  night_modulate,
  dawn_modulate
]

var _time_index : int = 0

@rpc("any_peer")
func toggle_time_of_day():
  print("toggle_time_of_day called")
  _time_index = (_time_index + 1) % 4
  modulate = _modulate_series[_time_index]
