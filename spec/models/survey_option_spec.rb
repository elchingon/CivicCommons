require 'spec_helper'

describe SurveyOption do
  context "attributes" do
    before(:each) do
      @survey_option = SurveyOption.new
    end
    it "should have :winner" do
      @survey_option.respond_to?(:winner).should be_true
    end
    it "should have :weighted_votes_percentage" do
      @survey_option.respond_to?(:weighted_votes_percentage).should be_true
    end
  end
  context "Associations" do
    it "should belong to poll" do
      SurveyOption.reflect_on_association(:survey).macro.should == :belongs_to
    end
    
    it "should have many selected_survey_options" do
      SurveyOption.reflect_on_association(:selected_survey_options).macro.should == :has_many
    end
    
    it "should destroy the selected_survey_options" do
      SurveyOption.reflect_on_association(:selected_survey_options).options[:dependent].should == :destroy
    end
  end

  context "Validations" do
    def given_an_invalid_survey_option
      @survey_option = SurveyOption.create
    end
    
    it "should validate presence of survey" do
      given_an_invalid_survey_option
      @survey_option.errors[:survey_id].should == ["can't be blank"]
    end
    
    it "should validate uniqueness of survey" do
      @survey_option1 = FactoryGirl.create(:survey_option, :position => 1, :survey_id => 1)
      @survey_option2 = FactoryGirl.build(:survey_option, :position => 1, :survey_id => 1)
      @survey_option2.valid?
      @survey_option2.errors[:position].should == ["has already been taken"]
    end
  end
  
  context "named scope" do
    def given_a_few_surveys 
      @survey_option2 = FactoryGirl.create(:survey_option, :position => 2)
      @survey_option1 = FactoryGirl.create(:survey_option, :position => 1)
    end

    it "should " do
      given_a_few_surveys
      SurveyOption.position_sorted.all.should == [@survey_option1, @survey_option2]
    end
    
  end

end
