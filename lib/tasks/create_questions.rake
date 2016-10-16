task :create_questions => :environment do
  questions_content = ['How do you feel about the company?','How would you describeyour performance in the company?',"How would you describethe company's performance?",'How does coming to work each morning make you feel?','How would you describe your work environment?','How would you describe your work in the company?','How would you describe the work culture in your company?','How would you describe your peers in your company?']
  questions_content.each do |qc|
    Question.create(content: qc, question_type: true, weight: 1)
  end
end
