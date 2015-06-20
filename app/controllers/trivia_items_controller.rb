class TriviaItemsController < ApplicationController

  def index
    if params[:q]
      @trivia_items = Trivia.search(params)
      render "results"
    end
  end

  # GET /trivia_items/1
  # GET /trivia_items/1.xml
  def show
    @trivia_item = Trivia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trivia_item }
    end
  end

  # GET /trivia_items/new
  # GET /trivia_items/new.xml
  def new
    @trivia_item = Trivia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trivia_item }
    end
  end

  # GET /trivia_items/1/edit
  def edit
    @trivia_item = Trivia.find(params[:id])
  end

  # POST /trivia_items
  # POST /trivia_items.xml
  def create
    @trivia_item = Trivia.new(params[:trivia_item])

    respond_to do |format|
      if @trivia_item.save
        format.html { redirect_to(@trivia_item, :notice => 'Trivia item was successfully created.') }
        format.xml  { render :xml => @trivia_item, :status => :created, :location => @trivia_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trivia_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trivia_items/1
  # PUT /trivia_items/1.xml
  def update
    @trivia_item = Trivia.find(params[:id])

    respond_to do |format|
      if @trivia_item.update_attributes(params[:trivia_item])
        format.html { redirect_to(@trivia_item, :notice => 'Trivia item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trivia_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trivia_items/1
  # DELETE /trivia_items/1.xml
  def destroy
    @trivia_item = Trivia.find(params[:id])
    @trivia_item.destroy

    respond_to do |format|
      format.html { redirect_to(trivia_items_url) }
      format.xml  { head :ok }
    end
  end

  def ajaxsearch
    if(params[:city]=='false')
      @trivia_items = Trivia.select('DISTINCT trim(city) as city, state').where("state = ?", params[:state])
      @markers = '['
      @trivia_items.group_by(&:location_string).each do |location, trivia_items|
        trivia_items.each do |trivia_item|
          if(trivia_item.trivia_count>=1 && trivia_item.trivia_count <=2)
            marker_image = '/images/pin_3.png'
          elsif(trivia_item.trivia_count>2 && trivia_item.trivia_count<=5)
            marker_image = '/images/pin_2.png'
          else
            marker_image = '/images/pin_1.png'
          end
          @markers+="{\"address\":\""+trivia_item.city.tr("\"","\'")+" ,"+trivia_item.state+" ,"+trivia_item.country+"\", \"data\":{\"city\":\""+trivia_item.city.tr("\"","\'")+"\", \"state\":\""+trivia_item.state+"\", \"trivia\":\"#{trivia_item.trivia_count.to_s}\"}, \"options\":{\"icon\":\"#{marker_image}\"} }, "
        end
      end
      @markers += '{}]'
      render :partial=> "search_nearby"
    else
      @city = params[:city]
      @state = params[:state]
      @trivia_items = Trivia.where("city = ? AND state = ?",@city, @state)

      render :partial=> "ajaxsearch"
    end
  end

  def ajax_city_search
    if(params[:city].present?)
      @result = Trivia.city_search(params[:city]).order("city asc")

      render :partial=>"city_autofil"
    end
  end
end
