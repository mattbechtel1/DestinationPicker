require "test_helper"

class DestinationTest < ActiveSupport::TestCase
  test "cities splits the slash-delimited city column" do
    assert_equal [ "León", "Querétaro", "Guanajuato" ], destinations(:bajio).cities
  end

  test "languages lists only the primary language when there is no secondary" do
    assert_equal [ languages(:spanish) ], destinations(:bajio).languages
  end

  test "languages lists primary then secondary" do
    assert_equal [ languages(:french), languages(:spanish) ], destinations(:pyrenees).languages
  end

  test "flags repeats the primary flag when there is no secondary" do
    assert_equal [ flags(:mx), flags(:mx) ], destinations(:bajio).flags
  end

  test "flags lists primary then secondary" do
    assert_equal [ flags(:fr), flags(:es) ], destinations(:pyrenees).flags
  end

  test "select_random returns an existing destination" do
    assert_includes Destination.all, Destination.select_random
  end
end
