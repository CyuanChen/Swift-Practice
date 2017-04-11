/// Facade Pattern 外觀模式
/// 用來簡化一個或者多個類提供的API，讓任務更簡便的執行




// Origin code

class TreasureMap {
	enum Tresures {
		case gold
		case silver
		case bronze
	}


	struct MapLocation {
		let gridLetter: Character
		let gridNumber: Int
	}

	func findTresure(type: Tresures) -> MapLocation {
		switch type {
		case .gold:
			return MapLocation(gridLetter: "A", gridNumber: 0)
		case .silver:
			return MapLocation(gridLetter: "F", gridNumber: 17)
		case .bronze:
			return MapLocation(gridLetter: "O", gridNumber: 40)

		}
	}
}

class Ship {
	struct ShipLocation {
		let NorthSouth: Int
		let EastWest: Int
	}

	var currentPosition: ShipLocation

	init() {
		currentPosition = ShipLocation(NorthSouth: 20, EastWest: 20)
	}
	// use callback to send location to User
	func moveToLocation(location: ShipLocation, callback:(ShipLocation) -> Void) {
		currentPosition = location
		callback(currentPosition)
		
	}
}

class Member {
	enum Actions {
		case digForGold
		case digForSilver
		case digForBronze
	}

	func performAction(action: Actions, callback:(Int)-> Void) {
		var prizeValue = 0
		switch action {
		case .digForGold:
			prizeValue = 5000

		case .digForSilver:
			prizeValue = 2000

		case .digForBronze:
			prizeValue = 1000

		}

		callback(prizeValue)
	}
}

let map = TreasureMap()
let ship = Ship()
let member = Member()

let treasureLocation = map.findTreasure(type: TreasureMap.treasures.gold)


// convert from map to ship coordinates
let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
let eastWestPos = sequence.index(of: treasureLocation.gridletter)
let shipTarget = Ship.ShipLocation(NorthSouth: Int(treasureLocation.gridNumber), EastWest: eastWestPos!)


// relocate ship

ship.moveToLocation(location: shipTarget, callback: { location in member.performAction(action: .digForGold, callback: { prize in print("挖到了Gold 價值\(prize)")
	})
})



enum TresuresTypes {
		case gold
		case silver
		case bronze
	}

class StoneFacade {
	private let map = TreasureMap()
	private let ship = Ship()
	private let member = Member()
	func getTreasure(type: TreasureTypes) -> Int {
		var prizeAmount = 0

		var treasureMapType: TreasureMap.Treasures
		var memberActionType: Member.Actions

		switch type {
		case .Gold:
			treasureMapType = .gold
			memberActionType = .digForGold

		case .silver:
			treasureMapType = .silver
			memberActionType = .digForSilver

		case .bronze:
			treasureMapType = .bronze
			memberActionType = .digForBronze
		}

		let treasureLocation = map.findTreasure(type: treasureMapType)

		// convert from map to ship coordinates		
		let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
		let eastWestPos = sequence.index(of: treasureLocation.gridletter)
		let shipTarget = Ship.ShipLocation(NorthSouth: Int(treasureLocation.gridNumber), EastWest: eastWestPos!)


		// relocate ship

		ship.moveToLocation(location: shipTarget, callback: { location in member.performAction(action: .memberActionType, callback: { prize in prizeAmount = prize)
			})
		})

		return prizeAmount
	}
}	


// Easy to use

let facade = StoneFacade()
let prize = facade.getTreasure(type: .gold)
print("挖到了 Gold 價值\(prize)")

























































