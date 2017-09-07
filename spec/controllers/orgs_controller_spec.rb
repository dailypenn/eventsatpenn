require 'rails_helper'

RSpec.describe OrgsController, type: :controller do
  pending "GET /orgs/new"
  pending "POST /orgs/new"
  pending "GET /orgs#show"

  describe 'GET /orgs' do
    context 'when user attempts to view /orgs' do
      it 'responds with 200 and renders' do
        get :index
        expect(response).to render_template('orgs/index')
        expect(response).to have_http_status(200)
      end
    end
  end
end
