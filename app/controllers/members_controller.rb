class MembersController < ApplicationController
  #会員一覧
  def index
    @members = Member.order("number")
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    #Member.newで新しいオブジェクを作成する。引数は初期値
    @member = Member.new(birthday: Date.new(1987,1,1))
  end

  def edit
    #findメソッドでIDを渡してモデルオブジェクトを取り出す
    @member = Member.find(params[:id])
  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to @member,notice:"会員登録しました！"
    else
      render "new"
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(params[:member])
    if @member.save
      redirect_to @member ,notice: "会員情報を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :members,notice: "会員情報を削除しました"
  end

  def search
    #パラメーターのqに検索ワードが入って来る
    @members = Member.search(params[:q])
    render "index"
  end

end
