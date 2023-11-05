class Auto < ApplicationRecord
    validates :num_rel, uniqueness: true
    validates :patente, uniqueness: true
end
