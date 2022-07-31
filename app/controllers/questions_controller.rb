class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Question.create(
      body: params[:question][:body],
      user_id: params[:question][:user_id]
    )
  end

  def update
    @question = Question.find(params[:id])
    @question.update(
      body: params[:question][:body],
      user_id: params[:question][:user_id]
    )
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
  end
  #Показать конкретный вопрос(объект)
  def show
    @question = Question.find(params[:id])
  end

  #Показать список вопросов(объектов)
  def index
    @questions = Question.all
  end

end