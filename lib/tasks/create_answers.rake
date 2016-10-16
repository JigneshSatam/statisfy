task :create_answers => :environment do
  question_answer_hash = {
    "How do you feel about the company?" => "Cool Workplace",
    "How would you describeyour performance in the company?" => "Extraordinary",
    "How would you describethe company's performance?" => "innovative",
    "How does coming to work each morning make you feel?" => "fresh and enthusiastic",
    "How would you describe your work environment?" => "next to no one",
    "How would you describe your work in the company?" => "Work freedom with responsibilities",
    "How would you describe the work culture in your company?" => "Overall development",
    "How would you describe your peers in your company?" => "Excellent and hardworking"
  }
  p_id = Profile.first.id
  question_answer_hash.each do |quest, ans|
    ans = Question.where(content: quest).last.build_answer(profile_id: p_id, content: ans)
    ans.save
  end
end
