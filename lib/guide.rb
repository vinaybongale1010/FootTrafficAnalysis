require 'foot_traffic'
class Guide
  def initialize(path=nil)
    # locate the foot traffic text file at path
    FootTraffic.filepath = path
    if FootTraffic.file_usable?
      puts "\nFound foot traffic file."
    # exit if file not found
    else
      puts "\nFoot traffic Log file not found!!." 
      puts "Please create a foot traffic text file 'sample_input.txt' with required data inside the projects root directory!!.\n\n"
      exit!
    end
  end

  def launch!
    introduction
    # foot traffic logic goes here
		conclusion
  end
  
  
  def introduction
    puts "\n\n<<< Welcome to the Food Traffic Analysis >>>\n"
  end

	def conclusion
  	puts "\n<<< Goodbye >>>\n\n"
	end 
end