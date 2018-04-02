//: Playground - noun: a place where people can play

import UIKit
import Foundation
public enum ContentKind: Codable {
    case app(String)
    case movie(Int)
}
extension ContentKind {
    // decode 錯誤拿來丟的錯誤
    enum CodingError: Error { case decoding(String)}
    // 拿來解析的Keys
    enum CodableKeys: String, CodingKey { case app, movie }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)
        // 有app這個Key則把他的value轉成String 存到 bundleID
        // initial this
        if let bundleID = try? values.decode(String.self, forKey: .app) {
            self = .app(bundleID)
            return
        }
        if let storeID = try? values.decode(Int.self, forKey: .movie) {
            self = .movie(storeID)
            return
        }
        throw CodingError.decoding("Decoding Failed. \(dump(values))")
        
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        
        switch self {
        case let .app(bundleID):
            try container.encode(bundleID, forKey: .app)
        case let .movie(storeID):
            try container.encode(storeID, forKey: .movie)
        }
        
        
    }
}

let moveJSON =
"""
{"movie":9487}
"""

if let data = moveJSON.data(using: .utf8) {
    let decoder = JSONDecoder()
    do {
        let c = try decoder.decode(ContentKind.self, from: data)
        print(c)
    } catch let e {
        print(e)
    }
}




enum SpaceshipKind : String, Codable {
    case transport
    case freighter
    case fighter

    enum CodableKeys: String, CodingKey {
        case spaceship = "grand_spaceship"
    }

    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let spaceshipString = try? values.decode(String.self, forKey: .spaceship) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let spaceship = SpaceshipKind.init(rawValue: spaceshipString) {
            self = spaceship
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .spaceship)
    }
}

let st = """
{"grand_spaceship":"freighter"}
"""

if let d = st.data(using: .utf8) {
    let dc = JSONDecoder()
    do {
        let sp = try dc.decode(SpaceshipKind.self, from: d)
        print(sp) // freighter
    } catch let e {
        print(e)
    }
}

// Access Control: private(set) var used to define getter and setter
struct TrackedString {
    public private(set) var numberOfEdit = 0
    public var value: String = "" {
        didSet {
            numberOfEdit += 1
        }
    }
    public init() {}
}
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked"
stringToEdit.value += " This edit will increment numberOfEdit"
stringToEdit.value += " So will this one"

print("The number of edit is \(stringToEdit.numberOfEdit)")

//Private Members in Extension
protocol SomeProtocol {
    func doSomething()
}
struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

// enum
struct CardItem {
    var title: String
    var cardID: String
    var liked: Bool
    var likeCount: Bool
}

enum UIState {
    case initial
    case initialLoading
    case partialLoaded([CardItem], String)
    case partialLoadedAndLoading([CardItem], String)
    case fullyLoadedButNoData
    case fullyLoaded([CardItem])
    case error
}
class testViewController: UIViewController {
    var state: UIState = .initial {
        didSet {
            if self.isViewLoaded { self.layoutViews()}
        }
    }
    func layoutViews() {
        switch self.state {
        case .initial:
            break
        case .initialLoading:
            break
        case .partialLoaded(let items, let offset):
            break
        default:
            break
        }
    }
}
struct KKBOXSong {
    var songName: String
    var artisName: String
}
enum AudioRecognitionUIState {
    case welcome
    case recording
    case uploading
    case result([KKBOXSong])
    case error
}
func fizzbuzz(_ x: Int) -> String {
    switch x {
    case x where x % 3 == 0 && x % 5 == 0:
        return "FizzBuzz"
    case x where x % 3 == 0:
        return "Fizz"
    case x where x % 5 == 0:
        return "Buzz"
    default:
        return "\(x)"
    }
}
//
//(1...20).map(fizzbuzz).forEach {print($0)}

struct JSONData: Codable {
    var reuslt: Meteorological
    struct Meteorological: Codable {
        var count: Double
        var limit: Double
        var offset: Double
        var results: [Result]
        var sort: String
    }
    struct Result: Codable {
        var _id: String
        var endTime: String
        var locationName: String
        var parameterName1: String
        var parameterName2: String
        var parameterName3: String
        var parameterUnit2: String
        var parameterUnit3: String
        var parameterValue1: String
        var startTime: String
    }
}

struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case addtionalInfo
    }
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}
extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .addtionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
}




struct Person {
    let name: String
    let age: Int?
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case extraInfo = "extra_info"
    }
    enum ExtraInfoKeys: String, CodingKey {
        case age
    }
}
extension Person: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let extraInfo = try values.nestedContainer(keyedBy: ExtraInfoKeys.self, forKey: .extraInfo)
        age = try? extraInfo.decode(Int.self, forKey: .age)
    }
}
let dic = ["title": "lijum", "extra_info": ["age": 30]] as [String: Any]
let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
let person = try? JSONDecoder().decode(Person.self, from: data)



enum BeerStyle: String, Codable {
    case ipa
    case stout
    case kolsch
}

struct Beer: Codable {
    enum CodingKeys: String, CodingKey {
        case name, brewery, comments, info
        case createdAt = "created_at"
        case bottleSizes = "bottle_sizes"
    }
    enum InfoCodingKeys: String, CodingKey {
        case abv
        case style
    }
    let abv: Float
    let style: BeerStyle
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var info = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        try info.encode(abv, forKey: .abv)
        try info.encode(style, forKey: .style)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let info = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        self.abv = try info.decode(Float.self, forKey: .abv)
        self.style = try info.decode(BeerStyle.self, forKey: .style)
    }
}








































