class RegisterFormService
  attr_reader :form, :model, :hash

  def initialize form
    @form = form
    @model = nil
    @hash = nil
  end

  def perform
    Member.transaction do
      @form.save do |hash|
        @model = form.model
        @hash = hash
        assign_hash_to_model
        model.save
      end
    end
  end

  private

    def assign_hash_to_model
      @model.attributes = hash.slice(*params)
      @model.photo_ids = photo_ids
    end

    def photo_ids
      hash[:photos].map { |e| e[:id].to_i }
    end

    def params
      [:name, :license, :about, :phone]
    end
end
