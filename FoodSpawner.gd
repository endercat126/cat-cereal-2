extends Node2D

@export var food_types : Array[PackedScene]

@export var max_spawn_radius := 1200.0 # idk lol just a big number 
@export var min_spawn_radius := 300.0 # nope youll have to move for it lazy kitty :/

@export var max_respawn_time := 0.3 # quick
@export var min_respawn_time := 2.0 # slow as fuck

# hehe
func _process(delta: float) -> void:
	if $FoodTimer.is_stopped():
		var respawn_time := randf_range(min_respawn_time, max_respawn_time)
		$FoodTimer.wait_time = respawn_time
		
		$FoodTimer.start() # if its stopped, fucking restart it 
		spawn_food()

func spawn_food() -> void:
	
	var spawn_angle = randf_range(0.0, PI * 2.0) # circle or something idk 
	var spawn_distance = randf_range(min_spawn_radius, max_spawn_radius) # nope not that CLOSE
	
	# AAAAAAAA SCARY MATHS
	var spawn_position = get_node("../Player").position + Vector2(cos(spawn_angle), sin(spawn_angle)) * spawn_distance
	
	var chosen_food = randi_range(0, len(food_types) - 1)
	var food = food_types[chosen_food].instantiate()
	food.position = spawn_position
	add_child(food) # child is food
