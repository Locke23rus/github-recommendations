# -*- encoding : utf-8 -*-

class FollowingWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'often'

  def perform(user_id)
    user = User.find(user_id)
    user.prepare_skips
    user.prepare_followings.each do |following|
      RepoWorker.perform_async(user.id, following.id)
    end
  end
end
