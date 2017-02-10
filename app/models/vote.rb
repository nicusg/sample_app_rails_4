class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates_uniqueness_of :user_id, scope: :micropost_id
  validate :cant_vote_own_post

  private

  def cant_vote_own_post
    if user == micropost.user
      errors.add(:micropost, 'belongs to user')
    end
  end
end
