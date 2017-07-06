class MemberPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def approve?
    record.may_approve?
  end

  def reject?
    record.may_reject?
  end
end
