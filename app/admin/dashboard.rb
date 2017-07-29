ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: 'Dashboard'

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recently Created Accounts' do
          ul do
            User.last(5).map do |user|
              li link_to(user.full_name, admin_user_path(user)) unless user.nil?
            end
          end
        end
      end

      column do
        panel 'Recently Created Events' do
          ul do
            Event.last(5).map do |event|
              li link_to(event.title, admin_event_path(event)) unless event.nil?
            end
          end
        end
      end

      column do
        panel 'Info' do
          para 'Welcome to Events@Penn admin'
        end
      end
    end
  end
end
