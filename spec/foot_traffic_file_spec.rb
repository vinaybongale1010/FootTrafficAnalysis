require 'foot_traffic_file'

describe FootTrafficFile do
  let(:test_file) { 'spec/fixtures/sample_input_test.txt' }
  let(:valid_file) { FootTrafficFile.new(:filepath => test_file) }
  
  let(:new_file)  { 'spec/fixtures/new_restaurants_test.txt' }
  let(:blank_file) { FootTrafficFile.new(:filepath => new_file) }

  describe '#initialize' do
    it "returns an instance of FootTrafficFile class" do
      expect(subject).to be_an_instance_of(FootTrafficFile)
    end
  end

  describe '#file_usable?' do    
    it 'returns true when @filepath is existing/readable/writable' do
      expect(valid_file.file_usable?).to be true
    end

    it 'returns false when @filepath is nil' do
      expect(subject.file_usable?).to be false
    end  

    it 'returns false when file doesnot exist in the @filepath' do
      expect(blank_file.file_usable?).to be false
    end
  end
  
  describe '#fetch_foot_traffics' do
    it 'returns an array of foot traffic objects' do
      foot_traffics = valid_file.fetch_foot_traffics
      expect(foot_traffics.class).to eq(Array)
      expect(foot_traffics.length).to eq(4)
      expect(foot_traffics.first.class).to eq(FootTraffic)
    end

    it 'returns an empty array if file is empty' do
      expect(blank_file.fetch_foot_traffics).to eq([])
    end
  end
end