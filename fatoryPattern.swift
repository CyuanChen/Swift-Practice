enum BoxType {
	case smallBox
	case bigBox
	case largeBox
}


class ProductFactory {
	static let shared = ProductFatory()
	private init() {}

	func createProduct(biscuitCount : Int) -> Product {
		switch biscuitCount {
			case 0...4 :
				return SmallProduct(biscuitCount: biscuitCount)
			case 6...10 :
				return BigProduct(biscuitCount: biscuitCOunt)
			default:
				return LargeProduct(biscuitCount: biscuitCount)


		}
	}


}

class Product {
	var name: String
	var box: BoxType
	var price: Float

	init(name: String, box: BoxType, biscuitCount: Int) {
		let price = Float(biscuitCount) * 5.0

		self.name = name
		self.box = box
		self.price = price

	}
}

class SmallProduct: Product {
	init(biscuitCount: Int) {
		super.init(name: "Small Product". box: .smallBox, biscuitCount: biscuitCount)
	}
	
}




























