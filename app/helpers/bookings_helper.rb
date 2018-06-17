module BookingsHelper

  def booking_fields
    # fields to be displayed on front-end view
    [:checkOut, :pickup, :expectedReturn, :returnT, :car_id, :status]
  end

  def field_text(field)
    translation = {:id=>"Booking", :checkOut=>"Check out time", :expectedReturn=>"Expected Return",
    :pickup=>"Pick up time",:returnT=>"Return time", :user_id=>"User", :car_id=>"Car", :status=>"Status"}
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
    rowCount = 0
    objects = objects.reverse
    objects.each_with_object('') do |object, string|
      rowCount += 1
      string << content_tag(:tr, display_booking_search_results_row(object))
    end
  end

  def display_booking_search_results_row(object)

    display = ""
    booking_fields.each_with_object(display) do |field, string|
      if field == :id
        string << content_tag(:td, link_to("#"+(rowCount).to_s, '/bookings/' + object.id.to_s))
      elsif field == :returnT
        if object.send(field).nil?
           string << content_tag(:td, "Awaiting return")
        else
          string << content_tag(:td, object.send(field))
        end
      elsif field == :pickup
        if object.send(field).nil?
           string << content_tag(:td, "Awaiting pickup")
        else
          string << content_tag(:td, object.send(field))
        end
      elsif field == :car_id
        cid = object.send(field)
        car = Car.find(cid)
        carid = car.make
        string << content_tag(:td, link_to("#{carid}", car))
      else
        string << content_tag(:td, object.send(field))
      end



    end
    display << content_tag(:td, link_to("View", '/bookings/' + object.id.to_s))
    display.html_safe
  end

  def display_booking_search_results_past(objects)
    rowCount = 0
    objects = objects.reverse
    objects.each_with_object('') do |object, string|
      if object.status == "Complete"
        rowCount += 1
        string << content_tag(:tr, display_booking_search_results_row(object))
        return string if rowCount == 8
      end
    end
  end

  def display_booking_search_results_current(objects)
    rowCount = 0
    objects.each_with_object('') do |object, string|
      if !(object.status == "Complete")
        rowCount += 1
        string << content_tag(:tr, display_booking_search_results_row(object))

      end

    end
  end

  def current_bookings(objects)
    rowCount = 0
    objects.each_with_object('') do |object|
      if !(object.status == "Complete")
        rowCount += 1
      end
    end
    if rowCount != 0
      return true
    else
      return false
    end
  end


end
