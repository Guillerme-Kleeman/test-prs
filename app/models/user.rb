class User < ApplicationRecord
  # Valida que el atributo `name` esté presente y tenga una longitud entre 2 y 50 caracteres.
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  # Valida que la fecha de nacimiento (`birthdate`) no sea una fecha futura.
  validate :birthdate_cannot_be_in_the_future

  # Callback que se ejecuta antes de guardar el registro, calcula la edad del usuario.
  before_save :calculate_age

  # Callback que se ejecuta antes de crear un nuevo registro, establece el valor predeterminado de `verified`.
  before_create :set_default_verified

  # Callback que se ejecuta antes de actualizar un registro existente, establece el valor predeterminado de `verified`.
  before_update :set_default_verified

  # Callback que se ejecuta antes de eliminar un registro, establece el valor predeterminado de `verified`.
  before_destroy :set_default_verified

  # Callback que se ejecuta antes de validar el registro, establece el valor predeterminado de `verified`.
  before_validation :set_default_verified

  # Callback que se ejecuta después de crear un nuevo registro, establece el valor predeterminado de `verified`.
  after_create :set_default_verified

  # Callback que se ejecuta después de actualizar un registro existente, establece el valor predeterminado de `verified`.
  after_update :set_default_verified

  # Callback que se ejecuta después de eliminar un registro, establece el valor predeterminado de `verified`.
  after_destroy :set_default_verified

  # Callback que se ejecuta después de validar el registro, establece el valor predeterminado de `verified`.
  after_validation :set_default_verified

  # Método para calcular la edad del usuario basado en su fecha de nacimiento (`birthdate`).
  def calculate_age
    if birthdate.present? # Verifica si la fecha de nacimiento está presente.
      self.age = Date.today.year - birthdate.year # Calcula la edad en años.
      self.age -= 1 if Date.today < birthdate + age.years # Ajusta la edad si el cumpleaños aún no ha ocurrido este año.
    end
  end

  # Método de validación para asegurarse de que la fecha de nacimiento no sea futura.
  def birthdate_cannot_be_in_the_future
    if birthdate.present? && birthdate > Date.today # Verifica si la fecha de nacimiento es futura.
      errors.add(:base, "can't be in the future") # Agrega un error al modelo si la validación falla.
    end
  end
end
