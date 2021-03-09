class Doctor < ApplicationRecord
   
    
    has_many :appointments

    has_many :doctor_categories
    has_many :categories, through: :doctor_categories

    has_many :doctor_appointments
    has_many :appointments, through: :doctor_appointments

    validates :number, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }
    validates :name, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }
    has_secure_password

   

    def stock_already_tracked?(app)
        stock = Stock.check_db(app)
        return false unless stock
        appointments.where(stock_id: stock.id)
    end

    def under_appointment_limit?
       appointments.count > 2 
    end

    def recomend?
     appointments.where(stock_id: nil) 
    end

    def can_track_stock?(app)
        under_appointment_limit? && !stock_already_tracked?(app)
    end
end
