class AddUser < ActiveRecord::Migration[6.1]
  def change
    if !User.find_by_email('admin@mail.com')
      User.create! do |u|
        u.email     = 'admin@mail.com'
        u.name = 'Application Administrator'
        u.password  = '123456'
        u.role = 'ADMIN'
      end
    end
  end
end
