class EnergyMeter < ApplicationRecord
    belongs_to :user

    def as_json(**options)
       super(options)
    end
end
