require_relative '../../lib/short'
require_relative '../../migrations/initial'
require_relative '../spec_helper'

describe 'Instance of', Short do
  before(:all) do
    InitialMigration.migrate(:down)
    InitialMigration.migrate(:up)
  end

  before(:all) do
    @short = build(:short)
    @short2 = build(:short)
    @short3 = build(:short)
    @short3.url = 'https://example.com'
  end

  context 'when created' do
    it 'should have a long url' do
      expect(@short.url).not_to be_nil
      expect(@short.url).to eq('https://google.com')
    end

    it 'should have a shortened url' do
      expect(@short.short).not_to be_nil
      expect(@short.short.length).to be(5)
    end

    it 'should have a valid timestamp' do
      expect(@short.time).to be_within(5.second).of(Time.now)
    end
  end

  context 'when saved' do
    it 'should return true when short and url is unique' do
      expect(@short.save).to eq(true)
    end

    it 'should return previously shortened url if not unique' do
      expect(@short2.save).to eq(@short.short)
    end

    it 'should not save when short is not unique' do
      @short2.short = @short.short
      expect(@short2.save).to eq(false)
    end
  end

  context 'when checking uniqueness of url' do
    it 'should not be unique' do
      expect(@short).to_not be_unique_url
    end

    it 'should be unique' do
      expect(@short3).to be_unique_url
    end
  end

  context 'when checking uniqueness of short' do
    it 'should not be unique' do
      expect(@short).to_not be_unique_short
    end

    it 'should be unique' do
      expect(@short3).to be_unique_short
    end
  end

  context 'when using invalid old short' do
    it 'should return false' do
      expect(@short3.old_url).to eq false
    end
  end

  context 'when using old short' do
    it 'should find old url' do
      @short3.short = @short.short
      expect(@short3.old_url).to eq 'https://google.com'
    end
  end
end