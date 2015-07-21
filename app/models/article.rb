class Article < ActiveRecord::Base
  validates :title,:body,:release_at,presence: true
  validates :title,length:{maximum:200}
  validate :check_expire_at
  before_validation :clear_expire_at

  scope :open, -> {
    now = Time.current
    where("release_at <= ? AND (? < expire_at OR " + "expire_at IS NULL)",now,now)
  }

  def no_expiration
    expire_at.blank?
  end

  #expire_atの有無によってfalseかtrueを返す。
  #符号付のno_expiration=メソッドは、引数がtrue,1,文字列の「１」のどれかなら変数@no_expirationをtrueに、そうでなければfalseを返す
  def no_expiration=(val)
    @no_expiration = val.in?([true,1,"1"])
  end

  private
  def check_expire_at
    #終了日時がnilではなく、かつ掲載開始日より古かったらエラーを追加する
    if expire_at && expire_at < release_at
      errors.add(:expire_at,:expire_at_too_old)
    end
  end

  def clear_expire_at
    #no_expirationがあれば、expire_atをnilにする
    self.expire_at = nil if @no_expiration
  end
  class << self
    def sidebar_articles(num = 5)
      open.order(release_at: :desc).limit(num)
    end
  end

end
