extends Node2D


var npcScene : PackedScene = preload("res://scene/Characters/npc.tscn")
@onready var spawn_marker = $StartPosition
@onready var target_marker = $TargetPosition
signal reached_target
var line: SinglyLinkedList = SinglyLinkedList.new()



var npc_stat: Array[NPCstat] = [
	preload("res://scene/Characters/NPC1.tres")
]

func _ready() -> void:
	#for i in range(5):
		#add_npc()
	pass

func add_npc():
	var new_npc = npcScene.instantiate()
	new_npc.stats = npc_stat[0]
	add_child(new_npc)
	var target_position = line.tail.position
	var node = line.add(new_npc)
	node.target_position = target_position
	
	
func remove_first():
	var npc = line.remove_head()
	
	if npc:
		npc.queue_free()
	line.head.target_position = target_marker

func remove_npc(node: ListNode):
	var npc = line.remove_node(node)
	if npc:
		npc.queue_free()


	
