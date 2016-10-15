class Profile < ActiveRecord::Base
  def salary_satisfaction
    x = self.salary
    y = median_of_salary(self.organization)
    return point_socred = (40 - (1-x/y)*40)
  end

  def median_of_salary(organization)
    YAML.load_file("#{Rails.root}/config/organization.yml")["organization"][organization]
  end
end
