namespace :scores do
  task save: :environment do
    Post.all.each { |post| post.save }
  end
end
