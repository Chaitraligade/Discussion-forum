ActiveAdmin.register ThreadChat do
  permit_params :title, :user_id

  index do
    selectable_column
    id_column
    column :user
    column :title
    column :created_at
    actions
  end

  filter :user
  filter :title
  filter :created_at

  form do |f|
    f.inputs "Thread Chat Details" do
      f.input :user, as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :title
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :title
      row :created_at
    end
  end
end
