/**
Visitor Pattern : A kind of Behavioral Pattern

行為型模式(Behavioral Pattern): 對不同對象之間劃分職責和算法的抽象化

可以在不修改類的source code和不創建新的子類別的情況下擴展

和策略模式不同的是，Visitor Pattern 的適用對象是[各類對象的集合]

*/


/// 原方法
class WoodComputerShop {
	let revenue: Float

	init(revenue: Float) {
		self.revenue = revenue
	}

}


class WoodBicycleShop {
	let revenue: Float

	init(revenue: Float) {
		self.revenue = revenue
	}
}

class WoodFuritureShop {
	let revenue: Float

	init(revenue: Float) {
		self.revenue = revenue
	}
}

class WoodMall {
	let shops: [Any]
	init(Shops: Any) {
		self.shops = shops
	}

	func calculateRevenue() -> Float {
		return shops.reduce(0, {total, shop in 
			if let computerShop = shop as? WoodComputerShop {
				return total + computerShop.revenue * 0.05
				} else if let bicycleShop = shop as? WoodBicycleShop {
					return total + bicycleShop.revenue * 0.25
				} else {
					return total
				}

				})
	
	}

}




///Visitor Pattern
protocol StoneShop {
	func accept(visitor: Visitor)
}

protocol Visitor {
	func visit(shop: StoneComputerShop)
	func visit(shop: StoneBicycleShop)
	func visit(shop: StoneFurnitureShop)
}

class ShopVisitor: Visitor: Visitor {
	var totalRevenue: Float = 0
	func visit(shop: StoneComputerShop) {
		totalRevenue += shop.revenue * 0.05
	}
	func visit(shop: StoneBicycleShop) {
		totalRevenue += shop.revenue * 0.15
	}
	func visit(shop: StoneFurnitureShop) {
		totalRevenue += shop.revenue * 0.25
	}
}


class StoneComputerShop: StoneShop {
	let revenue: Float

	init(revenue: Float) {
		self.revenue = revenue
	}

	func accept(visitor: Visitor) {
		visitor.visit(shop: self)
	}
}


class StoneBicycleShop: StoneShop {
	let revenue: Float

	init(revenue: Float) {
		self.revenue = revenue
	}

	func accept(visitor: Visitor) {
		visitor.visit(shop: self) // self means StoneBicycleShop
	}
}

class StoneFuritureShop: StoneShop {
	let revenue: Float

	init(revenue: Float) {
		self.revenue = revenue
	}

	func accept(visitor: Visitor) {
		visitor.visit(shop: self)
	}
}

class StoneMall {
	let shops: [StoneShop]
	init(shops: StoneShop...) {
		self.shops = shops
	}
	// use "accept" method send visitor to targets
	func accept(visitor: Visitor) {
		for shop in shops {
			shop.accept(visitor: visitor)
		}
	}

}

let stoneComputerShop = StoneComputerShop(revenue: 8000)
let stoneBicycleShop = StoneBicycleShop(revenue: 7500)
let stoneFurnitureShop = StoneFuritureShop(revenue: 15000)

let stoneMall = StoneMall(shops: stoneComputerShop, stoneBicycleShop, stoneFuritureShop)
let shopVisitor = ShopVisitor()
stoneMall.accept(visitor: shopVisitor)
print("Stone Mall 一共盈利 \(shopVisitor.totalRevenue)")



















