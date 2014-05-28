require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "E-circle Client" do
  it "should find a user with userid 19025498585" do
    expected_user = EcircleSoapApi::Client::User.new({id: '19026037755', email: 'ldoubrava@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.find('19026037755')
    #user.should equal(expected_user)
    user.email.should eq(expected_user.email)
  end

  it "should find a user with email ldoubrava@gmail.com" do
    expected_user = EcircleSoapApi::Client::User.new({id: '19026037755', email: 'ldoubrava@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.find_by_email('ldoubrava@gmail.com')
    user.id.should eq(expected_user.id)
  end

  it "should find attributes of user with userid 19025498585" do
    expected_user = EcircleSoapApi::Client::User.new({id: '19026037755', email: 'ldoubrava@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.find_user_with_attributes('19026037755')
    #user.should equal(expected_user)
    user.email.should eq(expected_user.email)
  end

  it "should raise an exception when searching for user with email i.dont@exist.com" do
    lambda {user = EcircleSoapApi::Client::User.find_by_email('i.dont@exist.com')}.should raise_error(EcircleSoapApi::ObjectNotFound)
  end

  it "should create a user with email address: lenny.lungus@gmail.com and delete the created user afterwards" do
    expected_user = EcircleSoapApi::Client::User.new({email: 'lenny.lungus@gmail.com', mobile_number: nil, attributes: nil})

    user = EcircleSoapApi::Client::User.create('lenny.lungus@gmail.com', {name: 'TopupProvider', value:'Vodafone'})

    new_user = EcircleSoapApi::Client::User.find_by_email('lenny.lungus@gmail.com')
    new_user.email.should eq(expected_user.email)

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
