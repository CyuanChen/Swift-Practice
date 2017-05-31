//  Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"

import Foundation

class AdventureA {
	private let name: String
	
	init(adventureName: String) {
		name = adventureName
	}
	
	func attack() {
		print("冒險者\(name) 進行了 普通攻擊")
	}
	
	func rockAttack() {
		print("冒險者\(name) 進行了 石頭拋射攻擊")
	}
	
	func waterAttack() {
		print("冒險者\(name) 進行了 噴水攻擊")
	}
	
	func rushAttack() {
		print("冒險者\(name) 進行了 噴水攻擊")
	}	
}

/// Strategy Pattern
/// 根據環境或條件的不同選擇不同的策略來完成任務


/// 包裝成protocol
protocol Strategy {
	func attack() -> String
}
class RushStrategy: Strategy {
	func attack() -> String {
		return "衝撞"
	}
}
class RockStrategy: Strategy {
	func attack() -> String {
		return "石頭拋射"
	}
}
class WaterStrategy: Strategy {
	func attack() -> String {
		return "噴水"
	}
}
class AdventureB {
	private let name: String
	init(name: String) {
		self.name = name
	}
	
	func attackWith(strategy: Strategy?) {
		if strategy != nil {
			let way = strategy!.attack()
			print("冒險者\(name) 進行了 \(way)攻擊")
		} else {
			print("冒險者\(name) 進行了  普通攻擊")
		}
	}
}

let adventureB = AdventureB(name: "Peter")

//不是用策略
adventureB.attackWith(strategy: nil)
let rockStrategy = RockStrategy()
//使用rock strategy
adventureB.attackWith(strategy: rockStrategy)



