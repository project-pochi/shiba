class CreateSitterBusyDates < ActiveRecord::Migration
  def change
    create_table :sitter_busy_dates, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :sitter, index: true, null: false
      t.date       :date,   index: true, null: false
      t.string     :type

      t.timestamps null: false
    end
  end
end
