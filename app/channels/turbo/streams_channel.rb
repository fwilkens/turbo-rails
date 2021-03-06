# The streams channel delivers all the turbo-stream actions created (primarily) through <tt>Turbo::Broadcastable</tt>.
# A subscription to this channel is made for each individual stream that one wishes to listen for updates to.
# The subscription relies on being passed a <tt>signed_stream_name</tt> parameter generated by turning a set of streamables
# into signed stream name using <tt>Turbo::Streams::StreamName#signed_stream_name</tt>. This is automatically done
# using the view helper <tt>Turbo::StreamsHelper#turbo_stream_from(*streamables)</tt>.
# If the signed stream name cannot be verified, the subscription is rejected.
class Turbo::StreamsChannel < ActionCable::Channel::Base
  extend Turbo::Streams::Broadcasts, Turbo::Streams::StreamName

  def subscribed
    if verified_stream_name = self.class.verified_stream_name(params[:signed_stream_name])
      stream_from verified_stream_name
    else
      reject
    end
  end
end
