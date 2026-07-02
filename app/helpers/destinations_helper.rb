module DestinationsHelper
  REGION_COLOR_COUNT = 8

  def region_color_class(region)
    "region-color-#{region.id % REGION_COLOR_COUNT}"
  end

  def wikivoyage_url(city)
    "https://en.wikivoyage.org/wiki/#{city.tr(' ', '_')}"
  end

  def unique_flags(destination)
    destination.flags.uniq
  end
end
