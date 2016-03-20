require_relative '../spec_helper'
require_relative '../../controllers/application_controller'

describe 'Visiting /', type: :feature, js: true do
  it 'should take me to the root' do
    visit '/'
    expect(page).to have_content 'Welcome to the Kulta.US URL Shortener!'
  end
end

describe 'Submitting a website', type: :feature, js: true do
  it 'should return a shortened url' do
    visit '/'
    within('#urlForm') do
      fill_in 'URL:', with: 'http://example.com'
    end
    find('#submit').click
    expect(page).to have_content 'Success! Here is your shortened URL:'
  end
end