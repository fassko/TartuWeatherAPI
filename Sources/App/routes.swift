import Vapor
import HTTP

struct Image: Content {
  var image: Data
}

public func routes(_ router: Router) throws {
  
  let weatherDataController = WeatherDataController()
  router.get("/", use: weatherDataController.live)
  
  let liveImageController = LiveImageController()
  router.get("/liveImage/large.jpg", use: liveImageController.large)
  router.get("/liveImage/small.jpg", use: liveImageController.small)
  
  let historyDataController = HistoryDataController()
  router.get("/history", use: historyDataController.history)
  
  router.get("/logo") { req in
    return try req.client().get("https://vapor.codes/dist/db46a05af3bd6f950e49338c33539f84.png")
  }
  
  
  router.get("/img") { req -> Future<HTTPStatus> in
    
    try req.client().get("http://meteo.physic.ut.ee/webcam/uus/pisike.jpg").flatMap({ response in
      
      
      
      try response.content.decode(Data.self)
    })
    
    return try req.sharedContainer.client().get("http://meteo.physic.ut.ee/webcam/uus/pisike.jpg").map({ response in
      
      let data = response.http.body.data
      
      
      
      let body = response.http.body.convertToHTTPBody()
      
      return HTTPStatus.ok
    })
    
    
  }
}
