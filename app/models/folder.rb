class Folder < ActiveRecord::Base
  belongs_to :post
  has_many: children, class: => 'post'
end
