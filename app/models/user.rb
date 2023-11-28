class User < ApplicationRecord

    has_many :bills

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :category, presence: true
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
