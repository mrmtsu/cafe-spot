require 'rails_helper'

RSpec.describe Menu, type: :model do
  let!(:menu) { create(:menu) }

  it "有効な状態であること" do
    expect(menu).to be_valid
  end
end
