class EventTracker::Facebook
  def initialize(key)
    @key = key
  end

  def init
    <<-EOD
      !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
      n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
      n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
      t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
      document,'script','https://connect.facebook.net/en_US/fbevents.js');
      fbq('init', '#{@key}');
    EOD
  end

  def track(event_name, properties = {})
    p = properties.empty? ? "" : ", #{properties.to_json}"
    %Q{fbq('trackCustom', '#{event_name}'#{p});}
  end

  def track_pageview
    %Q{fbq('track', 'PageView');}
  end

  def track_page_views_as_events?
    false
  end
end