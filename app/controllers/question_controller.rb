class QuestionController < ApplicationController
  def index
  end

  def quiz
    respond = params.permit(:question, :id, :level)
    question = respond[:question] # .gsub(' ', '').strip
    id = respond[:id]
    level = respond[:level]

    head :ok

    regexps = [] # delete in prod

    case level

    when 1
      answer = $level1_poems[question]

    when 2
      Regexp.new(Regexp.escape(question).sub('%WORD%', '(\S+)')) =~ $level2_poems
      answer = $1

    when 3
      Regexp.new(Regexp.escape(question).gsub('%WORD%', '(\S+)')) =~ $level2_poems
      answer = "#{$1},#{$2}"

    when 4
      Regexp.new(Regexp.escape(question).gsub('%WORD%', '(\S+)')) =~ $level2_poems
      answer = "#{$1},#{$2},#{$3}"

    when 5
      question = Regexp.escape(question.strip)
      question.scan(/[^[,—][:space:]]+/) do |word|
        rg = question.clone
        rg[$~.offset(0)[0]...$~.offset(0)[1]] = '(\S+)'
        regexps << rg
        if Regexp.new(rg) =~ $level5_poems
          answer = "#{$1},#{word.gsub('\\', '')}"
          break
        end
      end


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
    # binding.pry

    $contest_tasks << {question: respond[:question], answer: answer, level: level}

    if answer
      puts '=' * 40
      puts "Question:\n#{respond[:question]}"
      puts "Answer:\n#{answer}"
    else
      File.open('./log/question.log', 'a') do |file|
        file.puts "Question:\n" + respond[:question]
        regexps.each do |regexp|
          file.puts "Regexp:\n" + regexp
        end
        file.puts 'Level: ' + level.to_s
        file.puts '=' * 40
        file.puts
      end
    end

  end

end
