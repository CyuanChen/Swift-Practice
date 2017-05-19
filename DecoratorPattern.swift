


/// 裝飾者模式(Decorator Pattern)
/// 可以選擇性的修改對象的行為
///
///陷阱: 最容易碰到的就是直接使用Swift 的Extension來裝飾對象
/// Decorator "選擇性"應用到單個對象    Extension 修改所有某個類型的對象
import Foundation

class Purchase {
	private let product: String
	private let price: Float
	
	init(product: String, price: Float) {
		self.product = product
		self.price = price
	}
	
	var description: String {
		return product
	}
	
	var totalPrice: Float {
		return price
	}
	
}



class CustomerAccount {
	let name: String
	var purchases = [Purchase]()
	
	init(name: String) {
		self.name = name
		
	}
	
	func addPurchase(purchase: Purchase) {
		self.purchases.append(purchase)
	}
	
	func showAccount() {
		var total: Float = 0
		print("購物車包含: ")
		
		for item in purchases {
			total += item.totalPrice
			print("商品 \(item.description)  價格\(formatCurrencyString(number: item.totalPrice))")
		}
	}
	
	func formatCurrencyString(number: Float) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		return formatter.string(from: NSNumber(value: number))!
		
	}
	
}

class BasePurchaseDecorator: Purchase {
	private let wrappedPurchase: Purchase
	init(purchase: Purchase) {
		wrappedPurchase = purchase
		super.init(product: purchase.description, price: purchase.totalPrice)
	}
}
class PurchaseWithDelivery: BasePurchaseDecorator {
	override var description: String {
		return "\(super.description) + 運送"
	}
	
	override var totalPrice: Float {
		return super.totalPrice + 5
	}
}

class PurchaseWithGiftWrap: BasePurchaseDecorator {
	override var description: String {
		return "\(super.description) + 禮盒包裝"
	}
	
	override var totalPrice: Float {
		return super.totalPrice + 7.5
	}
	
	
}

class PurchaseWithCard: BasePurchaseDecorator {
	override var description: String {
		return "\(super.description) + 卡片"
	}

	override var totalPrice: Float {
		return super.totalPrice + 3.5
	}
}





let account  = CustomerAccount(name: "Don")
account.addPurchase(purchase: Purchase(product: "Sandwich", price: 10))
account.addPurchase(purchase: Purchase(product: "Coffee", price: 5))
account.addPurchase(purchase: Purchase(product: "Chocolate", price: 30))
account.addPurchase(purchase: PurchaseWithGiftWrap(purchase: PurchaseWithDelivery(purchase: Purchase(product: "Cookie", price: 15))))

account.showAccount()

































































