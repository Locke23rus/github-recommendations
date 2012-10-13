class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :uid, :presence => true, :uniqueness => true
  validates :login, :presence => true, :uniqueness => true

  def self.create_with_omniauth!(auth)
    create! do |user|
      user.uid = auth[:uid]
      user.login = auth[:info][:nickname]
      user.email = auth[:info][:email]
      user.full_name = auth[:info][:name]
      user.avatar_url = auth[:info][:image]
      user.token = auth[:credentials][:token]
      user.followings_count = auth[:extra][:raw_info][:following]
      user.repos_count = auth[:extra][:raw_info][:public_repos]
      user.authorized_at = DateTime.current
    end
  end

end
