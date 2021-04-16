require "application_system_test_case"

class FollowRequestsTest < ApplicationSystemTestCase
  setup do
    @follow_request = follow_requests(:one)
  end

  test "visiting the index" do
    visit follow_requests_url
    assert_selector "h1", text: "Follow Requests"
  end

  test "creating a Follow request" do
    visit follow_requests_url
    click_on "New Follow Request"

    fill_in "Recipient", with: @follow_request.recipient_id
    fill_in "Sender", with: @follow_request.sender_id
    fill_in "Status", with: @follow_request.status
    click_on "Create Follow request"

    assert_text "Follow request was successfully created"
    click_on "Back"
  end

  test "updating a Follow request" do
    visit follow_requests_url
    click_on "Edit", match: :first

    fill_in "Recipient", with: @follow_request.recipient_id
    fill_in "Sender", with: @follow_request.sender_id
    fill_in "Status", with: @follow_request.status
    click_on "Update Follow request"

    assert_text "Follow request was successfully updated"
    click_on "Back"
  end

  test "destroying a Follow request" do
    visit follow_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Follow request was successfully destroyed"
  end
end
