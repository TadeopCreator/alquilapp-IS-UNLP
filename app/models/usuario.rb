class Usuario < ApplicationRecord
    include ImageUploader::Attachment(:image)
    validate :menor, :expirada

    def menor      
        if (birthdate.year > 18.years.ago.year)
            errors.add(:birthdate, "Es menor de edad")            
        end
    end

    def expirada
        puts("asjkldfhasdjkfhkasdjhfjkasdhfasdkfhkajksdfsa: ", 0.years.ago.year)        
        if (date_licence.year < 0.years.ago.year)
            errors.add(:date_licence, "Expiro licencia")      
        end
    end
end
