module PorkerApi
  class API < Grape::API

    prefix :api
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    helpers do

      def make_array_chara(input)
        # 入力された配列から、文字のみの配列を作成
        chara = []
        input.each do |i|
          chara << i[0]
        end

        return chara

      end


      def make_array_num(input)
        # 入力された配列から、数字のみの配列を作成
        num = []
        input.each do |i|
          i.slice!(0)
          num << i
        end

        return num

      end


      def pairs_count(input)
        # 入力された配列のペア数をカウント
        i   = 0
        u   = 0
        sum = 0
        for i in 0..3 do
          for u in i+1..4 do
            sum += 1 if (input[i] == input[u])
          end
        end

        return sum

      end


      def straight?(numbers)
        # 入力された配列がストレートになっているかを確認
        if (numbers.max.to_i - numbers.min.to_i == 4 && pairs_count(numbers) == 0) || (numbers.sort.map(&:to_i) == [1, 10, 11, 12, 13])
          return true
        else
          return false
        end

      end

    end


    params do
      requires :cards, type: Array, desc: 'Cards'
    end

    post '/', jbuilder: 'porker' do
      @hands  = []
      @scores = []
      params[:cards].each do |v|

        @card          = v
        @suits_pairs   = pairs_count(make_array_chara(@card.split(" ")))
        @numbers_pairs = pairs_count(make_array_num(@card.split(" ")))
        @straight      = straight?(make_array_num(@card.split(" ")))

        if (@suits_pairs == 10 && @straight)
          @hand = "ストレートフラッシュ", @score = 8
        elsif (@numbers_pairs == 6)
          @hand = "フォー・オブ・ア・カインド", @score = 7
        elsif (@numbers_pairs == 4)
          @hand = "フルハウス", @score = 6
        elsif (@suits_pairs == 10)
          @hand = "フラッシュ", @score = 5
        elsif (@straight)
          @hand = "ストレート", @score = 4
        elsif (@numbers_pairs == 3)
          @hand = "スリー・オブ・ア・カインド", @score = 3
        elsif (@numbers_pairs == 2)
          @hand = "ツーペア", @score = 2
        elsif (@numbers_pairs == 1)
          @hand = "ワンペア", @score = 1
        else
          @hand = "ハイカード", @score = 0
        end

        @hands << { card: @card, hand: @hand, score: @score }
        @scores << @score

      end

      @results = []
      @hands.each do |h|
        @results << { card: h[:card], hand: h[:hand], best: h[:score] == @scores.max }

      end

    end


  end
end

