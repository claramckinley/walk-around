extends Node2D

enum Level {
	ONE,
	TWO,
	THREE
}

signal drain_water(pipes)

func _ready():
	$Camera2D.make_current()

export var num_total = 15
var level = Level.ONE

func check_answer():
	var count = 0
	match(level):
		Level.ONE:
			for pipe in $level_one.get_children():
				if pipe.is_correct == true:
					count += 1
		Level.TWO:
			for pipe in $level_two.get_children():
				if pipe.is_correct == true:
					count += 1
		Level.THREE:
			for pipe in $level_three.get_children():
				if pipe.is_correct == true:
					count += 1
	if count == num_total:
		print("you win level " + str(level))
#		if level != Level.THREE:
#			$Camera2D.position.x = $Camera2D.position.x + 1050
#			level = level + 1
		if level == Level.ONE:
			emit_signal("drain_water", self)
