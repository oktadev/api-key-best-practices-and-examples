import Foundation

class Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String

    init() {
        id = 0
        main = ""
        description = "none"
        icon = "01d"
    }

    func set(weather: Weather) {
        id = weather.id
        main = weather.main
        description = weather.description
        icon = weather.icon
    }
}

class WeatherData: Decodable {
    var name: String
    var visibility: Int
    var weather: [Weather]
}

class WeatherModel : ObservableObject {
    private let apiKey: String
    private let apiUri: String
    @Published var weatherData: WeatherData
    
    init(location: String) {
        apiKey = "a1b2c33d4e5f6g7h8i9jakblc"
        apiUri = "http://api.openweathermap.org/data/2.5/weather?q=" + location + "&appid=" + apiKey
        updateWeather()
    }
    
    func updateWeather() {
        let uri = URL(string: apiUri)!
        let task = URLSession.shared.dataTask(with: uri) { data, response, error in
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                DispatchQueue.main.async {
                    self.weatherData.name = weatherData.name
                    self.weatherData.weather[0].set(weather: weatherData.weather[0])
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
        