extends CharacterBody2D

var dead = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player
var chase = false
var SPEED = 50

func _ready():
	get_node("AnimatedSprite2D").play("idle")
	player = get_node("../Player/Player")
func _physics_process(delta) :
	velocity.y += gravity * delta 
	if chase == true:
		
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("jump")
		
		var direction = (player.position - self.position).normalized()
		if direction.x >= 0:
					get_node("AnimatedSprite2D").flip_h = true
		else:
					get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("idle")
			
		velocity.x =0
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		
		
		#player.global_position


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "Player":
		chase = false
		player.velocity.y = player.JUMP_VELOCITY
		Game.Gold += 5
		Utils.saveGame()
		player.anim.play("Jump")
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()


func _on_player_death_body_exited(body):
	pass # Replace with function body.


func _on_player_collision_body_entered(body):
	
	if body.name == "Player" and dead==false :
		
		#player.velocity.y = -100
		
		Game.PlayerHP -=3
		death()
		
func death():
		dead=true
		chase = false
		Game.Gold += 5
		Utils.saveGame()
		#velocity.y = JUMP_VELOCITY
		#anim.play("Jump")
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()

func _on_player_collision_body_exited(body):
	pass # Replace with function body.