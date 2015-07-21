class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false #タイトル
      t.string :body, null: false #本文
      t.datetime :release_at, null: false #掲載開始日時(その日時になるまで、サイトに記事を掲載しない)
      t.datetime :expire_at           #掲載終了日時（その日時を過ぎたら、サイトに記事を掲載しない。掲載終了日時はnullでもOK）
      t.boolean :member_only, null: false #会員のみフラグ（ログイン機能実装時に使用）

      t.timestamps null: false
    end
  end
end
