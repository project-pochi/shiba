class CreateSitterBusyDays < ActiveRecord::Migration
  def change
    create_table :sitter_busy_days, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :sitter, index: true, null: false
      t.boolean    :sunday,    null: false, default: false
      t.boolean    :monday,    null: false, default: false
      t.boolean    :tuesday,   null: false, default: false
      t.boolean    :wednesday, null: false, default: false
      t.boolean    :thursday,  null: false, default: false
      t.boolean    :friday,    null: false, default: false
      t.boolean    :saturday,  null: false, default: false

      t.timestamps null: false
    end
  end
end
