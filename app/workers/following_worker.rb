# -*- encoding : utf-8 -*-

class FollowingWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'often'

  def perform(user_id)
    user = User.find(user_id)
    followings = user.prepare_followings
    if followings.size > 0
      user.update_attribute(:followings_count, followings.size)
      user.prepare_skips
      followings.each do |following|
        RepoWorker.perform_async(user.id, following.id)
      end
    else
      user.update_attribute(:processed_at, nil)
    end
  end
end
