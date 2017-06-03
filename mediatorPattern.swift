import Foundation
struct TestPosition {
	var x: Int
}

class TestCar {
	var carName: String
	var currentPosition: TestPosition
	private var otherCars:[TestCar]
	
	init(carName: String, position: TestPosition) {
		self.carName = carName
		self.currentPosition = position
		self.otherCars = [TestCar]()
	}
	
	
	func addCarsInArea(cars: TestCar...) {
		for car in cars {
			otherCars.append(car)
		}
	}
	
	func checkIsOtherCarsTooClose(car: TestCar) -> Bool {
		return currentPosition.x - car.currentPosition.x < 5
	}
	
	func changePosition(newPosition: TestPosition) {
		self.currentPosition = newPosition
		for car in otherCars {
			if car.checkIsOtherCarsTooClose(car: self) {
				print("\(carName), 慢一點，太靠近\(car.carName)了拉")
			}
		}
		
		print("\(carName) 移動到了位置\(currentPosition.x)")
	}	
}

let stoneTestCar = TestCar(carName: "Stone Car", position: TestPosition(x: 0))
let woodTestCar = TestCar(carName: "Wood Car", position: TestPosition(x: 10))
let ironTestCar = TestCar(carName: "Iron Car", position: TestPosition(x: 20))
let waterTestCar = TestCar(carName: "Water Car", position: TestPosition(x: 30))

stoneTestCar.addCarsInArea(cars: woodTestCar, ironTestCar, waterTestCar)
woodTestCar.addCarsInArea(cars: stoneTestCar, ironTestCar, waterTestCar)
ironTestCar.addCarsInArea(cars: stoneTestCar, woodTestCar, waterTestCar)
waterTestCar.addCarsInArea(cars: stoneTestCar, woodTestCar, ironTestCar)

woodTestCar.changePosition(newPosition: TestPosition(x: 17))


// 正確的防撞系統:
//透過中介者來溝通，各個對象不需要保持聯繫
//如果要讓對象給不相關的對象發送通知，使用觀察者模式

struct Position {
	var x: Int
}


//窺視
protocol Peer {
	var name: String {get}
	func checkIsOtherCarsTooClose(position: Position) -> Bool
}
//中間人
protocol Mediator {
	func registerPeer(peer: Peer)
	func unregisterPeer(peer: Peer)
	func changePosition(peer: Peer, pos: Position) -> Bool
}

class CarMediator: Mediator {
	private var peers:[String:Peer]
	init() {
		peers = [String: Peer]()
	}
	
	func registerPeer(peer: Peer) {
		self.peers[peer.name] = peer
	}
	func unregisterPeer(peer: Peer) {
		self.peers.removeValue(forKey: peer.name)
	}
	
	func changePosition(peer: Peer, pos: Position) -> Bool {
		for storedPeer in peers.values {
			if peer.name != storedPeer.name && storedPeer.checkIsOtherCarsTooClose(position: pos) {
				return true
			}
		}
		return false
	}	
}

class Car: Peer {
	var name: String
	var currentPosition: Position
	var mediator: Mediator
	
	init(name: String, pos: Position, mediator: Mediator) {
		self.name = name
		self.currentPosition = pos
		self.mediator = mediator
		
		mediator.registerPeer(peer: self)
	}
	
	func checkIsOtherCarsTooClose(position: Position) -> Bool {
		return abs(position.x - self.currentPosition.x) < 5
	}
	
	func changePosition(newPosition: Position) {
		self.currentPosition = newPosition 
		print("\(name) 移動到了 \(self.currentPosition.x)")
		
		if mediator.changePosition(peer: self, pos: self.currentPosition) {
			print("\(name) 太靠近其他車了拉，開慢一點")
		}
	}
}

let mediator: Mediator = CarMediator()
let carA = Car(name: "Car A", pos: Position(x:0), mediator: mediator)
let carB = Car(name: "Car B", pos: Position(x:10), mediator: mediator)
let carC = Car(name: "Car C", pos: Position(x: 20), mediator: mediator)
let carD = Car(name: "Car D", pos: Position(x: 30), mediator: mediator)

carB.changePosition(newPosition: Position(x: 17))
