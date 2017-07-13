namespace :thumbnails do
  task save: :environment do
    Post.all.each do |post|
      thumbnail = LinkThumbnailer.generate(post.link).images.first || post.link
      post.update(thumbnail: thumbnail)
      puts "Saved #{thumbnail}"
    end
  end
end
