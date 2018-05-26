//
//  WeatherDataController.swift
//  App
//
//  Created by Kristaps Grinbergs on 26/05/2018.
//

import Vapor
import SwiftSoup

final class WeatherDataController {
  
  struct LiveImageURLParameters: Decodable {
    var size: ImageSize
  }
  
  enum ImageSize: String, Decodable {
    case large
    case small
  }
  
  func live(_ req: Request) throws -> Future<WeatherData> {
    let client = try req.make(Client.self)
    return client.get("http://meteo.physic.ut.ee/en/freshwin.php").map({ response in
      
      var temperature = ""
      var humidity = ""
      var airPressure = ""
      var wind = ""
      var precipitation = ""
      var irradiationFlux = ""
      var measuredTime = ""
      
      do {
        let htmlString = String(data: response.http.body.data!, encoding: .utf8)
        let doc = try SwiftSoup.parse(htmlString!)
        
        temperature = try doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(1) > td:nth-child(2)").text()
        humidity = try doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(2) > td:nth-child(2)").text()
        airPressure = try doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(3) > td:nth-child(2)").text()
        wind = try doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(4) > td:nth-child(2)").text()
        precipitation = try doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(5) > td:nth-child(2)").text()
        irradiationFlux = try String(doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(6) > td:nth-child(2)").text().dropLast()) + "^2"
        measuredTime = try doc.select("body > table > tbody > tr > td > table > tbody > tr:nth-child(7) > td:nth-child(2) > small").text()
      } catch {
        print(error)
      }
      
      
      
      //        let smallImageURL = "http://meteo.physic.ut.ee/webcam/uus/pisike.jpg"
      //        let largeImageURL = "http://meteo.physic.ut.ee/webcam/uus/suur.jpg"
      
      return WeatherData(temperature: temperature,
                         humidity: humidity,
                         airPressure: airPressure,
                         wind: wind,
                         precipitation: precipitation,
                         irradiationFlux: irradiationFlux,
                         measuredTime: measuredTime)
    })
  }
  
  func liveImage(_ req: Request) throws -> Future<Response> {
    
    let parameters = try req.query.decode(LiveImageURLParameters.self)
    let client = try req.make(Client.self)
    
    let url = { () -> String in
      switch parameters.size {
      case .large:
        return "http://meteo.physic.ut.ee/webcam/uus/suur.jpg"
      case .small:
        return "http://meteo.physic.ut.ee/webcam/uus/pisike.jpg"
      }
    }()
    
    let response =  client.get(url)
    
    return response
  }
}
