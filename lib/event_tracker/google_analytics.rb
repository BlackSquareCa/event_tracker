class EventTracker::GoogleAnalytics
  def initialize(key)
    @key = key
  end

  def init
    <<-EOD
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
      ga('create', '#{@key}', 'auto', {'name': 'event_tracker'});
      ga('require', 'linkid');
      ga('event_tracker.require', 'displayfeatures');
    EOD
  end

  def identify(distinct_id)
    %Q{ga('set', 'userId', "#{distinct_id}");}
  end

  def track(event_name, properties = {})
    %Q{ga('event_tracker.send', 'event', 'event_tracker', '#{event_name}');}
  end

  def track_pageview
    %Q{ga('event_tracker.send', 'pageview', window.location.pathname);}
  end

  def track_page_views_as_events?
    true
  end
end