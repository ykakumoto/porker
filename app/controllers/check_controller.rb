class CheckController < ApplicationController
  def new
  end

  def make_array_chara(input)
    # 入力された配列から、文字のみの配列を作成
    @chara = []
    input.each do |input|
      @chara << /\D*/.match(input)
    end

    return @chara

  end


  def make_array_num(input)
    # 入力された配列から、数字のみの配列を作成
    @num = []
    input.each do |input|
      @num << /\d+/.match(input)
    end

    return @num

  end


  def pairs_count(input)
    # 入力された配列のペア数をカウント
    @i   = 0
    @u   = 0
    @sum = 0
    for @i in 0..3 do
      for @u in @i+1..4 do
        @sum += 1 if (input[@i] == input[@u])
      end
      return @sum
    end
  end

  # def straight?(numbers)
  #   # 入力された配列がストレートになっているかを確認
  #   if (numbers.max - numbers.min == 4 && pairs_count(numbers) == 0)
  #     # ||
  #     # (numbers.sort == [1, 10, 11, 12, 13])
  #   then
  #     return true
  #     　
  #   else
  #     return false
  #
  #   end
  #
  # end


  def handcheck

    @suits   = make_array_chara(params[:hand].split(" "))
    @numbers = make_array_num(params[:hand].split(" "))

    @suits_pairs   = pairs_count(@suits)
    @numbers_pairs = pairs_count(@numbers)


#   if (@suits_pairs == 10 && straight?(@numbers))
#   then
#     @hand = "ストレートフラッシュ"
#   elsif (@numbers_pairs == 6)
#   then
#     @hand = "フォー・オブ・ア・カインド"
#   elsif (@numbers_pairs == 4)
#   then
#     @hand = "フルハウス"
#   elsif (@suits_pairs == 10)
#   then
#     @hand == "フラッシュ"
#   elsif (straight?(@numbers))
#   then
#     @hand = "ストレート"
#   elsif (@numbers_pairs == 3)
#   then
#     @hand = "スリー・オブ・ア・カインド"
#   elsif (@numbers_pairs == 2)
#   then
#     @hand = "ツーペア"
#   elsif (@numbers_pairs == 1)
#   then
#     @hand = "ワンペア"
#   else
#     @hand = "ハイガード"
#   end
#
  end


end

