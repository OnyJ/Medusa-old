extends KinematicBody

# TODO
# required :
# x follow player
# x detect player (far/near)
# x follow when detected for x sec
# - kill when eyes meet
# later :
# - move randomly / stroll
# - spawn randomly

signal petrify

enum {
	CHILL
	CHASE
}
var speed = 12
var state = CHILL
var looking_at_player = false
var chase_time = 4
# Godot uses multiple points (nodes) for a path.
var path = [] # to store nodes
var path_node = 0 # keep path on which node we're currently on
onready var nav = get_parent() # nav mesh that contains the whole world geometry
onready var player = $"../../../Player"
onready var main = $"../../../../../Main"


func _physics_process(delta):
	if main.game_is_started:	
		match state:
			CHILL:
				rotate_y(-0.05)
			CHASE:
				look_at_player()
				follow_player(delta)
				yield(get_tree().create_timer(chase_time), "timeout")
				state = CHILL
				chase_time = 0
				add_chase_time()


func look_at_player():
	if !looking_at_player:
		rotate_y(0.05)
	elif state == CHASE and looking_at_player:
		add_chase_time()

func follow_player(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func add_chase_time():
	chase_time += 1 + randi() % 5


func _on_Timer_timeout():
	move_to(player.global_transform.origin)

func _on_ShortEyeDetector_body_entered(body):
	print("petrify")
	emit_signal("petrify")

func _on_WideEyeDetector_body_entered(body):
	looking_at_player = true
	state = CHASE

func _on_WideEyeDetector_body_exited(body):
	looking_at_player = false


##########################
# detect player
# -> large_eye_detector
# _on_LargeEyeDetector_??_entered (= medusa sees player):
# 	func follow_player_during(sec)
# _on_SmallEyeDetector_??_entered_with_PlayerEyes (= eyes meet):
# 	func player_turns_into_statue()
#		animation() > die() + queue free > gameover > menu
# _on_NearDetection_??_entered (player at <= 1m from medusa):
# 

##########################
# follow during timeQty (which is random)
# -> need tutorial


##########################
# kill when eyes meet
# -> small_eye_detector meets player's small_eye_detector


##########################
# func move_randomly
# (whithout falling)

# _physics_process(delta): -> if chasing == false:
# func chose_a_direction()
#	avoid obstacles and void
#	
# 	func walk_for(rand_sec)
# 		func dodge_obstacles_and_void
# 		func turn_if_obstacles
# 	func wait(rand_sec)

##########################
# (spawn randomly)







