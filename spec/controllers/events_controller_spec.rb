require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  fixtures :users, :orgs

  describe 'GET /events' do
    context 'when user attempts to view /events' do
      it 'responds with 200 and renders' do
        get :index
        expect(response).to render_template('events/index')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /events/new' do
    context 'when a not logged-in visitor views /events/new' do
      it 'responds with 403' do
        get :new
        expect(response).to have_http_status(403)
      end
    end
    context 'when a logged-in user views /events/new' do
      it 'responds with 200' do
        snow = users(:john_snow)
        session['user_id'] = snow.id # sets current_user to john_snow's User
        snow.save
        get :new
        expect(response).to have_http_status(200)
      end

      it 'renders the correct template' do
        snow = users(:john_snow)
        session['user_id'] = snow.id # sets current_user to john_snow's User
        snow.save
        get :new
        expect(response).to render_template('events/new')
      end
    end
  end

  describe 'POST /events/new' do
    context 'when a not logged-in visitor attempts to create an event' do
      it 'responds with 403' do
        post :new
        expect(response).to have_http_status(403)
      end
    end

    context 'when user attempts creates a new event' do
      it 'responds with 201 CREATED' do

        pending 'responds with 201 CREATED'

      end
    end
  end

  pending 'PATCH /events/:id'

  describe 'GET /events#show' do
    context 'when user attempts to view a nonexistent event' do
      it 'responds with 404' do
        param = {id: 1773}
        get :show, params: param
        expect(response).to have_http_status(404)
      end
    end

    context 'when user attempts to view an event' do
      before(:example) do
        cc = orgs(:cat_club)
        e = Event.create(
          title: 'Cat Adoption', description: 'Come to adopt a kitty!',
          start_date: Time.now + 1.hour, end_date: Time.now + 5.hours,
          event_date: Time.now, all_day: false, location: '4015 Walnut Street',
          location_lat: 0, location_lon: 0, org: cc, category: 'Publications'
        )
        @show_param = { id: e.id }
      end

      it 'responds with 200' do
        get :show, params: @show_param
        expect(response).to have_http_status(200)
      end

      it 'renders the correct template' do
        get :show, params: @show_param
        expect(response).to render_template('events/show')
      end
    end
  end
end
