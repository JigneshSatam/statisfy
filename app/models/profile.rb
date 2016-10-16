class Profile < ActiveRecord::Base
  has_many :answers
  def salary_satisfaction(weightage)
    x = self.salary
    median_salary = median_of_salary(self.organization)
    sal_should_be_paid = calc_sal_should_be_paid(median_salary) if median_salary.present?
    if sal_should_be_paid.present? && sal_should_be_paid > x
      return point_socred = (weightage - (1-x/sal_should_be_paid.to_i)*weightage)
      # return point_socred = (40 - (1-x/y)*40)
    else
      return weightage
    end
  end

  def median_of_salary(organization)
    YAML.load_file("#{Rails.root}/config/organization.yml")["organisation"][organization] || 0
  end

  def calc_sal_should_be_paid(median_salary)
    exp = self.experience || 0
    sal_should_be_paid = median_salary
    while exp > 0 do
      sal_should_be_paid = sal_should_be_paid + (sal_should_be_paid*15/100)
      exp = exp - 1
    end
    return sal_should_be_paid
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
    destination = YAML.load_file("#{Rails.root}/config/company.yml")["companies"][self.company]
    origin = self.address
    # destination = "4f,rushabh chambers, marol, anderi, mumbai"
    # origin = "a/303,Jai chitrakoot, kulupwadi, borivali, mumbai"
    RestClient.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&language=en-EN&mode=transit&key=AIzaSyAB_azMQZ_fwiRLytMVTgPu4r8KOUkw93M")
  end

  def nlp_score
    require 'rest-client'
    profile = self
    overall_score = 0.0
    profile.answers.includes(:question).each do |answer|
      answer_content = answer.content
      api_url = 'https://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment?outputMode=json&text='+answer_content+'&apikey=ef7c7ac59a4d1ea6609a6886d99212c7b101d5a3'
      result = RestClient.get(api_url)
      answer_score = result['docSentiment']['score'].to_f * answer.question.weight
      overall_score += answer_score
    end

    # overall_score = 0.0
    # ans_arr = ['Fine','Normal','Normal','Not good everyday','Good','Fine','Fine','Fabulous']
    # ans_arr = ['Good', 'Good', 'Good', 'Good', 'Good', 'Good', 'Good', 'Good']
    # ans_arr.each do |answer_content|
    # api_url = 'https://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment?outputMode=json&text='+answer_content+'&apikey=ef7c7ac59a4d1ea6609a6886d99212c7b101d5a3'
    # result = RestClient.get(api_url)
    # result = JSON.parse(result.body)
    # answer_score = result['docSentiment']['score'].to_f
    # puts answer_score
    # overall_score = overall_score + answer_score
    # end
    overall_score =  (overall_score / 8) * 40
  end


  def average_stay_satisfaction(weightage)
    avg_stay_score = self.average_stay.to_f*weightage/self.experience.to_f
    return avg_stay_score.nan? ? 0 : avg_stay_score
  end

  def age_marriage_satisfaction
    score = 0
    case age = self.age
    when age < 20
      score = 1 + marriage_score
    when 20..23
      score = 2 + marriage_score
    when 24..25
      score = 3 + marriage_score
    when 26..27
      score = 4 + marriage_score
    when 28..29
      score = 5 + marriage_score
    when age >= 30
      score = 5 + marriage_score
    end
    return score
  end
  def marriage_score
    score = 0;
    if self.married
      case age = self.age
      when age < 20
        score = 1
      when 20..23
        score = 2
      when 24..25
        score = 3
      when 26..27
        score = 4
      when 28..29
        score = 5
      when age >= 30
        score = 5
      end
    else
      case age = self.age
      when age < 20
        score = 0
      when 20..23
        score = 0
      when 24..25
        score = 1
      when 26..27
        score = 1
      when 28..29
        score = 2
      when age >= 30
        score = 3
      end
    end
    return score
  end

  def job_satisfaction
    # puts  "salary" + salary_satisfaction(40).to_s
    # puts  "distance_score" + distance_satisfaction.to_s
    # puts "age_marriage_satisfaction" + age_marriage_satisfaction.to_s
    # puts "average_stay_satisfaction" + average_stay_satisfaction(5).to_s
    # puts "nlp"*10
    return salary_satisfaction(40) + distance_satisfaction + age_marriage_satisfaction + average_stay_satisfaction(5) + nlp_score
  end

  def fit_for_organization
    salary_satisfaction(30) + nlp_score
  end
end
