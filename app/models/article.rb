class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: { minimum:5}

	def method1
		puts 'this is method 1'
	end

	def self.method1
		puts 'this is class method'
	end
end