class Assignment < ApplicationRecord
  i18n_scope = 'activerecord.errors.models.assignment.attributes'.freeze
  belongs_to :offspring
  belongs_to :shift
  validates :offspring, presence: true, uniqueness: true
  validates :shift,     presence: true

  validates_each :shift do |assignment|
    assignment.errors.add(:shift, I18n.t('shift.no_sites_available', scope: i18n_scope)) unless assignment.shift&.sites_available?
  end

  def full_name
    @full_name ||= shift.full_name
  end
end
