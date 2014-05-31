namespace :kevin do
  desc "TODO"
  task get_posts: :environment do

    Post.all.each do |p|
      puts p.title
    end

  end

end
