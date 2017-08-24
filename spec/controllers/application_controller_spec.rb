require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'GET #index' do
    context 'when user attempts to view the page' do
      it 'responds with 200 and renders' do
        get :index
        expect(response).to render_template('welcome/index.html.erb')
        expect(response).to have_http_status(200)
      end
    end
  end

  # describe 'GET #about' do
  #   context 'when user attempts to view the page' do
  #     it 'responds with 200 and renders' do
  #       get :about
  #       expect(response).to render_template('pages/about.html.erb')
  #       expect(response).to have_http_status(200)
  #     end
  #   end
  # end
end
