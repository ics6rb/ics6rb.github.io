class IndexController < ApplicationController
  def input; end

  def output
    if params[:a]
      @result = params[:a].split.map { |x| Integer(x) }.filter(&:even?)
    else
      @error = 'Ошибка'
    end
  rescue StandardError
    @error = 'Некорректный ввод'
  end
end
