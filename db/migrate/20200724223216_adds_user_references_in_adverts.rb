class AddsUserReferencesInAdverts < ActiveRecord::Migration[6.0]
  def change
    add_reference :adverts, :user, foreign_key: true
  end
end
