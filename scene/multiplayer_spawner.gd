extends MultiplayerSpawner

@export var player_scene: PackedScene

func _ready():
  multiplayer.peer_connected.connect(_spawn_player)

func _spawn_player(id: int):
  if not multiplayer.is_server():
    return
  var player: Node = player_scene.instantiate()
  player.name = str(id)
  get_node(spawn_path).call_deferred("add_child", player)
