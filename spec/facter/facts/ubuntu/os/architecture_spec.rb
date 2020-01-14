# frozen_string_literal: true

describe 'Ubuntu OsArchitecture' do
  context '#call_the_resolver' do
    subject(:fact) { Facter::Ubuntu::OsArchitecture.new }
    context 'when resolver does not return x86_64' do
      let(:value) { 'i86pc' }

      before do
        allow(Facter::Resolvers::Uname).to receive(:resolve).with(:machine).and_return(value)
      end

      it 'calls Facter::Resolvers::Uname' do
        expect(Facter::Resolvers::Uname).to receive(:resolve).with(:machine)
        fact.call_the_resolver
      end

      it 'returns architecture fact' do
        expect(fact.call_the_resolver).to be_an_instance_of(Array).and \
          contain_exactly(an_object_having_attributes(name: 'os.architecture', value: value),
                          an_object_having_attributes(name: 'architecture', value: value, type: :legacy))
      end
    end

    context 'when resolver returns x86_64' do
      let(:value) { 'x86_64' }

      before do
        allow(Facter::Resolvers::Uname).to receive(:resolve).with(:machine).and_return(value)
      end

      it 'calls Facter::Resolvers::Uname' do
        expect(Facter::Resolvers::Uname).to receive(:resolve).with(:machine)
        fact.call_the_resolver
      end

      it 'returns architecture fact' do
        expect(fact.call_the_resolver).to be_an_instance_of(Array).and \
          contain_exactly(an_object_having_attributes(name: 'os.architecture', value: 'amd64'),
                          an_object_having_attributes(name: 'architecture', value: 'amd64', type: :legacy))
      end
    end
  end
end
