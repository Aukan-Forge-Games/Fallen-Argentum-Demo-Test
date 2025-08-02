extends Control

@onready var start_server_button: Button = %StartServerButton
@onready var connect_button: Button = %ConnectButton

func _ready():
  start_server_button.pressed.connect(_on_start_server_button_pressed)
  connect_button.pressed.connect(_on_connect_button_pressed)

func _on_start_server_button_pressed():
  MultiplayerHandler.start_server()
  visible = false

func _on_connect_button_pressed():
  MultiplayerHandler.start_client()
  visible = false
