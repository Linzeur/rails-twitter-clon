class RepliesController < ApplicationController
  def index
    Tweet.where.not("tweet_id"=> nil)
    render nothing: true, status: :ok
  end
  def
  end
end

