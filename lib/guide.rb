require 'foot_traffic'

class Guide
  def initialize(path=nil)
    FootTraffic.load_file(path)
  end

  def launch!
    introduction

    ## foot traffic logic goes here
    foot_traffics = FootTraffic.file.fetch_foot_traffics
    rooms = rooms_available(foot_traffics)
    average_time_spent_by_visitors_in_each_room(rooms, foot_traffics)

		conclusion
  end

  private
  
    def introduction
      puts "\n<<< Welcome to the Food Traffic Analysis >>>\n\n"
      puts "Please find below the average time spent by visitors in each room.\n\n"
    end

    def conclusion
      puts "\n<<< Goodbye >>>\n\n"
    end

    ## searches for rooms available and sorts it in ascending order
    def rooms_available(foot_traffics)
      rooms = []
      rooms = foot_traffics.each_with_object([]){|item,rooms| rooms << item.room_index.to_i}.uniq.sort
    end

    ## calulates the average time spent in each room by visitors
    def average_time_spent_by_visitors_in_each_room(rooms, foot_traffics)
      rooms.each do |room_number|
        time_spent = 0
        #evaluates entry records in the room
        room_entry_records = entry_records_in_room(room_number, foot_traffics)
        #evaluates outgoing records in the room
        room_outgoing_records = outgoing_records_in_room(room_number, foot_traffics)
        #evaluates the time spent in each room by visitor(s)
        room_outgoing_records.each do |room_outgoing_record|
          room_entry_record = room_entry_records.select{|e| e.visitor_identifier == room_outgoing_record.visitor_identifier && e.room_index == room_outgoing_record.room_index && e.visitor_status == "I"}.first
          time_spent += room_outgoing_record.event_time_stamp.to_i - room_entry_record.event_time_stamp.to_i + 1
        end
        puts "Room #{room_number}, #{time_spent/room_outgoing_records.count} minute average visit, #{room_outgoing_records.count} visitors total" if room_outgoing_records.count > 1
        puts "Room #{room_number}, #{time_spent/room_outgoing_records.count} minute average visit, #{room_outgoing_records.count} visitor total" if room_outgoing_records.count == 1            
      end
    end

    ## calculates entry records in the room
    def entry_records_in_room(room_number, foot_traffics)
      foot_traffics.each_with_object([]){|item,room_entry_record| room_entry_record << item if item.room_index.to_i == room_number && item.visitor_status == "I"}
    end     

    ## calculates outgoing records in the room
    def outgoing_records_in_room(room_number, foot_traffics)
      foot_traffics.each_with_object([]){|item,room_outgoing_record| room_outgoing_record << item if item.room_index.to_i == room_number && item.visitor_status == "O"}
    end
end