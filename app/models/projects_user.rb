class ProjectsUser < ActiveRecord::Base
  attr_accessor :member

  belongs_to :project 
  belongs_to :user
end