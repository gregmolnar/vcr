require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VCR::HttpStubbingAdapters::WebMock do
  it_should_behave_like 'an http stubbing adapter',
    %w[net/http patron httpclient em-http-request],
    [:method, :uri, :host, :path, :body, :headers]

  describe '#check_version!' do
    before(:each) { WebMock.should respond_to(:version) }

    %w( 1.3.3 1.3.10 1.4.0 2.0.0 ).each do |version|
      it "does nothing when WebMock's version is #{version}" do
        WebMock.stub!(:version).and_return(version)
        expect { described_class.check_version! }.to_not raise_error
      end
    end

    %w( 0.9.9 0.9.10 0.1.30 1.0.30 1.2.9 1.3.2 ).each do |version|
      it "raises an error when WebMock's version is #{version}" do
        WebMock.stub!(:version).and_return(version)
        expect { described_class.check_version! }.to raise_error(/You are using WebMock #{version}.  VCR requires version .* or greater/)
      end
    end
  end
end
