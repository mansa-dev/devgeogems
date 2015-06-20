desc "Import from CSV"
task :import_trivia_from_csv => [:environment] do
  
  categories = FasterCSV.open(Rails.root.join("categories.csv"), "r")
  puts "Importing categories"
  categories.each_with_index do |arr, index|
    next if index == 0 || arr.compact.empty?
    cat = Category.create!(:name => arr[1], :description => arr[2])
    cat.name = arr[1]
  end
  puts "Done importing categories."
  
  sources = FasterCSV.open(Rails.root.join("sources.csv"), "r")
  puts "Importing sources"
  sources.each_with_index do |arr, index|
    next if index == 0 || arr.compact.empty?
    source = Source.new
    source.author = arr[1]
    source.title = arr[2]
    source.publisher = arr[3]
    source.save!
  end
  puts "Done importing sources."
  
  trivia = FasterCSV.open(Rails.root.join("trivia_items.csv"), "r")
  puts "Importing trivia"
   # id,"state","city","country",source_id,category_id,contributor_id,"content","zip_code","created_at","updated_at"
  trivia.each_with_index do |arr, index|
     next if index == 0 || arr.compact.empty?
     puts index if index % 100 == 0
     
     ti = TriviaItem.new
     ti.state = arr[1]
     ti.city = arr[2]
     ti.country = arr[3]
     ti.source_id = arr[4]
     ti.category_id = arr[5]
     ti.contributor_id = arr[6]
     ti.content = arr[7]
     ti.zip_code = arr[8]
     ti.save!
   end
  puts "Done importing trivia."
end