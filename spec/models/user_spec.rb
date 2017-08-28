require 'rails_helper'

RSpec.describe User do
  let!(:user) { create :user }
  before do
    binding.pry
  end

  it { expect(true).to eq(true) }
end