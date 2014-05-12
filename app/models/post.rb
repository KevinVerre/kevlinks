class Post < ActiveRecord::Base
  has_ancestry(orphan_strategy: :destroy)
  belongs_to :user
end
