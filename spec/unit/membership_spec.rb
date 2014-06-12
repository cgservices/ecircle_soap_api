require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "E-circle Membership Client" do
  before do
    @user = EcircleSoapApi::Client::User.create('lenny.lungus@gmail.com')
  end

  after do
    EcircleSoapApi::Client::User.delete(@user.id)
  end

  it "should subcribe a user to one group" do
    membership = EcircleSoapApi::Client::Membership.create(@user.id, 1900029256)

    memberships = EcircleSoapApi::Client::Membership.find_by_user_id(@user.id)
    expect(memberships.find { |m| %w(1900029256).include?(m.group_id) }).to_not be_nil
  end

  it "should subcribe a user to multiple groups and unsubscribe from one" do
    membership = EcircleSoapApi::Client::Membership.create(@user.id, 1900029256)
    membership = EcircleSoapApi::Client::Membership.create(@user.id, 1900029328)

    memberships = EcircleSoapApi::Client::Membership.find_by_user_id(@user.id)
    memberships.should have_exactly(2).items
    expect(memberships.find { |m| %w(1900029256 1900029328).include?(m.group_id) }).to_not be_nil

    EcircleSoapApi::Client::Membership.delete(@user.id, 1900029256)
    memberships = EcircleSoapApi::Client::Membership.find_by_user_id(@user.id)
    memberships.should have_exactly(1).item

    expect(memberships.find { |m| %w(1900029256).include?(m.group_id) }).to be_nil
  end
end