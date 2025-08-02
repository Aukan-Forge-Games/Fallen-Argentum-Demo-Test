extends CharacterBody2D

# @export var spawn_position : Vector2 = Vector2.ZERO
@export var walk_speed : float
@export var run_speed : float
@export var enemy_color_modulate : Color

var spawn_position : Vector2

var _velocity : Vector2 = Vector2.ZERO
var _previous_velocity : Vector2 = Vector2.ZERO

@onready var animated_sprite : AnimatedSprite2D = %CharacterAnimatedSprite

func _enter_tree():
  # hide self until a spawn position has been selected
  position = Vector2(-100, -100)
  set_multiplayer_authority(name.to_int())

func _ready():
  if is_multiplayer_authority():
    position = _find_viable_spawn_position()
    if position < Vector2.ZERO:
      push_error("Failed find viable spawn position")
      queue_free()
    # assign a random color to differentiate from other players
  else:
    modulate = enemy_color_modulate

func _physics_process(delta : float):
  if not is_multiplayer_authority():
    return
  # Build movement vector form directional input and run state.
  var run : bool = Input.is_action_pressed("run")
  _velocity = Input.get_vector("left", "right", "up", "down")
  _velocity *= run_speed if run else walk_speed
  # Detect changes in velocity, which are the only time animation must be updated.
  if not _previous_velocity.is_equal_approx(_velocity):
    animated_sprite.update_animation(_velocity, run)
  _previous_velocity = _velocity
  # Update position.
  position += _velocity * delta
  move_and_slide()

func _find_viable_spawn_position() -> Vector2:
  var vsize: Vector2 = Vector2(get_viewport().get_visible_rect().size)
  const ATTEMPTS : int = 100
  for i in range(ATTEMPTS):
    var pos: Vector2 = Vector2(randf_range(0.0, vsize.x), randf_range(0.0, vsize.y))
    if not test_move(Transform2D(0.0, pos), Vector2.ZERO):
      return pos
  return Vector2(-1.0, -1.0)
