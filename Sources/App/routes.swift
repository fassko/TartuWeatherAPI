import Vapor
import HTTP

public func routes(_ router: Router) throws {
  
  let weatherDataController = WeatherDataController()
  router.get("/", use: weatherDataController.live)
  
  let liveImageController = LiveImageController()
  router.get("/liveImage/large.jpg", use: liveImageController.large)
  router.get("/liveImage/small.jpg", use: liveImageController.small)
  
  let historyDataController = HistoryDataController()
  router.get("/history", use: historyDataController.history)
}
