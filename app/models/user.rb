class User < ApplicationRecord
  require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Validates name
  validates :full_name,  presence: true, length: { within: 2..80 }
  validates :sort_name,  presence: true, length: { within: 2..80 }

  # Has Offspring
  has_many :offsprings, dependent: :destroy

  def self.to_csv
    attributes = %w[id first_name last_name phone email]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.instance_eval(attr) }
      end
    end
  end
end
