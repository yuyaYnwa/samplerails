class LessonController < ApplicationController
  #オプションとしてonlyを指定すると、そのアクションが呼ばれたときだけ、実行されるようになる。
  # 複数指定したいときは、配列を指定する。only: [:step7,:step6]
  before_action :set_message, only: :step7
  #逆に特定のアクションに対してコールバックが実行されないようにするにはexceptを使用
  #before_action :do_something, except[:step7]

  def step1
    #render text:文字列は、テンプレートファイルを使わずに直接文字列を送信する方法
    render text: "こんにちは、#{params[:name]}さん"
  end

  def step2
    render text: params[:controller] + "#" + params[:action]
  end

  def step3
    #redirect_toメソッドを呼び出すと、レンダリングされずブラウザにステータスコード302と新しいURLが送られる。
    redirect_to action: "step4"
  end

  def step4
    render text: "step4に移動しました！"
  end

  def step5
    #flashオブジェクトを使う事で、リダイレクション後にその値を取り出す事ができる
    flash[:notice] = "step6に移動しました！"
    redirect_to action: "step6"
  end

  def step6
    render text:flash[:notice]
  end

  def step7
    render text: @message
  end

  def step8
    #render text: "step8です！"
    @price = (2000 * 1.08).floor
  end

  def step9
    @price2 = 800
    #app/views/lesson以外のテンプレートを使いたい場合は、app/viesフォルダを起点としたパス名を指定する
    render "step8"
  end

  def step10
    @comment = "<strong>安全なhtml</strong>"
    render "top/index"
  end

  def step11
    @population = 7011234
    @surface = 141.3
  end

  def step12
    @time = Time.now
  end

  def step18
    @stock = 10
    render "step16"
  end

  def step19
    @items = {フライパン: 2680,ワイングラス: 2550,ペッパーミント: 4515,ピーラー:945}
  end

  private
  def set_message
    @message = "こんにちは"
  end
end
