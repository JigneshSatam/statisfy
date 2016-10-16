class ProfilesController < ApplicationController
  def index
    # profiles = [{id: "1", first_name: "Jignesh", last_name: "Satam", photo: "https://secure.gravatar.com/avatar/115befdd8cc9f50349bcb631c3a65a03.png?d=retro&r=PG&s=300", email: "jigneshs@gmail.com"}, {id: "2", first_name: "Aman", last_name: "Luthra", photo: "https://media.starwars.ea.com/content/starwars-ea-com/en_US/starwars/battlefront/news-articles/collect-iconic-heroes-and-dominate-the-universe-in-star-wars-gal/_jcr_content/featuredImage/renditions/rendition1.img.jpg", email: "amanl@idfy.com"}]
    fname_or_email, lname = params[:search_string].try(:strip).try(:split, " ")
    if fname_or_email.present?
      profiles = Profile.where("first_name ilike :fname_or_email OR last_name ilike :lname OR email ilike :fname_or_email", {fname_or_email: fname_or_email, lname: lname})
    else
      profiles = Profile.all
    end
    render json: ({profiles: profiles}.to_json)
  end

  def show
  end
end
