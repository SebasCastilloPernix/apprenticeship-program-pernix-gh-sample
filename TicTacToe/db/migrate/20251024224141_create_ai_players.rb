class CreateAiPlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_players do |t|
      t.timestamps
    end
  end
end
