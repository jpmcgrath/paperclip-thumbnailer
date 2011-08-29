require 'rspec'

shared_examples "a Paperclip processor" do
  it "has a .make class method" do
    subject.should respond_to(:make)
  end
end
