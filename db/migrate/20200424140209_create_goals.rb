class CreateGoals < ActiveRecord::Migration
  def change
    create_table "goals", force: :cascade do |t|
      t.string  "goal_name"
      t.string  "goal_type"
      t.text    "goal_details"
      t.text    "obstacles"
      t.integer "rate_experience"
      t.integer "user_id"
    end
  end
end
