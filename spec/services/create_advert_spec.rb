# frozen_string_literal: true

describe CreateAdvert do
  describe '#call' do
    subject(:service_call) { described_class.new(user: user, attributes: attributes).call }

    let(:user) { create :user }

    context 'with invalid attributes' do
      let(:attributes) { { title: nil } }

      shared_examples 'object with invalid attribute' do |attribute_name|
        it "transmits error message for #{attribute_name}" do
          expect(service_call.errors[attribute_name]).to be_present
        end
      end

      it { is_expected.to be_an Advert }
      it { is_expected.not_to be_valid }
      it { is_expected.not_to be_persisted }

      it_behaves_like 'object with invalid attribute', :title
      it_behaves_like 'object with invalid attribute', :description
      it_behaves_like 'object with invalid attribute', :price
      it_behaves_like 'object with invalid attribute', :picture
    end

    context 'with valid attributes' do
      let(:attributes) { attributes_for :advert }

      it { is_expected.to be_an Advert }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }

      it 'adds one advert to the system' do
        expect { service_call }.to change(Advert, :count).by 1
      end

      it 'saves user association' do
        expect(service_call.user).to eq user
      end

      it 'saves title provided among attributes' do
        expect(service_call.title).to eq attributes[:title]
      end

      it 'saves description provided among attributes' do
        expect(service_call.description).to eq attributes[:description]
      end

      it 'saves decimal price provided among attributes' do
        expect(service_call.price).to eq attributes[:price].to_d
      end

      it 'attaches picture provided among attributes' do
        expect(service_call.picture).to be_an ActiveStorage::Attached::One
      end
    end
  end
end
