require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    context 'when user attempts to view /events' do
      it 'responds with 200 and renders' do
        get :index
        expect(response).to render_template('events/index')
        expect(response).to have_http_status(200)
      end
    end
  end
end
