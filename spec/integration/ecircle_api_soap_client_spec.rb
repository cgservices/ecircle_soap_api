require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "E-circle Client" do
  it "should raise an exception when searching for user with email i.dont@exist.com" do
    lambda {user = EcircleSoapApi::Client::User.find_by_email('i.dont@exist.com')}.should raise_error(EcircleSoapApi::ObjectNotFound)
  end

  it "should create a user with email address: lenny.lungus@gmail.com find it by id and delete the created user afterwards" do
    expected_user = EcircleSoapApi::Client::User.new({email: 'lenny.lungus@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.create('lenny.lungus@gmail.com', {name: 'TopupProvider', value:'Vodafone'})

    new_user = EcircleSoapApi::Client::User.find(user.id)
    new_user.email.should eq(expected_user.email)

    EcircleSoapApi::Client::User.delete(new_user.id)
    lambda {EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')}.should raise_error(EcircleSoapApi::ObjectNotFound)
  end

  it "should create a user with email address: lenny.lungus@gmail.com find it by email and delete the created user afterwards" do
    expected_user = EcircleSoapApi::Client::User.new({email: 'lenny.lungus@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.create('lenny.lungus@gmail.com', {name: 'TopupProvider', value:'Vodafone'})

    new_user = EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')
    new_user.email.should eq(expected_user.email)

    EcircleSoapApi::Client::User.delete(new_user.id)
    lambda {EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')}.should raise_error(EcircleSoapApi::ObjectNotFound)
  end

  it "should create a user with email address: lenny.lungus@gmail.com and custom attributes find it by id and delete the created user afterwards" do
    expected_user = EcircleSoapApi::Client::User.new({email: 'lenny.lungus@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.create('lenny.lungus@gmail.com', {name: 'TopupProvider', value:'Vodafone'})

    new_user = EcircleSoapApi::Client::User.find_user_with_attributes(user.id)
    new_user.attributes[:topup_provider].should eq('Vodafone')

    EcircleSoapApi::Client::User.delete(new_user.id)
    lambda {EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')}.should raise_error(EcircleSoapApi::ObjectNotFound)
  end

  it "should find_or_create a user with email address: lenny.lungus@gmail.com and delete the created user afterwards" do
    new_user = EcircleSoapApi::Client::User.find_or_create_by_email('lenny.lungus@gmail.com', {name: 'TopupProvider', value:'Vodafone'})
    found_user = EcircleSoapApi::Client::User.find_or_create_by_email('lenny.lungus@gmail.com', {name: 'TopupProvider', value:'Vodafone'})

    test_user = EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')
    test_user.email.should eq(new_user.email)
    test_user.email.should eq(found_user.email)

    EcircleSoapApi::Client::User.delete(new_user.id)
    lambda {EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')}.should raise_error(EcircleSoapApi::ObjectNotFound)
  end
end
