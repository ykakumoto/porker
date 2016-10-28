class PorkerController < ApplicationController
  include Common


  def new
  end


  def porkerhand

    hand = params[:hand]
    if hand =~ /^([DHCS]([1-9]|1[0-3]) ){4}[DHCS]([1-9]$|1[0-3]$)/

      # 入力された文字列から、スートの配列と数字の配列を作成
      suits         = make_array_chara(hand.split(" "))
      numbers       = make_array_num(hand.split(" "))

      # スートのペア数・数字のペア数・ストレート判定を作成
      suits_pairs   = pairs_count(suits)
      numbers_pairs = pairs_count(numbers)
      straight      = straight?(numbers)

      # ポーカーの手役を出力
      @hand         = handscheck(suits_pairs, numbers_pairs, straight)[0]

    else
      @hand = nil
      render :status => 400

    end


  end
end
