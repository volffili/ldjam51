extends GPUParticles2D


func _ready():
	emitting = true
	$AnimationPlayer.play("die")

