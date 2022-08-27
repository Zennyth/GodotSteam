extends Node

var steam_network: SteamNetworkPeer
@onready var label: TextEdit = $"TextEdit"

var connected_player: int

func _ready():
	_initialize_Steam()

func _initialize_Steam() -> void:
	var init: Dictionary = Steam.steamInit()
	print("Did Steam initialize?: "+str(init))

	if init['status'] != 1:
		print("Failed to initialize Steam. "+str(init['verbal'])+" Shutting down...")
		get_tree().quit()
	
	steam_network = SteamNetworkPeer.new()
	Steam.lobby_created.connect(_lobbyCreated)
	multiplayer.peer_connected.connect(_peer_connected)
	steam_network.create_server(1, 2)
	multiplayer.set_multiplayer_peer(steam_network)

func _lobbyCreated(_connect: int, lobbyId: int):
	print(lobbyId)
	label.text = str(lobbyId)

func _process(_delta: float) -> void:
	Steam.run_callbacks()
	
func _peer_connected(player_id):
	print("User " + str(player_id) + " is connected !")
	# rpc_id(connected_player, "test")

@rpc(any_peer)
func test():
	print("receive test !")
