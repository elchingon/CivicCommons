require 'cucumber/rspec/doubles'

Given /^I have contributed a comment:$/ do |content|

  # TODO: Replace Date.parse with Chronic.parse
  Factory.create(:comment,
                 content: content,
                 person: @current_person,
                 conversation: @conversation,
                 created_at: Date.parse("2010/10/10"))
end

Given /^I have contributed a video:$/ do |contribution|

  contribution = contribution.rows_hash

  @contribution = Factory.build(:embedded_snippet,
                                person: @current_person,
                                conversation: @conversation,
                                created_at: Date.parse("2010/10/10"),
                                url: contribution['URL'],
                                content: contribution['Comment'])


  @contribution.stub(:embed_code_for_video) do |video_id|
    "<test_embed src='http://www.youtube.com/v/#{video_id}?fs=1&amp;hl=en_US'></test_embed>"
  end


  @contribution.save

end

