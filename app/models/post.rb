class Post < ActiveRecord::Base
  has_ancestry(orphan_strategy: :destroy)
  belongs_to :user

  after_create :move_to_bottom

  validates :title, length: {minimum: 1}, if: "ptype == FOLDER_TYPE"

  def getTypeString
    case self.ptype
    when FOLDER_TYPE
      "folder"
    when BLOG_TYPE
      "blog"
    when TWEET_TYPE
      "note"
    when LINK_TYPE
      "link"
    end
  end

  def move_higher
    puts "Entered move_higher for '"+ self.title + "' (id: "+ self.id.to_s + ")"
    if self.is_root? || self.is_only_child?
      puts "Is only child."
      self.update(position: 0)
      return
    end

    my_position = self.position
    puts "My_position: " + my_position.to_s
    my_siblings = self.siblings.order(:position)

    my_siblings.each do |s|
      puts s.position.to_s
    end

    # For now, assume each position value is unique within siblings
    sibling_above = my_siblings.first
    puts "My first sibling's position: " + sibling_above.position.to_s
    my_siblings.each do |s|
      puts "s.id: " + s.id.to_s
      puts "s.title: " + s.title
      if s.id == self.id
        new_position = sibling_above.position

        sibling_above.update(position: my_position)
        self.update(position: new_position)
        return
      end
      sibling_above = s
    end

  end

  def move_lower
    puts "Entered move_lower"
    if self.is_root? || self.is_only_child?
      self.update(position: 0)
      return
    end

    my_siblings = self.siblings.order(:position).reverse_order
    sibling_below = my_siblings.first
    my_siblings.each do |s|
      if s.id == self.id
        new_position = sibling_below.position

        sibling_below.update(position: self.position)
        self.update(position: new_position)

        return
      end
      sibling_below = s
    end
  end

  def move_to_top
    puts "Entered move_to_top() for " + self.title

    if self.is_root? || self.is_only_child?
      puts "move_to_top only child."
      self.update(position: 0)
      return
    end

    puts self.title + " supposedly has siblings (next line):"

    my_siblings = self.siblings.order(:position)

    lowest_position = my_siblings.minimum("position")
    puts "Lowest position: " + lowest_position.to_s
    self.update(position: (lowest_position - 1))
    puts "Exited move_top_top."
  end

  def move_to_bottom
    if self.is_root? || self.is_only_child?
      self.position = 0
      self.save
      return
    end

    my_siblings = self.siblings.order(:position).reverse_order
    highest_position = my_siblings.maximum("position")
    self.update(position: (highest_position + 1))

  end

  def icon
    case self.ptype
    when FOLDER_TYPE
      "glyphicon glyphicon-folder-open"
    when BLOG_TYPE
      "glyphicon glyphicon-comment"
    when LINK_TYPE
      "glyphicon glyphicon-bookmark"
    when TWEET_TYPE
      "glyphicon glyphicon-pushpin"
    end
  end

end
