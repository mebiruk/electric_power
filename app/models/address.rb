class Address < ApplicationRecord
    validates_uniqueness_of :house_number
    validates_presence_of :region,:zone,:house_number,:woreda,:kebele,:block_number

    def as_json(**options)
       super(options)
    end
end
