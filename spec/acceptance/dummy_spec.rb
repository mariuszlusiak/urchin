require 'spec_helper'

feature 'Dummy feature' do
  scenario 'dummy scenario', :js => true do
    visit '/'
  end
end
