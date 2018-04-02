//: Playground - noun: a place where people can play

import Foundation

/***** define Result *****/

enum Result<T> {
  case success(T)
  case failure(Error)
}

/***** main class/struct *****/


class UDNAPI {
  private static let defaultSession = URLSession.shared
  private static var dataTask: URLSessionDataTask?
}


/***** define Error *****/

// MARK: - Error
extension UDNAPI {
  enum Error: Swift.Error {
    case getURLFailed
    case requestFailed(reason: String)
    case noData
    case jsonSerializationFailed(reason: String)
  }
}

// MARK: - Error localization
extension UDNAPI.Error: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .getURLFailed: return "Can’t get valid URL"
    case .requestFailed(let reason): return reason
    case .noData: return "No data returned with response"
    case .jsonSerializationFailed(let reason): return reason
    }
  }
}


/***** how to use *****/

// MARK: - main method

extension UDNAPI {

  // get member
  static func getMember(_ memberId: String, completion: @escaping((Result<MemberInfo>) -> Void)) {

    do {
      let request = try getMemberInfoRequest(memberId: memberId)
      dataTask?.cancel()
      dataTask = defaultSession.dataTask(with: request) { data, response, error in
        defer { self.dataTask = nil }
        let result = processGetMemberRequest(data: data, error: error)
        OperationQueue.main.addOperation {
          completion(result)
        }
      }
      dataTask?.resume()

    } catch {
      completion(Result.failure(error))
    }
  }
}


// MARK: - generate request
extension UDNAPI {
  // generate UDN getMember URLRequest
  private static func getMemberInfoRequest(memberId: String) throws -> URLRequest {
    let urlString = "https://udn.api.com/memberId=\(memberId)"
    guard let url = URL(string: urlString) else {
      throw Error.getURLFailed
    }
    let request = URLRequest(url: url)
    // todo: post body...
    return request
  }
}


// MARK: - process request
extension UDNAPI {
  
  // handel request
  private static func processGetMemberRequest(data: Data?, error: Swift.Error?) -> Result<MemberInfo> {
    
    // error != nil
    if let error = error {
      return .failure(error)
    }
    
    // no data
    guard let data = data else {
      return .failure(Error.noData)
    }
    
    // can't convert to json
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []), let results = json as? [String: Any] else {
      return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
    }
    
    // parse results json
    return parseMemberInfo(data: results)
  }
}

// MARK: - parse data
extension UDNAPI {
  // parse member info
  private static func parseMemberInfo(data: [String: Any]) -> Result<MemberInfo> {
    // check response
    guard let response = data["reponse"] as? String else {
      return .failure(Error.requestFailed(reason: "No resposne info in JSON"))
    }
    switch response {
    case "ok": break
    case "fail": return .failure(Error.requestFailed(reason: "Request failed."))
    default: return .failure(Error.requestFailed(reason: "Unknown API response.\n" + response))
    }
    
    // parse data
    guard let member = data["member"], let memberData = jsonToString(member)?.data(using: .utf8) else {
      return .failure(Error.jsonSerializationFailed(reason: "Could not get Data from JSON payload."))
    }
    guard let memberInfo = try? JSONDecoder().decode(MemberInfo.self, from: memberData) else {
      return .failure(Error.jsonSerializationFailed(reason: "Could not decode json data to memberInfo type."))
    }
    
    return .success(memberInfo)
  }
  
  private static func jsonToString(_ json: Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
      let converted = String(data: data, encoding: .utf8) else {
        return nil
    }
    return converted
  }
}


/***** Model *****/

struct MemberInfo: Codable {
  let name: String
  let email: String
}
