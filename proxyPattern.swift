import Foundation



struct WoodSpecial {
	var name: String
	var price: Float
	var amount: Int
}

class WoodBakery {
	var name: String
	init(name: String) {
		self.name = name
	}
	
	func showTodaySpecial() {
		print("\(name) Today Special: ")
		let items = getTodaySpecial()
		for item in items {
			print("\(item.name), price: \(item.price), amount \(item.amount)")
		}
	}

	func orderItem(name: String, amount: Int) {
		print("Customers order: \(amount)份 \(name)")
	}	
	
	private func getTodaySpecial() -> [WoodSpecial] {
		var items = [WoodSpecial]()
		items.append(WoodSpecial(name: "法國麵包", price: 180, amount:20))
		items.append(WoodSpecial(name: "太陽餅", price: 70, amount: 10))
		items.append(WoodSpecial(name: "草莓大福", price: 400, amount: 5))
		return items
	}
}
	
let woodBakery = WoodBakery(name: "Wood no.1")
woodBakery.orderItem(name: "法國麵包", amount: 5)	

struct StoneSpecial {
	var name: String
	var price: Float
	var amount: Int
}
protocol StoneBakeryDataSource {
	func todaySpecial() -> [StoneSpecial]
}
protocol StoneBakeryDelegate {
	func didOrderItem(name: String, amount: Int)
}



class StoneChef: StoneBakeryDataSource {
	func todaySpecial() -> [StoneSpecial] {
		var items = [StoneSpecial]()
		items.append(StoneSpecial(name: "法國麵包", price: 180, amount:20))
		items.append(StoneSpecial(name: "太陽餅", price: 70, amount: 10))
		items.append(StoneSpecial(name: "草莓大福", price: 400, amount: 5))
		return items
	}
}


class StoneWaiter: StoneBakeryDelegate {
	func didOrderItem(name: String, amount: Int) {
		print("客人下單: \(amount) 份 \(name)")
	}
}

class StoneBakery {
	var name: String
	var dataSource: StoneBakeryDataSource?
	var delegate: StoneBakeryDelegate?
	
	init(name: String) {
		self.name = name
		let chef = StoneChef()
		dataSource = chef
		let waiter = StoneWaiter()
		delegate = waiter
	}
	
	func showTodaySpecial() {
		print("\(name) 今日特色")
		
		let items = dataSource?.todaySpecial()
		if items == nil {
			print("廚師不在")
			return
		}
		for item in items! {
			print("\(item.name), 價格\(item.price), 數量\(item.amount)")
		}
		
		
	}
	func orderItem(name: String, amount: Int) {
		delegate?.didOrderItem(name: name, amount: amount)
	}

}


let stoneBakery = StoneBakery(name: "Stone no.1")
stoneBakery.showTodaySpecial()
print("--------------------")
stoneBakery.orderItem(name:"法國麵包", amount: 10)
stoneBakery.orderItem(name:"太陽餅", amount: 120)
stoneBakery.orderItem(name:"草莓大福", amount: 5)