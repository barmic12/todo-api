require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'Factory validation' do
    it 'has a valid factory' do
      expect(build(:task)).to be_valid
    end
  end


  let(:task) { build(:task) }

  describe 'ActiveModel validations' do

    it { expect(task).to validate_presence_of(:name) }
    it { expect(task).to validate_inclusion_of(:status).in_array([true, false]) }

  end
end