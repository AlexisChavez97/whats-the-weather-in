# frozen_string_literal: true

class CreateCurrentWeather
  include Interactor

  def call
    save_weather_report
   end

   private
     def save_weather_report
       weather_report = WeatherReport.new(weather_report_attributes)
       weather_report.user = context.user
       if weather_report.save
         context.weather_report = weather_report
       else
         context.fail!(message: weather_report.errors.full_messages)
       end
     end

     def weather_report_attributes
       {
         city: context.geolocation.name,
         state: context.geolocation.state,
         condition: context.weather_data.current.weather.first.description,
         temperature: context.weather_data.current.temp,
         latitude: context.geolocation.lat,
         longitude: context.geolocation.lon,
         icon: context.weather_data.current.weather.first.icon
       }
     end
end
