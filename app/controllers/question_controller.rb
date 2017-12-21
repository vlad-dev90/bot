class QuestionController < ApplicationController
  def index
    binding.pry
  end

  def quiz
    # @respond = params.permit(:question, :id, :level)
    head :ok
    # uri = URI("http://0.0.0.0:3000")
    # parameters = {
    #   answer: 'ваш ответ',
    #   token: 'API_KEY (см. процесс регистрации)',
    #   task_id:  'id задачи (передано ранее)'
    # }
    # Net::HTTP.post_form(uri, parameters)
    p params
  end

  def test
    binding.pry
  end
end
