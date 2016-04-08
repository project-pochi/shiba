class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string  :first_name,              :null => false
      t.string  :last_name,               :null => false
      t.string  :encrypted_email_address, :null => false, :default => ''
      t.string  :encrypted_phone_number,  :null => false, :default => ''
      t.string  :encrypted_zip_code,      :null => false, :default => ''
      t.string  :password_hash,           :null => false
      t.string  :gender,                                  :default => ''
      t.date    :birthdate,               :null => false, :default => '1900-01-01'
      t.boolean :disabled,                :null => false, :default => false

      t.timestamps :null => false
    end
      add_index :users, :encrypted_email_address, :unique => true
      add_index :users, :password_hash
  end
end
