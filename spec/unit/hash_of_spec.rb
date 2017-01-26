require 'initializr/hash_of'

describe Initializr::HashOf do

  let(:hash_of)  { Initializr::HashOf  }
  let(:schema) { double :schema }

  subject { Initializr::HashOf.new(schema).instantiate(data) }

  context 'empty hash' do
    let(:data) { {} }
    it { expect(subject).to eq({}) }
  end

  context 'nil' do
    let(:data) { nil }
    it { expect(subject).to eq({}) }
  end

  context 'hash' do
    let(:data) { { key1: value1, key2: value2 } }
    let(:value1) { double :value1 }
    let(:value2) { double :value2 }
    let(:res1) { double :res1 }
    let(:res2) { double :res2 }

    before do
      expect(schema).to receive(:instantiate).with(value1).and_return(res1)
      expect(schema).to receive(:instantiate).with(value2).and_return(res2)
    end

    it { expect(subject).to eq(key1: res1, key2: res2) }
  end

end

