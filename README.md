## Ruby-Cucumber-Selenium
[![Travis Status](https://travis-ci.org/saucelabs-sample-test-frameworks/Ruby-Cucumber-Selenium.svg?branch=master)](https://travis-ci.org/saucelabs-sample-test-frameworks/Ruby-Cucumber-Selenium)

This code is provided on an "AS-IS” basis without warranty of any kind, either express or implied, including without limitation any implied warranties of condition, uninterrupted use, merchantability, fitness for a particular purpose, or non-infringement. Your tests and testing environments may require you to modify this framework. Issues regarding this framework should be submitted through GitHub. For questions regarding Sauce Labs integration, please see the Sauce Labs documentation at https://wiki.saucelabs.com/. This framework is not maintained by Sauce Labs Support.

### Environment Setup

1. Global Dependencies
    * Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
    * Or Install Ruby with [Homebrew](http://brew.sh/)
    ```
    $ brew install ruby
    ```
    * Install [Rake](http://docs.seattlerb.org/rake/)
    ```
    $ gem install rake
    ```
    * Install bundler (Sudo may be necessary)
    ```
    $ gem install bundler
    ```

2. Sauce Credentials
    * In the terminal export your Sauce Labs Credentials as environmental variables:
    ```
    $ export SAUCE_USERNAME=<your Sauce Labs username>
	$ export SAUCE_ACCESS_KEY=<your Sauce Labs access key>
    ```
    These settings can be obatined by logging in to the Sauce Labs account and can be saved in the ~/.bash_profile. 

3. Project Dependencies
	* Install packages (Use sudo if necessary)
	```
	$ bundle install
	```

### Running Tests

* In order to run the parallel tests in multiple envionments in Sauce Labs here is the command to execute:
	```
	$ rake test_sauce
	```
    For running the parallel tests in a single environment please execute the individual rake task for example:
    ```
    $ rake windows_10_firefox_47
    ```
* Filtering the tests by using tag names:
    ```
    $ rake test_sauce test_options="-o '-t @<tag-name>'"
    ```
    The above command will run the tests that contains the <tag-name>. Multiple tagnames can be provided as well. 
    ```
    $ rake test_sauce test_options="-o '-t @<tag-name1> -t @<tag-name2>'"
    ```
    This command runs the tests that containes either of the tag names.
    ```
    $ rake test_sauce test_options="-o '-t @<tag-name1>, @<tag-name2>'"
    ```
    Lastly this command runs the tests that contain both the tag names.

### Running Tests Locally

The tests can be executed locally as well. Currently these works on Chrome (latest), Safari (latest) and Firefox version 47. Plese ensure the Chrome and Safari drivers are upto date. 

The tests are executed sequentially in local environments and the filtering of tests are performed in the same manner as in Sauce Labs. An example command to execute the test with tag = <tag-name> can be:
    ```
    $ cucumber LOCAL=true browserName=chrome ./features --tags @<tag-name>
    ```

[Sauce Labs Dashboard](https://saucelabs.com/beta/dashboard/)

### Advice/Troubleshooting

1. There may be additional latency when using a remote webdriver to run tests on Sauce Labs. Timeouts or Waits may need to be increased.
    * [Selenium tips regarding explicit waits](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Explicit+Waits)

### Resources
##### [Sauce Labs Documentation](https://wiki.saucelabs.com/)

##### [SeleniumHQ Documentation](http://www.seleniumhq.org/docs/)

##### [Cucumber Documentation](https://cucumber.io/docs/reference)

##### [Ruby Documentation](http://ruby-doc.org/)

##### [Stack Overflow](http://stackoverflow.com/)
* A great resource to search for issues not explicitly covered by documentation
