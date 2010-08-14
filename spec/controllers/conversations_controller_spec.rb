require 'spec_helper'

describe ConversationsController do

  def mock_conversation(stubs={})
    @mock_conversation ||= mock_model(Conversation, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all conversations as @conversations" do
      mock_search_results = mock(Object)
      Conversation.stub(:search) { mock_search_results }
      mock_search_results.stub(:all).and_return([mock_conversation])
      get :index
      assigns(:conversations).should eq([mock_conversation])
    end
  end

  describe "GET show" do
    it "assigns the requested conversation as @conversation" do
      Conversation.stub(:find).with("37") { mock_conversation }
      get :show, :id => "37"
      assigns(:conversation).should be(mock_conversation)
    end
  end

  describe "GET new" do
    before(:each) do
      @admin_person = Factory.create(:admin_person)
      @controller.stub(:current_person).and_return(@admin_person)
    end    
    it "assigns a new conversation as @conversation" do
      Conversation.stub(:new) { mock_conversation }
      get :new
      assigns(:conversation).should be(mock_conversation)
    end
  end

  describe "GET edit" do
    before(:each) do
      @admin_person = Factory.create(:admin_person)
      @controller.stub(:current_person).and_return(@admin_person)
    end    
    it "assigns the requested conversation as @conversation" do
      Conversation.stub(:find).with("37") { mock_conversation }
      get :edit, :id => "37"
      assigns(:conversation).should be(mock_conversation)
    end
  end

  describe "POST create" do
    before(:each) do
      @admin_person = Factory.create(:admin_person)
      @controller.stub(:current_person).and_return(@admin_person)
    end    
    describe "with valid params" do
      it "adds selected issues to the conversation" do
        mock_issue = mock_model(Issue)
        Conversation.stub(:new).with({'these' => 'params'}) { mock_conversation(:save => true) }
        Issue.stub!(:find).with(["1"]).and_return([mock_issue])
        mock_conversation.should_receive(:issues=).with([mock_issue])

        post :create, {:conversation => {'these' => 'params'}, :issue_ids=>["1"]}
      end
      
      it "set the start time as the current time" do
        current_time = Time.now
        Time.stub!(:now).and_return(current_time)
        mock_issue = mock_model(Issue)
        Conversation.stub(:new).with({'these' => 'params'}) { mock_conversation(:save => true) }
        mock_conversation.should_receive(:started_at=).with(current_time)

        post :create, {:conversation => {'these' => 'params'}}
      end
      
      
      it "assigns a newly created conversation as @conversation" do        
        Conversation.stub(:new).with({'these' => 'params'}) { mock_conversation(:save => true) }
        post :create, :conversation => {'these' => 'params'}
        assigns(:conversation).should be(mock_conversation)
      end

      it "redirects to the created conversation" do
        Conversation.stub(:new) { mock_conversation(:save => true) }
        post :create, :conversation => {}
        response.should redirect_to(conversation_url(mock_conversation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved conversation as @conversation" do
        Conversation.stub(:new).with({'these' => 'params'}) { mock_conversation(:save => false) }
        post :create, :conversation => {'these' => 'params'}
        assigns(:conversation).should be(mock_conversation)
      end

      it "re-renders the 'new' template" do
        Conversation.stub(:new) { mock_conversation(:save => false) }
        post :create, :conversation => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before(:each) do
      @admin_person = Factory.create(:admin_person)
      @controller.stub(:current_person).and_return(@admin_person)
    end    
    describe "with valid params" do
      it "updates the requested conversation" do
        Conversation.should_receive(:find).with("37") { mock_conversation }
        mock_conversation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :conversation => {'these' => 'params'}
      end

      it "assigns the requested conversation as @conversation" do
        Conversation.stub(:find) { mock_conversation(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:conversation).should be(mock_conversation)
      end

      it "redirects to the conversation" do
        Conversation.stub(:find) { mock_conversation(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(conversation_url(mock_conversation))
      end
    end

    describe "with invalid params" do
      it "assigns the conversation as @conversation" do
        Conversation.stub(:find) { mock_conversation(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:conversation).should be(mock_conversation)
      end

      it "re-renders the 'edit' template" do
        Conversation.stub(:find) { mock_conversation(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      @admin_person = Factory.create(:admin_person)
      @controller.stub(:current_person).and_return(@admin_person)
    end        
    it "destroys the requested conversation" do
      Conversation.should_receive(:find).with("37") { mock_conversation }
      mock_conversation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the conversations list" do
      Conversation.stub(:find) { mock_conversation }
      delete :destroy, :id => "1"
      response.should redirect_to(conversations_url)
    end
  end

end
