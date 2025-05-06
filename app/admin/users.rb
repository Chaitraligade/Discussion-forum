ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :role, :bio, :username
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :role, :bio, :username]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  # permit_params :email, :username, :bio, :role
  permit_params :username, :email, :bio, :role, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :role
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :username
      f.input :bio
      f.input :role, as: :select, collection: User.roles.keys
    end
    f.actions
  end

  filter :id
  filter :username
  filter :email
  filter :bio
  filter :role, as: :select, collection: User.roles
  
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :email
      row :username
      row :bio
      row :role
      row :created_at
      row :updated_at
    end
  end
end
