class Admin::SkillsController < ApplicationController
  before_action :signed_in_user
  
  def index
    @skills = Skill.paginate page: params[:page], per_page: 10
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = "New skill created successfully"
      redirect_to admin_skills_path
    else
      render 'new'
    end
  end

  def edit
    @skill = Skill.find params[:id]
  end

  def update
    @skill = Skill.find params[:id]
    if @skill.update_attributes skill_params
      flash[:success] = "Skill updated successfully"
      redirect_to admin_skills_path
    else
      render 'edit'
    end
  end

  def destroy
    @skill = Skill.find params[:id]
    unless @skill.destroy
      flash[:error] = "Delete skill failed"
    end
    redirect_to admin_skills_path
  end

  private 
  def skill_params
    params.require(:skill).permit(:name)
  end
end