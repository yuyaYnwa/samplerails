class MembersController < ApplicationController
  #会員一覧
  def index
    @members = Member.order("number")
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new(birthday: Date.new(1987,1,1))
  end

  def edit
    @member = Member.find(params[:id])
  end

  def create

  end

  def update

  end

  def destory

  end

  def search
    #パラメーターのqに検索ワードが入って来る
    @members = Member.search(params[:q])
    render "index"
  end

end
