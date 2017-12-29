require 'net/http'
class QuestionController < ApplicationController
  def index
  end

  def quiz
    respond = params.permit(:question, :id, :level)
    question = respond[:question]
    id = respond[:id]
    level = respond[:level]

    head :ok


    case level

    when 1
      answer = $level1_poems[question.gsub(/[\t ]/, '').strip]

    when 2
      answer = $level2_poems_2[question]


    when 3
      splited_question = question.split("\n")
      answer = "#{$level3_poems[splited_question[0]]},#{$level3_poems[splited_question[1]]}"


    when 4
      splited_question = question.split("\n")
      answer = "#{$level3_poems[splited_question[0]]},#{$level3_poems[splited_question[1]]},#{$level3_poems[splited_question[2]]}"

    when 5
      question.gsub!(/[\t ]/, '')
      question.strip!
      length = question.size
      s = nil
      e = 0
      question.scan(/,? /) do
        e = $~.offset(0)[0]
        start = s ? question[0..s] : ''
        break if answer = $level5_poems["#{start}%WORD%#{question[e..length]}"]
        s = $~.offset(0)[1] - 1
      end
      answer ||= $level5_poems["#{question[0..e]}%WORD%"]

    when 6,7
      answer = $level6_poems[question.chars.sort.join]

    when 8
      identifier = question.chars
      $level8_poems[identifier.size].each_pair do |line_id, line|
        diff_size = (identifier - line_id | line_id - identifier).size
        if (diff_size <= 2)
          answer = line
          break
        end
      end



    end

    uri = URI("http://pushkin.rubyroidlabs.com/quiz")
    parameters = {
      answer: answer,
      token: '0a8edbd1281c62f12dd27590298a25d8',
      task_id:  id
    }

    Net::HTTP.post_form(uri, parameters)
    # binding.pry

    $contest_tasks << {question: respond[:question], answer: answer, level: level}

    if answer
      puts '=' * 40
      puts "Question:\n#{respond[:question]}"
      puts "Answer:\n#{answer}"
    end

  end

end
