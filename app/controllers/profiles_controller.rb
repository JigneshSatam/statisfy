class ProfilesController < ApplicationController
  def index
    profiles = [{id: "1", name: "Jignesh Satam", photo: "https://secure.gravatar.com/avatar/115befdd8cc9f50349bcb631c3a65a03.png?d=retro&r=PG&s=300", email: "jigneshsatam@gmail.com"}, {id: "2", name: "Aman Luthra", photo: "https://media.starwars.ea.com/content/starwars-ea-com/en_US/starwars/battlefront/news-articles/collect-iconic-heroes-and-dominate-the-universe-in-star-wars-gal/_jcr_content/featuredImage/renditions/rendition1.img.jpg", email: "amanluthra@gmail.com"}]
    render json: {profiles: profiles}
    # resposnd_to do |format|
    #   format.json {profiles: profiles}
    # end
  end
end
