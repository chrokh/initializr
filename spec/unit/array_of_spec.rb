require 'initializr/array_of'

describe Initializr::ArrayOf do

  let(:hash_of)  { Initializr::ArrayOf  }
  let(:schema) { double :schema }

  subject { Initializr::ArrayOf.new(schema).instantiate(data) }

  context 'empty array' do
    let(:data) { [] }
    it { expect(subject).to eq([]) }
  end

  context 'nil' do
    let(:data) { nil }
    it { expect(subject).to eq([]) }
  end

  context 'hash' do
    let(:data) { [value1, value2] }
    let(:value1) { double :value1 }
    let(:value2) { double :value2 }
    let(:res1) { double :res1 }
    let(:res2) { double :res2 }

    before { expect(schema).to receive(:instantiate).with(value1).and_return(res1) }
    before { expect(schema).to receive(:instantiate).with(value2).and_return(res2) }

    it { expect(subject).to eq([res1, res2]) }
  end

end

