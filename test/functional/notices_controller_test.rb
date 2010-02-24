require File.dirname(__FILE__) + '/../test_helper'

class NoticesControllerTest < ActionController::TestCase

  def test_api_v2
    t = Tracker.create(:name => 'Bug')
    p = Project.create(:name => 'Sample Project', :identifier => 'sample-project')


    IssuePriority.create!(:name => 'Normal', :position => 2, :is_default => true)
    IssueStatus.create!(:name => 'New', :is_closed => false, :is_default => true, :position => 1)
    p.trackers << t
    p.save

    Setting.mail_handler_api_enabled = 1
    Setting.mail_handler_api_key = 'secret'

    sample_error = File.read(File.dirname(__FILE__) + '/../fixtures/hoptoad_notification_v2.xml')
    @request.env["RAW_POST_DATA"] = sample_error

    assert_difference 'Issue.count' do
      post :create
      assert assigns(:xml)
    end

    @issue = Issue.find(:first, :order => 'id DESC')

    assert_equal 'Special Error in vendor/plugins/hoptoad_notifier/lib/hoptoad_notifier.rb:136', @issue.subject
    assert_equal 'Redmine Notifier reported an Error related to source: /my_app/vendor/plugins/hoptoad_notifier/lib/hoptoad_notifier.rb#L136', @issue.description

    assert_equal 1, @issue.journals.size
    @journal = @issue.journals.first
    assert_match /Special Error/, @journal.notes, "Missing Error message"
  end

  # TODO:
  def test_api_v1
  end
end
