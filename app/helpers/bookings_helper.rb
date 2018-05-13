module BookingsHelper
  
  def booking_fields 
    # fields to be displayed on front-end view
    [:id, :user_firstname, :user_lastname, :user_email, :user_phone, :user_phone, :car_make,
     :car_id, :car_model, :car_year, :car_size, :car_price, :pickup, :return] 
  end
  
  def field_text(field)
    translation = {:id=>"Index", :user_firstname=>"User First Name", :user_lastname=>"User Last Name", :user_email=>"User Email", :pickup=>"Pick up time", 
     :user_phone=>"User Phone", :car_make=>"Car Make", :car_model=>"Car Model", :car_year=>"Car Year", :car_size=>"Car Size", :car_price=>"Car Price", 
     :return=>"Return time", :user_id=>"User", :car_id=>"Car", :Status=>"Status"}
    translation[field]
  end
    
  def action 
    action_name == 'advanced_search' ? :post : :get 
  end
  
  def display_booking_sorted_column_headers(search) 
    booking_fields.each_with_object('') do |field, string| 
      string << content_tag(:th, sort_link(search, field_text(field), {}, method: action), class: 'thead-default') 
    end 
  end
  
  def display_booking_search_results(objects) 
    objects.each_with_object('') do |object, string| 
      string << content_tag(:tr, display_booking_search_results_row(object)) 
    end 
  end
  
  def display_booking_search_results_row(object)
    fieldCount = 0
    display = ""
    booking_fields.each_with_object(display) do |field, string|
      if fieldCount == 0
        string << content_tag(:td, link_to("#"+object.send(field).to_s, '/bookings/' + object.id.to_s))
      elsif field == :user_id
        uid = object.send(field)
        user = User.find_by_id(uid)
        uname = user.name
        string << content_tag(:td, link_to("#{uid} - #{uname}", user) )
      elsif field == :car_id
        cid = object.send(field)
        car = Car.find(cid)
        carid = car.id
        string << content_tag(:td, link_to("#{carid}", car))
      else
        string << content_tag(:td, object.send(field))
      end
      
      fieldCount += 1
      
    end
    display << content_tag(:td, link_to("show", '/bookings/' + object.id.to_s))
    display.html_safe
  end
  
end