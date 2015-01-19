require 'spec_helper'

describe Hawk::Hawker do

  describe 'associations' do
    it { should have_many :xpaths }
  end

  it "can be instantiated" do
    Hawk::Hawker.new.should be_an_instance_of(Hawk::Hawker)
  end

  describe "validations" do
    # it { should validate_presence_of(:url) }
  end

  describe "create_update_xpath" do
    hawker = Hawk::Hawker.create!(url: "http://www.aircargocommunities.com/fsc.php")
    context "with blank data hash" do
      data_hash = {}
      it "should return true" do
        hawker.create_update_xpath(data_hash).should be_true 
      end
    end

    context "with blank xpath" do 
      let(:data_hash) { {"new" => {xpath: "", name: "http://www.aircargocommunities.com/fsc.php"}} }
      it "Should not create xpath" do
        expect {
          hawker.create_update_xpath(data_hash)
        }.to change(Hawk::Xpath, :count).by(0) 
      end
      it "should return false" do
        hawker.create_update_xpath(data_hash).should be_false
      end  
    end

    context "with valid xpath and name" do 
      let(:data_hash) { {"new" => {xpath: "test", name: "aaatest"}} }
      it "Should create new xpath" do
        expect {
          hawker.create_update_xpath(data_hash)
        }.to change(Hawk::Xpath, :count).by(1) 
      end

      it "should return true" do
        hawker.create_update_xpath(data_hash).should be_true
      end  

      it "should update xpath" do
        xpath_obj = Hawk::Xpath.create(hawker_id: hawker.id, xpath: "test_old", targate_name: "name_old")
        hawker.create_update_xpath({xpath_obj.id.to_s => {xpath: "test_new", name: "name_new"} })
        xpath_obj.reload

        xpath_obj.xpath.should eq "test_new"
        xpath_obj.targate_name.should eq "name_new"

        expect {
          hawker.create_update_xpath(data_hash)
        }.to change(Hawk::Xpath, :count).by(1) 
      end
    end
  end
end