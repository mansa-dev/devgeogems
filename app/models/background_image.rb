class BackgroundImage
  IMAGES = [
           {:src => "/images/grain.jpg",
            :attr_href => "http://www.flickr.com/photos/picsfromjos/",
            :attr_name => "JSFauxtaugraphy",
            :name => "grain"
            },
           {:src => "/images/mountain.jpg",
            :name => "mountain",
            :attr_href => "http://www.flickr.com/photos/northbayliving",
            :attr_name => "Photos From Lords Manor"
            },
            {:src => "/images/sky.jpg",
             :name => "sky",
             :attr_name => "Gui Trento",
             :attr_href => "http://www.flickr.com/photos/guitrento"}
            ]
  def self.new
    IMAGES[rand(IMAGES.size)]
  end
end