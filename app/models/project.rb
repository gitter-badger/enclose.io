class Project < ApplicationRecord
  belongs_to :user
  has_many :packages

  enum source: [:github, :npm]
  
  validates_presence_of :name
end
