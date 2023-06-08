extends Node2D

@export var food_types : Array[PackedScene]

@export var max_spawn_radius := 1000.0 # idk lol just a big number 
@export var min_spawn_radius := 300.0 # nope youll have to move for it lazy kitty :/

@export var max_respawn_time := 0.8 # slow as fuck
@export var min_respawn_time := 0.3 # quick

@export var max_food_on_screen := 25 # dont sit there
@export var food_despawn_dist := 1000.0 # it'll go bad if you run away from it!

@export var initial_foods := 10

@onready var player: CharacterBody2D = get_node("../Player") # found you 🔪


func _ready() -> void:
	for i in range(initial_foods):
		spawn_food()

# hehe
func _process(delta: float) -> void:
	if $FoodTimer.is_stopped():
		var respawn_time := randf_range(min_respawn_time, max_respawn_time)
		$FoodTimer.wait_time = respawn_time
		
		$FoodTimer.start() # if its stopped, fucking restart it 
		
		if get_child_count() < (max_food_on_screen + 1):
			spawn_food()
		else:
			print("Too many food...")
			
	for child in get_children():
		if child.is_in_group("Food"):
			var food_dist = child.position.distance_to(player.position)
			if food_dist > food_despawn_dist:
				print("Food too far away (" + str(food_dist) + "), Despawning...")
				child.queue_free()

func spawn_food() -> void:
	
	var spawn_angle = randf_range(0.0, PI * 2.0) # circle or something idk 
	var spawn_distance = randf_range(min_spawn_radius, max_spawn_radius) # nope not that CLOSE
	
	# AAAAAAAA SCARY MATHS
	var spawn_position = player.position + Vector2(cos(spawn_angle), sin(spawn_angle)) * spawn_distance
	
	var chosen_food = randi_range(0, len(food_types) - 1)
	var food = food_types[chosen_food].instantiate()
	food.position = spawn_position
	add_child(food) # child is food
