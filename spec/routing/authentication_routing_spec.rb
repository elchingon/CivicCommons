require "spec_helper"

describe AuthenticationController do

  describe "routing" do
    it "recognizes and generates #decline_fb_auth" do
      { post: "/authentication/decline_fb_auth" }.should route_to(controller: "authentication", action: "decline_fb_auth")
    end

    it "recognizes and generates GET #conflicting_email" do
      { get: "/authentication/conflicting_email" }.should route_to(controller: "authentication", action: "conflicting_email")
    end

    it "recognizes and generates POST #conflicting_email" do
      { post: "/authentication/conflicting_email" }.should route_to(controller: "authentication", action: "update_conflicting_email")
    end

    it "recognizes and generates GET #conflicting_email" do
      { get: '/authentication/fb_linking_success' }.should route_to(controller: "authentication", action: "fb_linking_success")
    end

    it "recognizes and generates GET #registering_email_taken" do
      { get: '/authentication/registering_email_taken' }.should route_to(controller: "authentication", action: "registering_email_taken")      
    end
    
    it "recognizes and generates GET #successful_registration" do
      { get: '/authentication/successful_registration' }.should route_to(controller: "authentication", action: "successful_registration")      
    end
    
    it "recognizes and generates GET #confirm_facebook_unlinking" do
      { get: '/authentication/confirm_facebook_unlinking' }.should route_to(controller: "authentication", action: "confirm_facebook_unlinking")      
    end

    
    it "recognizes and generates GET #before_facebook_unlinking" do
      { get: '/authentication/before_facebook_unlinking' }.should route_to(controller: "authentication", action: "before_facebook_unlinking")      
    end
    
    it "recognizes and generates DELETE #process_facebook_unlinking" do
      { delete: '/authentication/process_facebook_unlinking' }.should route_to(controller: "authentication", action: "process_facebook_unlinking")      
    end
    
  end

end
