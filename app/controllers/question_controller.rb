class QuestionController < ApplicationController
  def index
    binding.pry
  end

  def quiz
    respond = params.permit(:question, :id, :level)
    question = respond[:question]
    id = respond[:id]
    level = respond[:level]

    head :ok

    case level
    when 1
      answer = $level1_poems[question]
    else
      puts 'NEXT LEVEL'
    end

    uri = URI("http://pushkin.rubyroidlabs.com/quiz")
    parameters = {
      answer: answer,
      token: '0a8edbd1281c62f12dd27590298a25d8',
      task_id:  id
    }
    # Net::HTTP.post_form(uri, parameters)

    unless answer
      File.open('./log/question.log', 'a') do |file|
        file.puts 'Question: ' + question
        file.puts 'Level: ' + level
        file.puts '=' * 40
        file.puts
      end
    end

  end

end
