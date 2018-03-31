class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :product
    
    validates :product_id,presence:true
    validates :description, presence: false
    validates :rating, numericality: { only_integer:true, greater_than_or_equal_to:0, less_than_or_equal_to:5 }
end
