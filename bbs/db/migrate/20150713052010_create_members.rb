class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :number,null:false #背番号　null:falseは、カラムにNotNULLオプションをつけている。これは空の値が保存されないよにするための処理
      t.string :name,null:false #ユーザーネーム
      t.string :full_name #本名
      t.string :email #メールアドレス
      t.date :birthday #誕生日
      t.integer :gender,null:false,default:0 #性別 (0:男,1:女) NotNULLオプションをつけた上でデフォルト値を1にする。
      t.boolean :administrator,null:false,default:false #管理者フラグ
      t.timestamps null: false
    end
  end
end
