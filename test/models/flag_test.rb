require "test_helper"

class FlagTest < ActiveSupport::TestCase
  test "get_flag_emoji converts the ISO code to regional indicator entities" do
    # M (77) and X (88) offset by 127397 give the regional indicators for 🇲🇽.
    assert_equal "&#127474;&#127485;", flags(:mx).get_flag_emoji
  end
end
