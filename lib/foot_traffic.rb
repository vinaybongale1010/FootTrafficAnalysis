require 'foot_traffic_file'

class FootTraffic
  attr_reader :visitor_identifier, :room_index, :visitor_status, :event_time_stamp

  @@file = nil
  def self.file
    @@file
  end

  def self.load_file(filepath)
    # locate the foot traffic text file at path
    @@file = FootTrafficFile.new(:filepath => filepath)
    if @@file.file_usable?
      puts "\nFound foot traffic Log file."
    ## exit if file not found
    else
      puts "\nFoot traffic Log file not found or is not accessible!!." 
      puts "Please create a foot traffic text file 'sample_input.txt' with required data inside the projects root directory!!.\n\n"
      exit!
    end
    @@file
  end

  def initialize(options={})
    @visitor_identifier = options[:visitor_identifier]
    @room_index = options[:room_index]
    @visitor_status = options[:visitor_status]
    @event_time_stamp = options[:event_time_stamp]
  end
end