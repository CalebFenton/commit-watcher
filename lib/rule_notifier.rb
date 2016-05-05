require 'json'
require 'time'
require_relative "#{Rails.root}/app/mailers/notification_mailer"

class RuleNotifier
  def self.notify_if_necessary(target, project_id, commit_hash, audit_result)
    return unless rule[:notification_id]

    # rule - {:name=>"markdown_file", :rule_type_id=>1, :value=>"(?i)\\.(md|markdown)\\z", :notification_id=>'asdf'}
    # commit - {:sha=>"6a1573e9cc4283eadb75b89b0f824fb9f3fe581f", :commit=>{:message=>"Add tetcon 2016 preso", :author=>{:name=>"Caleb Fenton", :email=>"calebjfenton@gmail.com", :date=>"2016-01-03T19:14:22.000-08:00"}, :committer=>{:name=>"Caleb Fenton", :email=>"calebjfenton@gmail.com", :date=>"2016-01-03T19:14:22.000-08:00"}}}
    notification = Notifications[id: rule[:notification_id]]
    NotificationMailer.notification(notification.target, project_id, rule[:name], commit_hash).deliver_now
  end
end
