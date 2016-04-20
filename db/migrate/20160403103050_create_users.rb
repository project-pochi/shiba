class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string   :first_name,              :null => false
      t.string   :last_name,               :null => false
      t.string   :encrypted_email_address, :null => false, :default => ''
      t.string   :encrypted_phone_number,  :null => false, :default => ''
      t.string   :encrypted_zip_code,      :null => false, :default => ''
      t.string   :password_digest,         :null => false
      t.string   :gender,                                  :default => ''
      t.date     :birthdate,               :null => false, :default => '1900-01-01'
      t.boolean  :activated,               :null => false, :default => false
      t.datetime :activated_at
      t.string   :activation_digest
      t.string   :remember_digest
      t.string   :reset_digest
      t.datetime :reset_sent_at
      t.timestamps :null => false
    end

      add_index :users, :encrypted_email_address, :unique => true
      add_index :users, :password_digest
  end
end
