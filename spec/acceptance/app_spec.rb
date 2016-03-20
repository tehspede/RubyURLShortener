require_relative '../spec_helper'
require_relative '../../controllers/application_controller'

describe 'Visiting /', type: :feature do
  it 'should take me to the root' do
    visit '/'
    expect(page).to have_content 'Welcome to the Kulta.US URL Shortener!'
  end
end