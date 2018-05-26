//
//  HistoryDataController.swift
//  App
//
//  Created by Kristaps Grinbergs on 26/05/2018.
//

import Vapor

final class HistoryDataController {
  struct HistoryURLParameters: Decodable {
    var type: QueryDataType
  }
  
  enum QueryDataType: String, Decodable {
    
    /// Today
    case today
    
    /// Yesterday
    case yesterday
  }
  
  func history(_ req: Request) throws -> Future<[QueryData]> {
    
    let parameters = try req.query.decode(HistoryURLParameters.self)
    let client = try req.make(Client.self)
    
    let urlComponents = generateURLComponents(dataType: parameters.type)
    
    return client.get((urlComponents.url?.absoluteString)!).map { response in
      let csvString = String(data: response.http.body.data!, encoding: .utf8)!
      
      let lines = csvString.components(separatedBy: .newlines)
      let rawData = Array(lines.map({
        $0.components(separatedBy: ", ")
      }).dropFirst().dropLast())
      
      let queryData = rawData.map({ dataItem -> QueryData in
        QueryData(measuredTime: dataItem[0],
                  temperature: dataItem[1],
                  humidity: dataItem[2],
                  airPressure: dataItem[3],
                  wind: dataItem[4],
                  windDirection: dataItem[5],
                  precipitation: dataItem[6],
                  uvIndex: dataItem[7],
                  light: dataItem[8],
                  irradiationFlux: dataItem[9],
                  gammaRadiation: dataItem[10])
      })
      
      return queryData
    }
  }
  
  /**
   Generate URL components from data type
   
   - Parameters:
   - dataType: Query data type
   
   - Returns: Generated URL components
   */
  private func generateURLComponents(dataType: QueryDataType) -> URLComponents {
    var urlComponents = URLComponents(string: "http://meteo.physic.ut.ee/en/archive.php")
    
    var end: Date
    var start: Date
    let calendar = Calendar.current
    
    switch dataType {
    case .today:
      start = Date()
      end = calendar.date(byAdding: .day, value: +1, to: start)!
    case .yesterday:
      end = Date()
      start = calendar.date(byAdding: .day, value: -1, to: end)!
    }
    
    urlComponents?.queryItems = [
      URLQueryItem(name: "do", value: "data"),
      URLQueryItem(name: "begin[year]", value: String( calendar.component(.year, from: start))),
      URLQueryItem(name: "begin[mon]", value: String(calendar.component(.month, from: start))),
      URLQueryItem(name: "begin[mday]", value: String(calendar.component(.day, from: start))),
      URLQueryItem(name: "end[year]", value: String( calendar.component(.year, from: end))),
      URLQueryItem(name: "end[mon]", value: String(calendar.component(.month, from: end))),
      URLQueryItem(name: "end[mday]", value: String(calendar.component(.day, from: end))),
      URLQueryItem(name: "ok", value: "+Query+"),
      URLQueryItem(name: "9", value: "1"),
      URLQueryItem(name: "10", value: "1"),
      URLQueryItem(name: "11", value: "1"),
      URLQueryItem(name: "12", value: "1"),
      URLQueryItem(name: "13", value: "1"),
      URLQueryItem(name: "14", value: "1"),
      URLQueryItem(name: "15", value: "1"),
      URLQueryItem(name: "16", value: "1"),
      URLQueryItem(name: "17", value: "1")
    ]
    
    return urlComponents!
  }
}
