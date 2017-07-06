class MemberDecorator < Draper::Decorator
  delegate_all

  def photo
    photos.first
  end
end
