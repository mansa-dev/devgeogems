class TriviaItem < ActiveRecord::Base
  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude
  
  belongs_to :category
  belongs_to :source
  belongs_to :contributor
  
  validates :city, :presence => true
  
  def self.search(params)
    if params[:zipcode].present?
      return location_search(params)
    end
    
    results = TriviaItem
    if params[:state].present?
      results = results.where("state LIKE '%#{params[:state]}%'")

    end
    if params[:city].present?
      results = results.where("city LIKE '%#{params[:city]}%'")

    end
    if params[:content].present?
      results = results.where(["lower(content) LIKE ?", "%#{params[:content]}%"])
    end

    results = results.order("city asc, state asc")

    results
  end
  
  def self.location_search(params)
    TriviaItem.paginate \
      :origin => params[:zipcode], 
      :units => :miles, 
      :order => "distance asc", 
      :conditions => "latitude is not null and longitude is not null",
      :page => params[:page]
  end

  
  def location_string
    "#{city}, #{state}"
  end

  def self.city_search(city)
      city = city.downcase
      result = TriviaItem.select('DISTINCT city, state').where("lower(city) LIKE '#{city}%'") unless city.blank?
  end
end