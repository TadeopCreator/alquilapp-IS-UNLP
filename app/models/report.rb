class Report < ApplicationRecord
    include ImageUploader::Attachment(:image)
end
