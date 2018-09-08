class FootTrafficFile
  @@delimiter = " "
  @@line_map = [:visitor_identifier, :room_index, :visitor_status, :event_time_stamp]
  
  def initialize(options={})
    return if options[:filepath].nil?
    @filepath = File.join(APP_ROOT,options[:filepath])
  end

  def file_usable?
    return false unless @filepath
    return false unless File.exists?(@filepath)
    return false unless File.readable?(@filepath)
    return true
  end

  def fetch_foot_traffics
    foot_traffics = []
    if file_usable?
      file = File.new(@filepath, 'r')

      ## removes the first line entry which contains number of foot traffic records
      file.gets.chomp.to_i

      file.each_line do |line|
        foot_traffics << import_foot_traffic(line) unless line.chomp.empty?
      end
      file.close
    end
    return foot_traffics
  end
  
  private

    def import_foot_traffic(line)
      line_array = line.chomp.split(@@delimiter)
      attributes = Hash[@@line_map.zip(line_array)]
      return FootTraffic.new(attributes)
    end
end