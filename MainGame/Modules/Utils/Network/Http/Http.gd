extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func getPlayerPCKCompleted(result, response_code, headers, body):
	if response_code == 200:
		var playerModule = ProjectSettings.load_resource_pack("res://player.pck")
		if (playerModule):
			return MainMenu.connectServer(true)
	return MainMenu.missingLib("Player")

func test123():
	print_debug("Salt les louol")

func getPlayerPCK():
	var client = HTTPRequest.new();
	client.connect('request_completed', self, 'getPlayerPCKCompleted')
	add_child(client)
	client.set_download_file("res://player.pck")
	client.request(Config.URLPCK + "player.pck", ["Access-Control-Allow-Origin: *"])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
