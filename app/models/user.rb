class User < ApplicationRecord
  require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :lockable, :timeoutable
         # confirmable

  # Validates name
  validates :full_name,  presence: true, length: { within: 2..80 }
  validates :short_name, presence: true, length: { within: 2..80 }

  # Has Offspring
  has_many :offsprings, dependent: :destroy

  def self.to_csv
    attributes = %w[id full_name short_name email]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.instance_eval(attr) }
      end
    end
  end
end
