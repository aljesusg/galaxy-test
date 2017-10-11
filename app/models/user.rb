class User < ApplicationRecord
  require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Validates name
  validates :first_name, presence: true, length: { within: 2..80 }
  validates :last_name,  presence: true, length: { within: 2..80 }
  # Validates phone number
  VALID_TELEPHONE_REGEX = /\A(\+\d\d|00\d\d)?\d{9}\z/
  validates :phone, presence: true, length: { within: 9..13}
  validates :phone, format: { with: VALID_TELEPHONE_REGEX}
  # Has Offspring
  has_many :offsprings, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

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
