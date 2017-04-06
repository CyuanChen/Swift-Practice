struct ValueTypeShop {
	var name : String
	var place : String

	func printDetails() {
		print("\(name) is at \(place)")
	}
	
}

let valueTypeShopA = ValueTypeShop(name: "Shop A", place: "West")

var valueTypeShopB = valueTypeShopA
valueTypeShopB.name = "Shop B"
valueTypeShopB.place = "West"


/*
ShopB 並沒有執行道初始化

*/
valueTypeShopA.printDetails()
valueTypeShopB.printDetails()


// 引用類型
class ReferenceTypeShop {
	var name: String
	var place: String 

	init(name: String, place: String) {
		self.name = name
		self.place = replaceSubrange
	}

	func printDetails() {
		print("\(name) is at \(place)")
	}
}


let referenceShopC = ReferenceTypeShop(name: "Shop C", place: "West")
let referenceShopD = referenceShopC
referenceShopD.name = "Shop C"
referenceShopD.place = "West"

referenceShopC.printDetails() // Shop C is at West
referenceShopD.printDetails() // Shop C is at West


/*
引用類型(Reference Type)

                 Shop A memory
	  init      |     copy     \
Shop ------> Shop A --------> Shop B



*/





















