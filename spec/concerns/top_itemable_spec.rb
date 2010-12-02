require 'spec_helper'

[Contribution, Issue, Conversation].each do |model_type|
  describe model_type.to_s, "When working with top items" do
    before(:each) do
      @person = Factory.create(:normal_person)
      @item = Factory.create(model_type.to_s.underscore, {:created_at=>(Time.now-7.days), :recent_rating => 5, :recent_visits => 201})
    end
    context "and creating a #{model_type.to_s}" do
       it "add a top item" do
         @item.top_item.should be_an_instance_of(TopItem)
       end
       it "should set the item_created_at time to equal the #{model_type}'s created_at time" do
         @item.top_item.item_created_at.to_s.should == @item.created_at.to_s
       end
       it "should set the recent_rating to the #{model_type}'s recent_rating if rateable" do
         if @item.respond_to?(:recent_rating)
           @item.top_item.recent_rating.should == @item.recent_rating
         else
           @item.top_item.recent_rating.should be_nil
         end
       end
       it "should set the recent_visits to the #{model_type}'s recent_visits if visitable" do
         if @item.respond_to?(:recent_visits)
           @item.top_item.recent_visits.should == @item.recent_visits
         else
           @item.top_item.recent_visits.should be_nil
         end
       end
    end
  end
end

Contribution::ALL_TYPES.each do |model_type|
  describe model_type.to_s, "When working with top items" do
    before(:each) do
      @person = Factory.create(:normal_person)
      @item = Factory.create(model_type.underscore, {:created_at=>(Time.now-7.days), :recent_rating => 5, :recent_visits => 201})
    end
    context "and creating a #{model_type}" do
      it "does not add a top item, since #{model_type} is not confirmed" do
        @item.top_item.should be_nil
      end
      it "adds top item when #{model_type} is confirmed" do
        @item.confirm!
        @item.top_item.should be_an_instance_of(TopItem)
      end
    end
  end
end

describe "TopLevelContribution", "When working with top items" do
  before(:each) do
    @person = Factory.create(:normal_person)
    @item = Factory.create(:top_level_contribution, {:created_at=>(Time.now-7.days), :recent_rating => 5, :recent_visits => 201})
  end
  context "and creating a TopLevelContribution" do
    it "adds a top item, since TLC is confirmed by default" do
      @item.top_item.should be_an_instance_of(TopItem)
    end
  end
end
