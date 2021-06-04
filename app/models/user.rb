class User < ApplicationRecord
  has_secure_password
  belongs_to :address
  belongs_to :role_type
  has_many :energy_meter
  validates_uniqueness_of :username
  def as_json(**options)
    super(options)
  end
end
