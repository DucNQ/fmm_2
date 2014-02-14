class Admin::ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user

  def index
    @projects = Project.paginate page: params[:page]
  end

  def show
    @project = Project.find params[:id]
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save 
      flash[:success] = "Project created successfully"
      redirect_to admin_projects_path
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find params[:id]
    if params[:team_id].nil?
      @users = User.all
    else
      @users = Team.find(params[:team_id]).members
    end

    @users.each do |user|
      if ProjectsUser.find_by(user_id: user.id, project_id: @project.id).nil?
        @project.projects_users.build user_id: user.id
      end
    end

    unless params[:team_id].nil?
      render partial: "project_edit_form", project: @project
    end

  end

  def update
    @project = Project.find params[:id]
    if @project.update_attributes project_params
      flash[:success] = "Project updated successfully"
      redirect_to admin_projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find params[:id]
    if !@project.destroy
      flash.now[:failure] = "Project deletion failed"
    end
    redirect_to admin_projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :abbr, :team_id,
      :leader_id, :start_date, :end_date,
      projects_users_attributes:[:id, :user_id, :member, :_destroy])
  end

end
