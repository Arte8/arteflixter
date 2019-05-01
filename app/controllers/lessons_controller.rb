class LessonsController < ApplicationController
#  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]
    

  def show
    
  end

  private
  def require_authorized_for_current_lesson
    
    if current_lesson.section.course.user != current_user
      # return render plain: 'Unauthorized', status: :unauthorized
      # redirect_to root_url, alert: 'UH-OH...WHOOPS!'
      redirect_to course_path(current_course), alert: 'UH-OH...WHOOPS! gotta sign up'
      # redirect_to course_path, alert: 'UH-OH...WHOOPS gotta sign up!'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
