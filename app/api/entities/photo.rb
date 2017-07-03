class Entities::Photo < Grape::Entity
  expose :id
  expose :upload_preview_url do |e|
    e.file.upload_preview.url
  end
end
