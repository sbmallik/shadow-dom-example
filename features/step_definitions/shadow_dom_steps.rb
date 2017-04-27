Given(/^That I am viewing the UW asset page$/) do
  @story_asset_page = StoryAssetPage.new @browser
  @story_asset_page.visit
end

Then(/^I should see the asset headline$/) do
  wait_for do
    expect(@story_asset_page.headline.nil?).to be false
    expect(@story_asset_page.headline.displayed?).to be true
  end
end

Then(/^I should see the navigation bar with logo$/) do
  wait_for do
    expect(@story_asset_page.logo.displayed?).to be true
  end
end

When(/^I click on the navigation hub toggle button$/) do
  @story_asset_page.wait_for_element_display do
    @story_asset_page.nav_hub_toggle
  end
  @story_asset_page.nav_hub_toggle.click
end

Then(/^I should see the navigation hub elements$/) do
  @story_asset_page.wait_for_element_display do
    @story_asset_page.nav_container
  end
  expect(@story_asset_page.nav_container.displayed?).to be true
end
