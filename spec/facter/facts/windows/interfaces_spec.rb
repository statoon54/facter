# frozen_string_literal: true

describe 'Windows Interfaces' do
  context '#call_the_resolver' do
    let(:interfaces) { { 'eth0' => { ip6: 'fe80::99bf:da20:ad3:9bfe' }, 'en1' => { ip6: 'fe80::99bf:da20:ad3:9bfe' } } }
    subject(:fact) { Facter::Windows::Interfaces.new }

    before do
      allow(Facter::Resolvers::Networking).to receive(:resolve).with(:interfaces).and_return(interfaces)
    end

    it 'calls Facter::Resolvers::Networking' do
      expect(Facter::Resolvers::Networking).to receive(:resolve).with(:interfaces)
      fact.call_the_resolver
    end

    it 'returns interfaces names' do
      expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'interfaces', value: interfaces.keys.join(','), type: :legacy)
    end
  end
end