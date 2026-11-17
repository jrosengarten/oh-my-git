extends Control

func _ready():
	var path = null
	
	var args = helpers.parse_args()
	if args.has("sandbox"):
		if args["sandbox"] is String:
			if args["sandbox"] == ".":
				args["sandbox"] = OS.get_environment("PWD")
			if DirAccess.dir_exists_absolute(args["sandbox"]):
				path = args["sandbox"]
			else:
				helpers.crash("DirAccess %s does not exist" % args["sandbox"])
	
	if path == null:
		path = game.tmp_prefix+"/repos/sandbox/"
		helpers.careful_delete(path)
		
		game.global_shell.run("mkdir '%s'" % path)
		game.global_shell.cd(path)
		game.global_shell.run("git init")
		game.global_shell.run("git symbolic-ref HEAD refs/heads/main")
	
	$Columns/Repository.path = path


	$Columns/Terminal.repository = $Columns/Repository

func update_repo():
	$Columns/Repository.update_everything()
