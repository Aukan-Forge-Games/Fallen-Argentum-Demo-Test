extends AnimatedSprite2D

const UP_POSTFIX    : String = "_up"
const DOWN_POSTFIX  : String = "_down"
const RIGHT_POSTFIX : String = "_right"
const LEFT_POSTFIX  : String = "_left"

func update_animation(new_heading : Vector2, running : bool):
  if new_heading.is_zero_approx():
    if animation.ends_with(UP_POSTFIX):
      play("idle_up")
    elif animation.ends_with(DOWN_POSTFIX):
      play("idle_down")
    elif animation.ends_with(RIGHT_POSTFIX):
      play("idle_right")
    elif animation.ends_with(LEFT_POSTFIX):
      play("idle_left")
  else:
    # If the direction is deviated by an additional input (diagonal movement),
    # make no animation change.
    var direction_deviated : bool = (
      (animation.begins_with("run") or animation.begins_with("walk"))
      and (
        (new_heading.y < 0.0 and animation.ends_with(UP_POSTFIX)) or
        (new_heading.y > 0.0 and animation.ends_with(DOWN_POSTFIX)) or
        (new_heading.x > 0.0 and animation.ends_with(RIGHT_POSTFIX)) or
        (new_heading.x < 0.0 and animation.ends_with(LEFT_POSTFIX))
      )
    )
    # If the speed is changed, change animation.
    var speed_changed : bool = (
      (running and animation.begins_with("walk_")) or
      (not running and animation.begins_with("run_"))
    )
    if not direction_deviated or speed_changed:
      var anim : String = "run_" if running else "walk_"
      if new_heading.x > 0.0:
        anim += "right"
      elif new_heading.x < 0.0:
        anim += "left"
      elif new_heading.y > 0.0:
        anim += "down"
      elif new_heading.y < 0.0:
        anim += "up"
      play(anim)
