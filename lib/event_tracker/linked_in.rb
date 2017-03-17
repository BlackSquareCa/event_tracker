class EventTracker::LinkedIn
  def initialize(key)
    @key = key
  end

  def init
    <<-EOD
      _linkedin_data_partner_id = "#{@key}";
      (function(){var s = document.getElementsByTagName("script")[0];
      var b = document.createElement("script");
      b.type = "text/javascript";b.async = true;
      b.src = "https://snap.licdn.com/li.lms-analytics/insight.min.js";
      s.parentNode.insertBefore(b, s);})();
    EOD
  end

  def track_page_views_as_events?
    false
  end
end