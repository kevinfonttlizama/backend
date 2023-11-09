class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, admin: 1 }


  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :customer
  end
end
