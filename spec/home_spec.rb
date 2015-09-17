require_relative '../opinionsapp'
require 'spec_helper'

describe 'User visits homepage' do
  before do
    Capybara.app = Sinatra::Application
  end

  it "successfully" do
    visit '/'
    expect(page).to have_content('Welcome to OpinionsApp')
  end

  it "and sends a new opinion" do
    visit '/'
    fill_in 'Opinion', with: 'Rails is awesome'
    click_on 'Say it!'
    expect(page).to have_content('Rails is awesome')
  end
end
