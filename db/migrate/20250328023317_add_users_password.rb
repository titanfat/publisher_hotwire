class AddUsersPassword < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :orcid, :bigint
    add_column :users, :email, :string
    add_column :users, :password_digest, :string

    User.where(email: nil, password_digest: nil).find_each.with_index do |user, idx|
      hash_password = BCrypt::Password.create("123456")
      user.update!(email: "author#{idx + 1}@mail.com", password_digest: hash_password)
    end

    add_index :users, :email, unique: true
    add_check_constraint :users, 'email IS NOT NULL'
    add_check_constraint :users, 'password_digest IS NOT NULL'
  end
end
