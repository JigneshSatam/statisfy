task :profile_creation => :environment do
  profile = Profile.create(first_name: "Akash", last_name: "Sethiya", address: "Bisleri Compound, Andheri East, mumbai", salary: 300000, age: 24, experience: 3, highest_qualification: nil, organization: "University of Mumbai", email: "akashs@idfy.com", average_stay: 3, company: "IDfy", married: false, photo: "https://lh3.googleusercontent.com/-SxQq2FiOFuY/AAAAAAAAAAI/AAAAAAAAAIs/j629SW50QHE/photo.jpg")

  question_answer_hash = {
    "How do you feel about the company?" => "great place to work, cant imagine to work somewhere else",
    "How would you describeyour performance in the company?" => "got great opportunities, tried to make the most of it, i guess have done justice",
    "How would you describethe company's performance?" => "the company is scaling at rapid rate",
    "How does coming to work each morning make you feel?" => "its a part of my life. its like that i have to do",
    "How would you describe your work environment?" => "amazing people to work with, feels great to be present",
    "How would you describe your work in the company?" => "loads of work to do and love doing it",
    "How would you describe the work culture in your company?" => "the best part here, you never feel burdened",
    "How would you describe your peers in your company?" => "some of the great minds I have ever met and great people"
  }
  question_answer_hash.each do |quest, ans|
    ans = Question.where(content: quest).last.answers.build(profile_id: profile.id, content: ans)
    ans.save
  end
end
