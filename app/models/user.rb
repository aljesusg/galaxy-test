class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable, :omniauth_providers => [:github]
         # confirmable

  # Validates name
  validates :full_name,  presence: true, length: { within: 2..80 }
  validates :short_name, presence: true, length: { within: 2..80 }

  # Has Offspring
  has_many :git_hub_repos, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.short_name = auth.info.nickname
      user.github_user = auth.uid
      user.github_avatar = auth.info.image
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
