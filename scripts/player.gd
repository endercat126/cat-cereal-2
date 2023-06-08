extends CharacterBody2D

#  ,-.       _,---._ __  / \
# /  )    .-'       `./ /   \
#(  (   ,'            `/    /|
# \  `-"             \'\   / |
#  `.              ,  \ \ /  |
#   /`.          ,'-`----Y   |
#  (            ;        |   '
#  |  ,-.    ,-'         |  /
#  |  | (   |        hjw | /
#  )  |  \  `.___________|/
#  `--'   `--'


@export var speed := 400.0

#probably not accurate idk im not physics
@export var acceleration := 0.03

@export var magnetism := 0.05 # how powerfully the magnetic cat yoinks its meal

var foods = []


func _physics_process(delta) -> void:
	#this does something
	var direction := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	#is smooth
	velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	
	if direction:
		look_at(position + velocity.rotated(deg_to_rad(90)))
	
	if len(foods) > 0:
		for food in foods:
			food.position = lerp(food.position, position, magnetism)
			
			if self in food.get_overlapping_bodies():
				print("Ate")
				
				Global.food_eaten += 2 # ILL REPLACE THIS MAGIC NUMBER LATER OKAYYYYYY
				
				foods.erase(food)
				
				food.queue_free()

	# MOVE
	move_and_slide()


func _on_food_nearby(area):
	if area.is_in_group("Food"):
		foods.append(area)
		print("Food Nearby")
