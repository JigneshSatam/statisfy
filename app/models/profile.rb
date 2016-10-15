class Profile < ActiveRecord::Base
  def salary_satisfaction
    x = self.salary
    y = median_of_salary(self.organization)
    return point_socred = (40 - (1-x/y)*40)
  end

  def median_of_salary(organization)
    YAML.load_file("#{Rails.root}/config/organization.yml")["organization"][organization]
  end

  def distance_satisfaction
    map_result = google_time_in_min
    result_body = JSON.parse(map_result.body)
    time_in_sec = result_body["rows"][0]["elements"][0]["duration"]["value"]
    time_in_min = time_in_sec/60
    distance_score_hash = {0 => 5, 1 => 4, 2 => 3, 3 => 2, 4 => 1}
    distance_score = distance_score_hash[time_in_min/18] || 0
    return distance_score
  end

  def google_time_in_min
    require 'rest-client'
    # destinations = self.company.address
    destination = YAML.load_file("#{Rails.root}/config/company.yml")["company"][self.company.name]
    origin = self.address
    # destination = "4f,rushabh chambers, marol, anderi, mumbai"
    # origin = "a/303,Jai chitrakoot, kulupwadi, borivali, mumbai"
    RestClient.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&language=en-EN&mode=transit&key=AIzaSyAB_azMQZ_fwiRLytMVTgPu4r8KOUkw93M")
  end
end
