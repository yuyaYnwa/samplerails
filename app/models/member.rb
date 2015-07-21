class Member < ActiveRecord::Base
  #emailアドレスのValidationファイル
  #include EmailAddressChecker
  include EmailAddressChecker

  #空文字禁止、1以上100未満の整数、会員間の重複禁止
  validates :number,presence:true,
  numericality:{
    only_integer:true,
    greater_than:0,less_than:100,allow_blank:true},
    uniqueness:true

  #ユーザー名は空文字禁止、1以上100未満、会員の間で重複禁止
  validates :name,presence:true,
  format:{with:/\A[A-Za-z]\w*\z/,allow_blank:true},
  length:{minimum:2,maximum:20,allow_blank:true},
  uniqueness:{case_sensitive: false}
  #氏名は20文字以下、空文字あり
  validates :full_name,length:{maximum:20}
  attr_accessor :password, :password_confirmation

  def password=(val)
    if val.present?
      #パスワードが暗号化され、hasshed_password属性に入る
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  validate :check_email
  validates :password,presence:{on: :create},confirmation:{allow_blank: true}

  private
  def check_email
    if email.present?
      errors.add(:email,:invalid)unless well_formed_as_email_address(email)
    end
  end

  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?","%#{query}%","%#{query}%")
      end
      return rel
    end
  end
end
