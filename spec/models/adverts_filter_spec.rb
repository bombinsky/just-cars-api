# frozen_string_literal: true

describe AdvertsFilter do
  it { is_expected.to validate_length_of(:phrase).is_at_least(3) }
  it { is_expected.to validate_numericality_of(:page).is_greater_than(0).only_integer }
  it { is_expected.to validate_numericality_of(:per_page).is_greater_than(0).only_integer }
  it { is_expected.to validate_numericality_of(:min_price).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:max_price).is_greater_than(0) }

  it { is_expected.to allow_value('created_at_asc').for(:order) }
  it { is_expected.not_to allow_value('created_at').for(:order) }

  it { is_expected.to allow_value('34.01').for(:max_price) }
  it { is_expected.to allow_value('1234500').for(:max_price) }
  it { is_expected.not_to allow_value('33,4').for(:max_price) }

  it { is_expected.to allow_value('34.0').for(:min_price) }
  it { is_expected.to allow_value('12345000.09').for(:min_price) }
  it { is_expected.not_to allow_value('22,2').for(:min_price) }

  it { is_expected.to allow_value('2020-01-01').for(:max_created_at) }
  it { is_expected.not_to allow_value('2020-01-0').for(:max_created_at) }
  it { is_expected.not_to allow_value('2020-01-34').for(:max_created_at) }

  it { is_expected.to allow_value('2020-01-01').for(:min_created_at) }
  it { is_expected.not_to allow_value('2020-01-0').for(:min_created_at) }
  it { is_expected.not_to allow_value('2020-01-34').for(:min_created_at) }
end
