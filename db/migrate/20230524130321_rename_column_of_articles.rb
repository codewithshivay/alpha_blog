class RenameColumnOfArticles < ActiveRecord::Migration[6.0]
  change_table :articles do |t|
    t.rename :testing, :bar_code
  end
end
