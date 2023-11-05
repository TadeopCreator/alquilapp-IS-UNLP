class Message < ApplicationRecord
    include ImageUploader::Attachment(:image)
end
