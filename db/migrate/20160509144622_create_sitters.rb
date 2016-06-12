class CreateSitters < ActiveRecord::Migration
  def change
    create_table :sitters, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :user,           :index => { unique: true }
      t.string     :zip_code,       :null => false, :default => ''
      t.references :residence_type, :index => true
      t.references :capacity_type,  :index => true
      t.date       :has_dog_from

      t.timestamps :null => false
    end
  end
end
