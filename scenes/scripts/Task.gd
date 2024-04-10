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
	
	func clear():
		self._init()

static func create_queue():
	return TaskQueue.new()

var callback: Callable
# var priority: int

func _init(_callback: Callable): # _name: String, , _priority: int
	# self.name = _name
	self.callback = _callback
	# self.priority = _priority

func execute():
	return callback.call()

# func _init(name: String, callback: Callable):
# 	self.name = name
# 	self.callback = callback
# 	self.priority = TaskPriorities.NORMAL
