class Calendar < ApplicationRecord
  belongs_to :user

  enum sex_type: { contraception: 0, to_go_out: 1, to_go_in: 2 }
  enum feel_type: { fine: 0, like: 1, soso: 2, bad: 3 }
  enum condition_type: { very_lot: 0, lot: 1, few: 2, very_few: 3 }



end
