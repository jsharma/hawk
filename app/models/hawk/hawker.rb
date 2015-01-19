require "net/http"

module Hawk
  class Hawker < ActiveRecord::Base
    has_many :xpaths, :class_name=>"Hawk::Xpath"
    validates :url, :presence=> true

    scope :rev_order_by_created, order("created_at DESC")

    def valid?(url)
      begin
        uri = URI.parse(self.url)
        res = Net::HTTP.get_response(uri)
        return true if (res.is_a?(Net::HTTPSuccess))
      rescue Exception => e
        Rails.logger.info "Error URL: #{e}"
      end
      errors.add(:url, "is not valid")
      false
    end

    def create_update_xpath(data_params)
      return true if data_params.blank?
      Hawk::Hawker.transaction do
        data_params.each do |key,value|

          if key.to_i.zero?
            Xpath.create!(targate_name: value[:name], xpath: value[:xpath],hawker_id: self.id)
          else
            xpath = Xpath.where(id: key).first
            xpath.update_attributes!(targate_name: value[:name], xpath: value[:xpath],hawker_id: self.id)
          end
        end
        return true
      end
      rescue
        return false
    end

  end
end
