class Member::ApproveForm < ApplicationForm
  property :id
  property :comment, virtual: true
end
