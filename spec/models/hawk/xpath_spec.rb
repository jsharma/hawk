require 'spec_helper'

describe Hawk::Xpath do

  describe 'associations' do
    it { should belong_to :hawker }
  end

  it "can be instantiated" do
    Hawk::Xpath.new.should be_an_instance_of(Hawk::Xpath)
  end

  describe "validations" do
    it { should validate_presence_of(:xpath) }
    it { should validate_presence_of(:targate_name) }
  end

  describe "xpath_without_tbody" do
    xpath = Hawk::Xpath.new(xpath: "/html/body/center/table/tbody/tr[2]/td/table/tbody/tr/td/table/tbody/tr[2]/td[2]/table/tbody/tr[2]/td[2]/table/tbody/tr[4]/td/div/table/tbody/tr/td/div[9]/span/a")
    it "should return xpath wothout tbody/" do
      xpath.xpath_without_tbody.should_not include("tbody/")
    end  
  end
end