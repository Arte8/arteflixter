class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:create]
  before_action :require_authorized_for_current_section, only: [:update]

  
    
   def create
     @section = current_course.sections.create(section_params)
     redirect_to instructor_course_path(current_course)
  end

    def update
    current_section.update_attributes(section_params)
    render plain: 'ok!'
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    end
  end

  def current_section
    @current_section ||= Section.find(params[:id])
  end

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    end
  end

   helper_method :current_course
 def current_course
   # if params[:course_id]
    @current_course ||= Course.find(params[:course_id])
   end
  #    current_section.course
  # end


  def section_params
    params.require(:section).permit(:title)
  end
end
