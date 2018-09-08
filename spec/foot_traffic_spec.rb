require 'foot_traffic'

describe FootTraffic do
	let(:testfile) { 'spec/fixtures/sample_input_test.txt' }
	let(:foot_traffic) { FootTraffic.new(visitor_identifier: 1, room_index: 2, visitor_status: 'I', event_time_stamp: 567) }

	describe 'attributes' do
		it "allow reading for :visiter_identifier" do
      expect(subject).to receive(:visitor_identifier)
      subject.visitor_identifier
    end

    it "allow reading for :room_index" do
      expect(subject).to receive(:room_index)
      subject.room_index
    end

    it "allow reading for :visitor_status" do
      expect(subject).to receive(:visitor_status)
      subject.visitor_status
    end

    it "allow reading for :event_time_stamp" do
      expect(subject).to receive(:event_time_stamp)
      subject.event_time_stamp
    end    
	end	

	describe '.file' do
		it "should return an instance of FootTrafficFile" do
			FootTraffic.load_file(testfile)
			expect(FootTraffic.file).to be_instance_of(FootTrafficFile)
		end
	end

	describe '#initialize' do
    it 'sets the visitor_identifier attribute to 1' do
      expect(foot_traffic.visitor_identifier).to eq(1)
    end

    it 'sets the room_index attribute to 2' do
      expect(foot_traffic.room_index).to eq(2)
    end

    it 'sets the visitor status attribute to I' do
      expect(foot_traffic.visitor_status).to eq('I')
    end

    it 'sets the event_time_stamp attribute to 567' do
    	expect(foot_traffic.event_time_stamp).to eq(567)
    end
  end 
end