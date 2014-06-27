class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: { minimum:5}

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def method1
		puts 'this is method 1'
	end

	def self.method1
		puts 'this is class method'
	end
end