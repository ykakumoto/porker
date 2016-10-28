require 'rails_helper'

RSpec.describe PorkerController, type: :controller do

  describe '#handcheck' do

    context '異常系' do
      it 'スートが指定外' do
        post :porkerhand, hand: "H1 H2 H3 H4 J5"
        expect(assigns(:hand)).to eq nil
      end

      it '数字が指定外' do
        post :porkerhand, hand: "H18 H2 H3 H4 H5"
        expect(assigns(:hand)).to eq nil
      end

      it '要素数が指定外' do
        post :porkerhand, hand: "H18 H2 H3 H4 H5 D12"
        expect(assigns(:hand)).to eq nil
      end

      it '半角スペースがない' do
        post :porkerhand, hand: "H1 H2 H3H4 J5"
        expect(assigns(:hand)).to eq nil
      end

      it '別文字が混入' do
        post :porkerhand, hand: "H1 H2 H3 *H4 J5"
        expect(assigns(:hand)).to eq nil
      end

      it '空白で入力' do
        post :porkerhand, hand: ""
        expect(assigns(:hand)).to eq nil
      end

    end


    context '正常系' do
      it 'ストレートフラッシュ' do
        post :porkerhand, hand: "H3 H4 H5 H6 H7"
        expect(assigns(:hand)).to eq "ストレートフラッシュ"
      end

      it 'フォー・オブ・ア・カインド' do
        post :porkerhand, hand: "H3 C3 D3 S3 D5"
        expect(assigns(:hand)).to eq "フォー・オブ・ア・カインド"
      end

      it 'フルハウス' do
        post :porkerhand, hand: "H3 C3 D3 S4 D4"
        expect(assigns(:hand)).to eq "フルハウス"
      end

      it 'フラッシュ' do
        post :porkerhand, hand: "H3 H6 H1 H12 H10"
        expect(assigns(:hand)).to eq "フラッシュ"
      end

      it 'ストレート' do
        post :porkerhand, hand: "S1 D10 C11 D12 C13"
        expect(assigns(:hand)).to eq "ストレート"
      end

      it 'スリー・オブ・ア・カインド' do
        post :porkerhand, hand: "H7 C7 D7 H3 C9"
        expect(assigns(:hand)).to eq "スリー・オブ・ア・カインド"
      end

      it 'ツーペア' do
        post :porkerhand, hand: "H7 C7 H3 D3 S9"
        expect(assigns(:hand)).to eq "ツーペア"
      end

      it 'ワンペア' do
        post :porkerhand, hand: "S9 D3 S7 D9 C2"
        expect(assigns(:hand)).to eq "ワンペア"
      end

      it 'ハイカード' do
        post :porkerhand, hand: "S1 D8 C5 D2 C13"
        expect(assigns(:hand)).to eq "ハイカード"
      end

    end

  end

end
