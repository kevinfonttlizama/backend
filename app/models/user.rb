class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Elimina la línea de enum y asegúrate de que tienes un campo 'role' en tu base de datos
  # enum role: { customer: 0, admin: 1 }

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= 'customer' # Aquí simplemente asignas un string
    puts(role)
  end
end
