require 'rails_helper'

RSpec.describe "PorkerApi", type: :request do
  describe 'poker_api' do

    context '異常系' do
      it '数字が指定外' do
        post '/api', { "cards": ["H1 H13 H15 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] }, { 'CONTENTS_TYPE': 'application/json' }
        expect(response.body).to eq "{\"error\":\"Bad Request\"}"
      end

      it 'スートが指定外' do
        post '/api', { "cards": ["H1 H13 K15 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] }, { 'CONTENTS_TYPE': 'application/json' }
        expect(response.body).to eq "{\"error\":\"Bad Request\"}"
      end

      it '要素数が指定外' do
        post '/api', { "cards": ["H1 H13 K15 H11 H10 D8", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] }, { 'CONTENTS_TYPE': 'application/json' }
        expect(response.body).to eq "{\"error\":\"Bad Request\"}"
      end

      it '半角スペースがない' do
        post '/api', { "cards": ["H1H13H15H11H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] }, { 'CONTENTS_TYPE': 'application/json' }
        expect(response.body).to eq "{\"error\":\"Bad Request\"}"
      end

      it '別文字が混入' do
        post '/api', { "cards": ["H1 H13 *H15 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] }, { 'CONTENTS_TYPE': 'application/json' }
        expect(response.body).to eq "{\"error\":\"Bad Request\"}"
      end

      it 'カード入力なし' do
        post '/api', "あいうえお", { 'CONTENTS_TYPE': 'application/json' }
        expect(response.body).to eq "{\"error\":\"cards is missing\"}"
      end


    end

    context '正常系' do
      it 'サンプル' do
        post '/api', { "cards": ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"] }, { 'CONTENTS_TYPE': 'application/json' }
        body = JSON.parse(response.body)
        expect(body["results"]).to eq [{ "card" => "H1 H13 H12 H11 H10", "hand" => "ストレートフラッシュ", "best" => true }, { "card" => "H9 C9 S9 H2 C2", "hand" => "フルハウス", "best" => false }, { "card" => "C13 D12 C11 H8 H7", "hand" => "ハイカード", "best" => false }]
      end

    end

  end
end

