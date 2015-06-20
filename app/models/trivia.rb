class Trivia < ActiveRecord::Base

  self.table_name = "trivia"

  belongs_to :source
  belongs_to :category

  validates :city, :presence => true

  before_create do

    if(self.id.nil?)
      result = Trivia.select('id').order('id DESC').limit(1)
      maxid = 0
      result.each do |a|
        maxid = a.id + 1
      end
      self.id = maxid
    end

  end
  
  def self.search(params)

    if params[:zipcode].present?
      return location_search(params)
    end

    results = Trivia.scoped.select('DISTINCT(city), state')

    if params[:state].present?
      results = results.where("state LIKE ? ","%#{params[:state]}%")
    end

    if params[:city].present?
      results = results.where("city LIKE ? ","%#{params[:city]}%")
    end

    if params[:content].present?
      results = results.where(["lower(content) LIKE ? ", "%#{params[:content]}%"])
    end

    results = results.order("city asc, state asc")

    results

  end

  def location_string
    "#{city}, #{state}"
  end

  def self.city_search(city)
    city = city.downcase
    result = Trivia.select('DISTINCT trim(city) as city, state').where("lower(city) LIKE ? ","#{city}%") unless city.blank?
  end

  def country()
    @country = "USA"
    return @country
  end

  def trivia_count
    count = Trivia.select('id').where("city = ? ","#{city}").where("state = ? ","#{state}")
    return count.count
  end


end
