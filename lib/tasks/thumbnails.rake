namespace :thumbnails do
  task save: :environment do
    Post.all.each { |post| post.get_thumbnail }
  end
end
