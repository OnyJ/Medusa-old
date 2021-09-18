extends KinematicBody

# var chasing = false

##########################
# move randomly (pathfinding?)
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
# (spawn randomly)
