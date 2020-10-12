require 'spec_helper'

RSpec.describe WebCrawler::Logger do
  subject(:logger) {described_class}
  before do
    logger.setting
  end
  describe '#info' do
    context 'when log is disable' do
      it 'do not show' do
        WebCrawler::Config.log = false
        expect(logger.info('return nil')).to be_nil
      end
    end

    context 'when log is enable' do
      it 'show log in the console' do
        expect(logger.info('return nil', true)).to be_truthy
      end
    end
  end
end