class PorkerController < ApplicationController
  include Common

  def new
  end


  def porkerhand

    # 入力された文字列から、スートの配列と数字の配列を作成
    @suits         = make_array_chara(params[:hand].split(" "))
    @numbers       = make_array_num(params[:hand].split(" "))

    # スートのペア数・数字のペア数・ストレート判定を作成
    @suits_pairs   = pairs_count(@suits)
    @numbers_pairs = pairs_count(@numbers)
    @straight      = straight?(@numbers)

    # ポーカーの手役を出力
    @hand          = handscheck(@suits_pairs, @numbers_pairs, @straight)[0]

  end


end

