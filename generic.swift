struct Stack<Element> {
	var items = [Element]()
	mutating func push(_ item: Element) {
		items.append(item)
	}
	mutating func pop() {
		items.removeList()
	}	

}


//instance
//Element 用String 代替
var stackOfString = Stack<String>()

extension Stack {
	var topItem : Element? {
		return items.imEmpty ? nil : items[items.count - 1] 
	}
}


// Type Constraint
// type 遵從Equatable protocol 才能進行比較 ==


func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
	// enumerated : show array detail
	/*
	for (index, value) in array.enumerated() {
		print("\(index + 1) \(value)")
	}
	*/
	for (index, value) in array.enumerated() {
		if value == valueToFind{
			return index
		}
	}
	// because already return index, therefore
	//in here, return nil
	return nil
}

// Associated關聯 Type
protocol Container {
	// 此ItemType可以轉換為任何型別
	associatedtype ItemType
	mutating func append(_ item : ItemType)
	var count: Int{get}
	subscript(i: Int) -> ItemType{get} {
	}

	struct IntStack: Container {
		var items = [Int]()
		mutating func push(_ item: Int) {
			items.append(item)
		}
	}

	mutating func pop() {
		items.removeLast()
	}
	// 這行可以不打，swift也會自動判斷型別
	typealias ItemType = Int 

	mutating func append(_ item: Int) {
		self.push(item)
	}

	var count: Int {
		return items.count
	}

	subscript(i: Int) -> Int {
		return items[i]
	}

}

extension Stack: Container {
	mutating func append(_ item: Element) {
		self.push(item)
	}
	var count: Int {
		return items.count
	}
	subscript(i: Int) -> Element {
		return items[i]
	}
}


//Generic Where Clause
//用於對Associated Types 做限制
// where C1.ItemType == C2.ItemType, C1.ItemType: Equatable

func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
	if someContainer.count != anotherContainer.count{return false}
	for i in 0..< someContainer.count {
		if someContianer[i] != anotherContainer[i]{return false}
	}

	return true
}








