namespace :trivia_items do
  desc "Set lat lng for trivia items"
  task :set_lat_lng => :environment do
    TriviaItem.find_each do |t|
      t.latitude  = Zipcode.average(:latitude, :conditions => {:city => t.city, :state => t.state})
      t.longitude = Zipcode.average(:longitude, :conditions => {:city => t.city, :state => t.state})
      
      if t.changed?
        puts "Updated #{t.id} (#{t.city}, #{t.state}) to #{t.latitude},#{t.longitude}"
        t.save!
      end
    end
  end
end
