ActiveAdmin.register Member do
  decorate_with MemberDecorator
  permit_params :name, :license, :about, :phone
  config.filters = false
  config.batch_actions = false

  action_item :approve,
    if: -> { Pundit.policy(current_admin_user, resource).approve? },
    only: :show do
      link_to I18n.t('active_admin.approve'), approve_admin_member_path(resource)
    end

  action_item :reject,
    if: -> { Pundit.policy(current_admin_user, resource).reject? },
    only: :show do
      link_to I18n.t('active_admin.reject'), reject_admin_member_path(resource)
    end

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

    panel I18n.t 'activerecord.attributes.member.sms_histories' do
      render 'sms_history'
    end

    panel I18n.t 'activerecord.attributes.member.photos' do
      render \
        partial: 'photos',
        locals: { photos: member.photos }
    end

    active_admin_comments
  end

  member_action :approve, method: [:get, :patch] do
    @form = Member::ApproveForm.new resource

    if request.patch?
      if @form.validate params[:member_approve].permit(:message)
        Member::StatusService.new(@form, current_admin_user, :approve).perform
        redirect_to resource_path, notice: 'Заявка одобрена'
      end
    end
  end

  member_action :reject, method: [:get, :patch] do
    @form = Member::RejectForm.new resource

    if request.patch?
      if @form.validate params[:member_reject].permit(:message)
        Member::StatusService.new(@form, current_admin_user, :reject).perform
        redirect_to resource_path, notice: 'Заявка отклонена'
      end
    end
  end
end
