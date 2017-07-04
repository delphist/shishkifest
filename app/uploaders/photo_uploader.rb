class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :upload_preview do
    process resize_to_fill: [400, 400]
    process convert: 'jpg'
    def full_filename for_file = model.photo.file
      'thumb.png'
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "original.#{model.file.file.extension}" if original_filename
  end
end
