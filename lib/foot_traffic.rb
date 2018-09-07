class FootTraffic

  attr_reader :visitor_identifier, :room_index, :visitor_status, :event_time_stamp

  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end
  
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return true
  end

  def self.fetch_foot_traffics
    number_of_foot_traffics = nil
    foot_traffics = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      number_of_foot_traffics = file.gets.chomp
      file.each_line do |line|
        foot_traffics << FootTraffic.new.import_line(line.chomp)
      end
      file.close
    end
    return foot_traffics, number_of_foot_traffics
  end

  ## searches for rooms available and sorts it in ascending order
  def self.rooms_available(foot_traffics)
    rooms = []
    rooms = foot_traffics.each_with_object([]){|item,rooms| rooms << item.room_index.to_i}.uniq.sort
    rooms
  end

  ## calulates the average time spent in each room by visitors
  def self.average_time_spent_by_visitors_in_each_room(rooms, foot_traffics)
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
  def self.entry_records_in_room(room_number, foot_traffics)
    foot_traffics.each_with_object([]){|item,room_entry_record| room_entry_record << item if item.room_index.to_i == room_number && item.visitor_status == "I"}
  end     

  ## calculates outgoing records in the room
  def self.outgoing_records_in_room(room_number, foot_traffics)
    foot_traffics.each_with_object([]){|item,room_outgoing_record| room_outgoing_record << item if item.room_index.to_i == room_number && item.visitor_status == "O"}
  end
  
  def import_line(line)
    line_array = line.split(" ")
    @visitor_identifier, @room_index, @visitor_status, @event_time_stamp = line_array unless line_array.empty?
    return self
  end

end