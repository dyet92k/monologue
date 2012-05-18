require 'spec_helper'
describe "posts" do
  before(:each) do
    Factory(:post_with_multiple_revisions)
  end
  
  it "lists posts" do
    visit "/monologue"

    page.should have_content("post X | revision 2")
    page.should_not have_content("post X | revision 1")
  end
  
  it "should route to a post" do
    visit "/monologue"
    click_on "post X | revision 2"
    page.should have_content("this is some text with french accents")
    page.should_not have_content("post X | revision 1")
  end
  
  it "has a feed" do
    visit feed_path
    page.should_not have_content("post X | revision 1")
    page.should have_content("post X | revision 2")
  end
  
  it "should return 404 on non existent post" do
    visit "/monologue/this/is/a/404/url"
    page.should have_content("You may have mistyped the address or the page may have moved")
  end
end

describe "Viewing a post with tags" do
  before(:each) do
    Factory(:post_with_tags)
  end

  it "should display the tags for the post as a link" do
    visit "/monologue"
    click_on "post X | revision 2"
    page.should have_link("rails")
  end

end
