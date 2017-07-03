class Api::Photos < Grape::API
  namespace :photos do
    desc 'Upload photos', entity: Entities::Photo
    params do
      requires :file, type: File
    end
    post :upload do
      present Photo.create!(file: params[:file]), with: Entities::Photo
    end
  end
end
