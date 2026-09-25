extends Node2D

@onready var collectibles_folder = $Collectibles
@onready var level_exit = $LevelExit

func check_remaining_items():
	await get_tree().process_frame
	
	if collectibles_folder and level_exit:
		var items_left = collectibles_folder.get_child_count()
		print("Pearls remaining on seabed: ", items_left)
		
		if items_left == 0:
			level_exit.unlock_exit()
