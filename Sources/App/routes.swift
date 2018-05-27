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
  
  
  router.get("/img") { req in
    return try req.sharedContainer.client().get("http://meteo.physic.ut.ee/webcam/uus/pisike.jpg")
  }
}
