ActiveAdmin.register Member do
  decorate_with MemberDecorator
  permit_params :name, :license, :about, :phone
  config.filters = false
  config.batch_actions = false

  index do
    column :photo do |member|
      if member.photo.present?
        link_to image_tag(member.photo.file.upload_preview.url), admin_member_path(member)
      end
    end
    column(:name) do |member|
      text_node link_to member.name, admin_member_path(member)
      br
      b member.phone
      br
      small member.license
    end
    column :about do |member|
      member.about.truncate(300)
    end
    state_column :state
    column :created_at
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :license
      f.input :phone
      f.input :about
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :phone
      row :license
      state_row :state
    end

    panel I18n.t 'activerecord.attributes.member.about' do
      div class: 'text' do
        simple_format member.about
      end
    end

    panel I18n.t 'activerecord.attributes.member.photos' do
      render \
        partial: 'active_admin/members/photos',
        locals: { photos: member.photos }
    end

    active_admin_comments
  end
end
