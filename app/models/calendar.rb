class Calendar < ApplicationRecord
  belongs_to :user

  enum sex_type: { unknown: 0, contraception: 1, to_go_out: 2, to_go_in: 3 }
  enum feel_type: { fine: 0, like: 1, soso: 2, bad: 3 }
  
end
