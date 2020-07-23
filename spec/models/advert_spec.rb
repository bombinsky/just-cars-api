# frozen_string_literal: true

describe Advert do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:description).is_at_least(64) }

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0).is_less_than(10_000_000) }
  it { is_expected.to allow_value('123').for(:price) }
  it { is_expected.to allow_value('123.0').for(:price) }
  it { is_expected.to allow_value('123.10').for(:price) }
  it { is_expected.not_to allow_value('321,10').for(:price) }

  it { is_expected.to validate_presence_of(:picture) }
end
