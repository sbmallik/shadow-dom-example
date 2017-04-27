class StoryAssetPage

  def initialize(browser)
    @browser = browser
  end

  def visit
      @browser.navigate.to "https://www.usatoday.com/story/news/world/2017/04/18/iraq-snipers-islamic-state-federal-police/100384114/?uw=true"
  end

  def headline
    @browser.find_element(class_name: 'display-1')
  end

  def logo
    self.find_deep_element('#logo')
  end

  def nav_hub_toggle
    self.find_deep_element('#fullNavToggle')
  end

  def nav_container
    self.find_deep_element('.nav-container')
  end

  # Obtain element within shadow root
  def find_deep_element(selector_text)
    if ENV['browserName'] == 'chrome'
      @browser.execute_script('return document.querySelector("body /deep/ %s")' % selector_text)
    else
      @browser.find_element(css: selector_text)
    end
  end

  # Wait for an element to display
  def wait_for_element_display(times=150)
    1.upto(times) do |i|
      break unless yield == nil
      raise "Element does not exist in the viewport." if i == times
      sleep 0.2
    end
  end

end
