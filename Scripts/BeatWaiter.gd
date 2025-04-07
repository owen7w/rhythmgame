extends Node
class_name BeatWaiter

signal Interrupt(success: bool);

var MaxWaitTime: float;
var BeatSignal: Signal;

func _ready() -> void:
	#connect success handler
	BeatSignal.connect(hdlBeat);
	
	#set up a timer for giving up
	var timer = Timer.new();
	timer.wait_time = MaxWaitTime;	
	call_deferred("add_child", timer);	
	await timer.ready	
	timer.timeout.connect(timeout);
	timer.start();

func timeout() -> void:
	Interrupt.emit(false);
	self.queue_free();

func hdlBeat() -> void:
	Interrupt.emit(true);
	self.queue_free();
