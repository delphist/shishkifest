class ActiveAdmin::CommentPolicy < ApplicationPolicy
  def create?
    true
  end
end
