class_name Task

enum Priorities {
	LOW = 0,
	NORMAL = 1,
	HIGH = 2,
	CRITICAL = 3
}

class TaskQueue:
	var queue: Dictionary
	var size: int = 0

	func _init():
		queue = {
			Priorities.CRITICAL: [],
			Priorities.HIGH: [],
			Priorities.NORMAL: [],
			Priorities.LOW: []
		}
		size = 0
	
	func add_task(task: Task, priority: int):
		queue[priority].append(task)
		size += 1
	
	func get_task():
		if size == 0:
			return null
		for priority in queue.keys():
			if queue[priority].size() > 0:
				size -= 1
				return queue[priority].pop_front()
		return null

static func create_queue():
	return TaskQueue.new()

var name: String
var callback: Callable
# var priority: int
	
func _init(_name: String, _callback: Callable): # , _priority: int
	self.name = _name
	self.callback = _callback
	# self.priority = _priority

func execute():
	callback.call()

# func _init(name: String, callback: Callable):
# 	self.name = name
# 	self.callback = callback
# 	self.priority = TaskPriorities.NORMAL
