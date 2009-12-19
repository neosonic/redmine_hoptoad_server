require File.dirname(__FILE__) + '/../test_helper'

class NoticesControllerTest < ActionController::TestCase

  def test_api_v2
    t = Tracker.create(:name => 'Bug')
    p = Project.create(:name => 'Sample Project', :identifier => 'sample-project')


    IssuePriority.create!(:opt => "IPRI", :name => 'Normal', :position => 2, :is_default => true)
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
  end

  # TODO:
  def test_api_v1
  end
end
