class Category < ApplicationRecord
  belongs_to :user
  has_many :projects

  before_destroy :empty_related_projects

  private
  def empty_related_projects
   self.projects.each do |project|
     project.category_id = -1
     project.save
   end
  end

end
