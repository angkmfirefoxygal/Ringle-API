class Tutor < ApplicationRecord
    has_many :availabilities
    has_many :enrollments
end
