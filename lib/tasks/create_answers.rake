task :create_answers => :environment do
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
  p_id = Profile.last.id
  question_answer_hash.each do |quest, ans|
    ans = Question.where(content: quest).last.answers.build(profile_id: p_id, content: ans)
    ans.save
  end
end
