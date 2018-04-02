
import Foundation

class SearchAPI {
  
  // load search data
  func loadSearchData(matching query: String) throws -> Data {
    
    let urlString = "https://my.api.com/search?q=\(query)"
    
    guard let url = URL(string: urlString) else {
      throw SearchError.invalidQuery(query)
    }
//    // 如果我們這樣做，就會變成可以 throw SearchError，也會 throw data error
//    return try Data(contentsOf: url)
    
//    // 使用 do catch try，可以把 Error 限縮在 SearchError type
//    do {
//      return try Data(contentsOf: url)
//    } catch {
//      throw SearchError.dataLoadingFailed(url)
//    }
    
    return try perform(Data(contentsOf: url), orThrow: SearchError.dataLoadingFailed(url))
  }
  
}

// MARK: - Search Error
extension SearchAPI {
  enum SearchError: Swift.Error {
    case invalidQuery(String)
    case dataLoadingFailed(URL)
  }
}

// MARK: - Search Error localized
extension SearchAPI.SearchError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidQuery(let query): return "Can't get data from " + query
    case .dataLoadingFailed(let url): return "Failed load data from" + url.absoluteString
    }
  }
}


// MARK: - Unified Error API
func perform<T>(_ expression: @autoclosure () throws -> T, orThrow error: Error) throws -> T {
  do {
    return try expression()
  } catch {
    throw error
  }
}
