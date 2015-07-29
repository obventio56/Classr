class AddOriginalHtmlToTests < ActiveRecord::Migration
  def change
    add_column :tests, :original_html, :text
  end
end
