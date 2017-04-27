begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'selenium-webdriver'
require 'sauce_whisk'
require_relative '../page_objects/home_page'

Before do | scenario |
  capabilities_config = {
    :version => "#{ENV['version']}",
    :platform => "#{ENV['platform']}",
    :name => "#{scenario.feature.name} - #{scenario.name}"
  }
  build_name = ENV['JENKINS_BUILD_NUMBER'] || ENV['SAUCE_BAMBOO_BUILDNUMBER'] || ENV['SAUCE_TC_BUILDNUMBER'] || ENV['SAUCE_BUILD_NAME']
  capabilities_config[:build] = build_name unless build_name.nil?

  if ENV['LOCAL']
    @browser = Selenium::WebDriver.for ENV['browserName'].to_sym
    @browser.manage.window.resize_to(640,1024)
  else
    capabilities = Selenium::WebDriver::Remote::Capabilities.send(ENV['browserName'].to_sym, capabilities_config)
    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 180
    @browser = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => capabilities, :http_client => client)
  end

end

# "after all"
After do | scenario |
  jobname = "#{scenario.feature.name} - #{scenario.name}"

  if ENV['LOCAL']
    puts jobname
  else
    sessionid = @browser.send(:bridge).session_id
    puts "SauceOnDemandSessionID=#{sessionid} job-name=#{jobname}"
    if scenario.passed?
      SauceWhisk::Jobs.pass_job sessionid
    else
      SauceWhisk::Jobs.fail_job sessionid
    end
  end

  @browser.quit

end

# Explicit wait definition
def wait_for
  Selenium::WebDriver::Wait.new(timeout: 30).until { yield }
end

# Obtain shadow root element
def expand_root_element(element_name)
  @browser.execute_script("return arguments[0].shadowRoot", element_name)
end

# Obtain element within shadow root
def find_deep_element(selector_text)
  if ENV['browserName'] == 'chrome'
    @browser.execute_script('return document.querySelector("body /deep/ %s")' % selector_text)
  else
    @browser.find_element(css: selector_text)
  end
end
