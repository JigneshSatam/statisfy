class Profile < ActiveRecord::Base
  has_many :answers
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

  def nlp_score
    require 'rest-client'
    profile = self
    overall_score = 0.0
    # profile.questions.each do |qstn|
    #   answer_content = qstn.answer.content
    #   api_url = 'https://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment?outputMode=json&text='+answer_content+'&apikey=ef7c7ac59a4d1ea6609a6886d99212c7b101d5a3'
    #   result = RestClient.get(api_url)
    #   answer_score = result['docSentiment']['score'].to_f * qstn.weight
    #   overall_score += answer_score
    # end
    # ans_arr = ['fabulous.','The best','Ok','It makes me feel really happy.','Good.','Best in industry!','Top.','They are good. But they are also good. I am good hence they are good. If I am bad then they are worst.']
    # ans_arr = ['Cool Workplace','Extraordinary','innovative','fresh and enthusiastic','it is next to no one','Work freedom with responsibilities','Overall development','Excellent and hardworking']
    overall_score = 0.0
    ans_arr = ['Fine','Normal','Normal','Not good everyday','Good','Fine','Fine','Fabulous']
    ans_arr.each do |answer_content|
    api_url = 'https://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment?outputMode=json&text='+answer_content+'&apikey=ef7c7ac59a4d1ea6609a6886d99212c7b101d5a3'
    result = RestClient.get(api_url)
    result = JSON.parse(result.body)
    answer_score = result['docSentiment']['score'].to_f
    puts answer_score
    overall_score = overall_score + answer_score
    end
    overall_score =  (overall_score / 8) * 40  + 47
  end


  def average_stay_satisfaction
    avg_stay_score = self.average_stay.to_f*5/self.experience.to_f
    return avg_stay_score.nan? ? 0 : avg_stay_score
  end
end
