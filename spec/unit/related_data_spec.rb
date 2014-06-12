require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "E-circle Membership Client" do
  before do
    @user = EcircleSoapApi::Client::User.create('lenny.lungus@gmail.com')
  end

  after do
    EcircleSoapApi::Client::User.delete(@user.id)
  end

  it "should create and delete related data for user" do
    EcircleSoapApi::Client::RelatedData.create('purchasehistory', @user.email, {name: 'OrderNumber', value: 'R123456789'}, {name: 'Product', value: 'iTunes 10 EURO'}, {name: 'SalePrice', value: 10.00}, {name: 'OrderDate', value: '2014-06-12'}, {name: 'Label', value: 'topup'}, {name: 'Brand', value: 'iTunes'} )
    deleted_records = EcircleSoapApi::Client::RelatedData.delete('purchasehistory', @user.email, {name: 'Label', value: 'topup'})
    deleted_records.should eq(1)
  end

end