class Category < ActiveRecord::Base

  def name()
    @cat = self.cat_name
    return @cat
  end

end
