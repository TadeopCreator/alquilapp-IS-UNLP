class Billetera < ApplicationRecord
    has_many :tarjetums
    belongs_to :usuario
end
