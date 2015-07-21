require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  #空の値のチェック
  test "presence" do
    article = Article.new
    assert article.invalid?
    assert article.errors.include?(:title)
    assert article.errors.include?(:body)
    assert article.errors.include?(:release_at)
  end
    #長さのチェック
  test "length" do
    article = FactoryGirl.build(:article)
    article.title = "A" * 201
    assert article.invalid?
    assert article.errors.include?(:title)
  end
  #掲載終了日時は掲載開始日時より後
  test "expire_at" do
    article = FactoryGirl.build(:article)
    article.release_at = Time.current
    article.expire_at = 1.days.ago # 掲載終了日時にわざと、掲載開始日時よりまえの日付を入れている
    assert article.invalid?
    assert article.errors.include?(:expire_at)
  end
  #no_expirationがオンならexpire_atは使わない
  test "no_expiration" do
    article = FactoryGirl.build(:article)
    article.no_expiration = true
    assert article.valid?
    assert_nil article.expire_at
  end

  test "open" do
  article1 = FactoryGirl.create(:article, title: "現在",
    release_at: 1.day.ago, expire_at: 1.day.from_now)
  article2 = FactoryGirl.create(:article, title: "過去",
    release_at: 2.days.ago, expire_at: 1.day.ago)
  article3 = FactoryGirl.create(:article, title: "未来",
    release_at: 1.day.from_now, expire_at: 2.days.from_now)
  article4 = FactoryGirl.create(:article, title: "終了日なし",
    release_at: 1.day.ago, expire_at: nil)
=begin
  test "open" do
    article1 = FactoryGirl.create(:article,title:"現在",release_at: 1.day.ago, expire_at: 1.day.from_now)
    article2 = FactoryGirl.create(:article,title:"過去",release_at: 2.days.ago, expire_at:1.day.ago)
    article3 = FactoryGirl.create(:article,title:"未来",release_at: 1.day.from_now, expire_at:2.days.from_now)
    article4 = FactoryGirl.create(:article,title:"終了日無し",release_at: 1.day.ago, expire_at:nil)
=end
    articles = Article.open
    assert_includes articles, article1, "現在の記事が含まれる"
    refute_includes articles, article2, "過去の記事は含まれない"
    refute_includes articles, article3, "未来の記事は含まれない"
    assert_includes articles, article4, "expireがnilの場合"
  end
end
