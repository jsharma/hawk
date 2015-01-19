module Hawk
  class Xpath < ActiveRecord::Base
    belongs_to :hawker, :class_name=> "Hawk::Hawker"
    validates :xpath, :presence => true
    validates :targate_name, :presence => true, :uniqueness => {:scope => :hawker_id}

    def xpath_without_tbody
      self.xpath.gsub('tbody/','')
    end

  end
end