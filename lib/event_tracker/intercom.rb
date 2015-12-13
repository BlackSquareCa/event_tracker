class EventTracker::Intercom
  def initialize(key)
    @key = key
  end

  def init
    s = <<-EOD
      (function(){var w=window;var ic=w.Intercom;if(typeof ic==="function"){ic('reattach_activator');ic('update',intercomSettings);}else{var d=document;var i=function(){i.c(arguments)};i.q=[];i.c=function(args){i.q.push(args)};w.Intercom=i;function l(){var s=d.createElement('script');s.type='text/javascript';s.async=true;s.src='https://widget.intercom.io/widget/#{@key}';var x=d.getElementsByTagName('script')[0];x.parentNode.insertBefore(s,x);}if(w.attachEvent){w.attachEvent('onload',l);}else{w.addEventListener('load',l,false);}}})();
    EOD
  end

  def boot(properties = {})
    properties.merge!(app_id: @key)
    %Q{window.Intercom('boot', #{properties.to_json});}
  end

  def update(properties = {})
    p = properties.empty? ? '' : ", #{properties.to_json}"
    %Q{window.Intercom('update'#{p});}
  end

  def shutdown
    %Q{window.Intercom('shutdown');}
  end

  def show
    %Q{window.Intercom('show');}
  end

  def show_messages
    %Q{window.Intercom('showMessages');}
  end

  def show_new_message(message = nil)
    m = message.empty? ? '' : ", '#{message}'"
    %Q{window.Intercom('showNewMessage'#{m});}
  end

  def track(event_name, properties)
    p = properties.empty? ? '' : ", #{properties.to_json}"
    %Q{window.Intercom('trackEvent', "#{event_name}"#{p});}
  end

  def track_page_views_as_events?
    false
  end
end