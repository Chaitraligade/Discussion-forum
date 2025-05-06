ActiveAdmin.register DiscussionThread do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :user_id, :tag_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :user_id, :tag_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :title, :body, :user_id, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :title
    column :body
    column :user
    column :created_at
    actions
  end
  filter :taggings_id

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :user, as: :select, collection: User.all.map { |u| [u.username, u.id] }
    end
    f.actions
  end
end
