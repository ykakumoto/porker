module PorkerApi
  class API < Grape::API

    helpers do
      include Common
    end

    prefix :api
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    params do
      requires :cards, type: Array, desc: 'Cards'
    end

    post '/', jbuilder: 'porker' do

      status :ok

      # 配列を定義
      hands    = []
      scores   = []
      @results = []

      # 入力された文字列配列の繰り返し処理を実行
      params[:cards].each do |v|
        unless v =~ /^([DHCS]([1-9]|1[0-3]) ){4}[DHCS]([1-9]$|1[0-3]$)/
          error!("Bad Request", 400)

        else

          # 入力された文字列から、スートの配列と数字の配列を作成
          card          = v
          suits         = make_array_chara(card.split(" "))
          numbers       = make_array_num(card.split(" "))

          # スートのペア数・数字のペア数・ストレート判定を作成
          suits_pairs   = pairs_count(suits)
          numbers_pairs = pairs_count(numbers)
          straight      = straight?(numbers)

          # 手役と強さを作成
          hand          = handscheck(suits_pairs, numbers_pairs, straight)[0]
          score         = handscheck(suits_pairs, numbers_pairs, straight)[1]

          # 入力カード・手役・強さの配列と、強さの配列を作成
          hands << { card: card, hand: hand, score: score }
          scores << score

        end

      end

      # 最も強い手役を判定し、入力カード・手役・最強役判定の配列を出力
      hands.each do |h|
        @results << { card: h[:card], hand: h[:hand], best: h[:score] == scores.max }
      end

    end


  end
end

