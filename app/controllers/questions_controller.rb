class QuestionsController < ApplicationController

  def create
    question = Question.create(
      body: params[:question][:body],
      user_id: params[:question][:user_id]
    )

    redirect_to question_path(question)
  end

  def update
    @question = Question.find(params[:id])
    @question.update(
      body: params[:question][:body],
      user_id: params[:question][:user_id]
    )

    redirect_to question_path(@question)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end
  #Показать конкретный вопрос(объект)
  def show
    @question = Question.find(params[:id])
  end

  #Показать список вопросов(объектов)
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

end
