require "test_helper"

class DestinationsControllerTest < ActionDispatch::IntegrationTest
  test "home page renders" do
    get root_path
    assert_response :success
    assert_select "h1", "Destination Selector"
  end

  test "index lists every destination" do
    get destinations_path
    assert_response :success
    assert_select ".destination-card", Destination.count
    assert_select ".destination-card__name", text: "Bajío"
    assert_select ".destination-card__name", text: "Pyrenees"
  end

  test "show renders a destination with its languages and cities" do
    get destination_path(destinations(:pyrenees))
    assert_response :success
    assert_select "h1", /Pyrenees/
    assert_select ".destination-hero__languages", /Languages:\s+French & Spanish/
    assert_select ".city-chip", 2
  end

  test "show returns 404 for an unknown destination" do
    get destination_path(id: 0)
    assert_response :not_found
    assert_select "h1", /Destination Not Found/
  end

  test "select redirects to a random destination" do
    get select_path
    assert_response :redirect
    assert_match %r{/destinations/\d+\z}, response.location
    follow_redirect!
    assert_response :success
  end
end
