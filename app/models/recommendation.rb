class Recommendation < ActiveRecord::Base

  belongs_to :user
  belongs_to :repo
  has_many :scores, :dependent => :delete_all

  validates :user_id, :presence => true, :uniqueness => { :scope => :repo_id }
  validates :repo_id, :presence => true

  SKIP_TYPES = {
    :user => 1,
    :auto => 2
  }

  scope :skipped, where(:skip => true)
  scope :autoskipped, skipped.where(:skip_type => SKIP_TYPES[:auto])
  scope :available, where(:skip => false).order('score DESC')

  def prepare_score
    transaction do
      self.scores.delete_all

      user_ids = by_owner(self.user.following_ids)
      user_ids = by_collaborators(user_ids)
      user_ids = by_forks(user_ids)
      by_stars(user_ids)

      self.score = self.scores.inject(0) {|sum, score| sum + score.value }
      self.save!
    end
  end

  def by_owner(user_ids)
    owner_id = (user_ids & [self.repo.owner_id]).first
    if owner_id.present?
      self.scores.build do |score|
        score.action = 0
        score.user_id = owner_id
      end
    end
    user_ids - [owner_id]
  end

  def by_collaborators(user_ids)
    collaborator_ids = user_ids & self.repo.collaborator_ids(self.user)

    collaborator_ids.each do |user_id|
      self.scores.build do |score|
        score.action = 1
        score.user_id = user_id
      end
    end

    user_ids - collaborator_ids
  end

  def by_forks(user_ids)
    owner_ids = user_ids & self.repo.forks_owner_ids(user)

    owner_ids.each do |user_id|
      self.scores.build do |score|
        score.action = 2
        score.user_id = user_id
      end
    end

    user_ids - owner_ids
  end

  def by_stars(user_ids)
    stargazer_ids = user_ids & self.repo.stargazers_ids(user)

    stargazer_ids.each do |user_id|
      self.scores.build do |score|
        score.action = 3
        score.user_id = user_id
      end
    end

    user_ids - stargazer_ids
  end

  def prepare(user, repo)
    self.user = user
    self.repo = repo
    save
  end

  def scores_by_group
    scores.group_by(&:action_name)
  end

end
