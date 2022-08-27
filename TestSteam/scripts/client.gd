extends Node3D

var steam_network: SteamNetworkPeer

# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_steam()
	steam_network = SteamNetworkPeer.new()
	Steam.lobby_joined.connect(_lobbyJoined)
	steam_network.connection_succeeded.connect(_connected)
	steam_network.create_client(109775243816582248)
	multiplayer.set_multiplayer_peer(steam_network)


func _initialize_steam():
	var init := Steam.steamInit()
	print("Did steam initialized?: ", init)

func _lobbyCreated(_connect, lobbyId):
	print(lobbyId)

func _lobbyJoined(id, _permission, _locked, _response):
	print(id)
	# rpc_id(1, "test")

func _connected():
	print("connected !")
	rpc("test")

func _process(_delta):
	Steam.run_callbacks()

@rpc(any_peer)
func test():
	print("receive test !")
