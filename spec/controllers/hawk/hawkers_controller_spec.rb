require 'spec_helper'

shared_examples 'success' do
  describe 'responds with 200' do
    before { request }
    it { should respond_with 200 }
  end
end

describe Hawk::HawkersController do

  let(:valid_attributes) { {"url" => 'http://gavinmorrice.com'} }
  # let(:hawker) { FactoryGirl.create(:hawker) }
  let(:hawker) { Hawk::Hawker.create! valid_attributes }
  let(:id_route_param) { {id: hawker.id, use_route: :hawkers} }

  describe '#new' do
    it 'assign a new hawker' do
      get 'new', {:use_route => :hawkers}
      assigns(:hawker).should be_a_new(Hawk::Hawker)
    end
  end

  describe '#index' do
    let(:request) { get 'index', {:use_route => :hawkers}}
    it 'assign all hawkers as @hawkers' do
      hawker
      request
      assigns(:hawkers).should eq([hawker])
    end

    it_behaves_like 'success'
  end

  [:edit, :show].each do |action|
    describe "#{action}" do

      let(:request) { get action, id_route_param }
      it "should assigns hawker as @hawker" do
        hawker
        request
        assigns(:hawker).should eq(hawker)
        # assigns(:page_content).should eq(page(hawker.url))
      end
      it_behaves_like 'success'
    end
  end

  describe "#create" do
    let(:request) { post :create, {:hawker => valid_attributes, :use_route => :hawkers} }

    it "Should create Hawker" do
      expect {
        request
      }.to change(Hawk::Hawker, :count).by(1)
    end


    it "Should assigns a newly created hawker as @hawker" do
      request
      assigns(:hawker).should be_a(Hawk::Hawker)
      assigns(:hawker).should be_persisted
    end

    it "Should redirects to the created hawker" do
      request
      response.should redirect_to(Hawk::Hawker.last)
    end
  end

  describe "#destroy" do
    context 'with valid hawker' do
      let(:request) { delete :destroy, id_route_param }
      it "delete a Hawker and decrease hawker count by 1" do
        hawker
        expect {
          request
        }.to change(Hawk::Hawker, :count).by(-1)
      end
    end
  end

  describe "#delete_xpath" do
    context "when xpath is present" do
      let(:xpath) { Hawk::Xpath.create!(xpath: "test", targate_name: "test_name", id: hawker.id) }
      it "should delete a xpath and decrease xpath count by 1" do
        xpath
        expect {
          get :delete_xpath , {id: xpath.id, use_route: :hawkers}
        }.to change(Hawk::Xpath, :count).by(-1)
      end
    end

    context "when xpath is not present" do
      it "should not change xpath count" do
        expect {
          get :delete_xpath , {id: -1, use_route: :hawkers}
        }.to change(Hawk::Xpath, :count).by(0)
      end
    end
  end

  describe "#create_update_xpath" do
    context "with new xpath and name" do 
      it "should create hawker xpath" do
        hawker
        expect {
          post :create_update_xpath, id: hawker.id, use_route: :hawkers, xpath: {"new" => {xpath: "testing", name: "testing"}}
        }.to change(Hawk::Xpath, :count).by(1) 
      end
    end

    let(:request) { post :create_update_xpath, id_route_param }

    it "should assigns created/updated hawker as @hawker" do
      request
      assigns(:hawker).should eq(hawker)
    end

    it "redirects to the edit hawker" do
      request
      response.should redirect_to(edit_hawker_path(hawker.id))
    end
  end
end
