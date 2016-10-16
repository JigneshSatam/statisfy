task :profile_creation => :environment do
  profile = Profile.create(first_name: "Dinesh", last_name: "Sawant", address: "diva, thane", salary: 300000, age: 25, experience: 3, highest_qualification: nil, organization: "University of Mumbai", email: "dineshs@idfy.com", photo: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xft1/v/t1.0-1/c32.9.116.116/1975083_654976974558685_1588064331_n.jpg?oh=3cd2065457f61266956f5c972d2dc240&oe=58636011&__gda__=1486969079_8a437e4ac160278dd3176050092ddad7", average_stay: 2, company: "IDfy", married: false)

  question_answer_hash = {
    "How do you feel about the company?" => "fabulous.",
    "How would you describeyour performance in the company?" => "The best",
    "How would you describethe company's performance?" => "Ok",
    "How does coming to work each morning make you feel?" => "It makes me feel really happy.",
    "How would you describe your work environment?" => "Good.",
    "How would you describe your work in the company?" => "Best in industry!",
    "How would you describe the work culture in your company?" => "Top.",
    "How would you describe your peers in your company?" => "They are good. But they are also good. I am good hence they are good. If I am bad then they are worst."
  }
  question_answer_hash.each do |quest, ans|
    ans = Question.where(content: quest).last.answers.build(profile_id: profile.id, content: ans)
    ans.save
  end
end
