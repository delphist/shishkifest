class Member::RejectForm < ApplicationForm
  property :id
  property :comment, virtual: true
end
