class Website < ActiveRecord::Base
	validates_presence_of :original_url
	validates_uniqueness_of :original_url

	belongs_to :user
end
