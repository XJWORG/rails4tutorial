class Micropost < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 140 }
    default_scope  { order("created_at desc")}

    def self.from_users_followed_by(user)
        followed_user_ids = "Select followed_id from relationships where follower_id = :user_id"
        # where("user_id IN (?) OR user_id= ?", followed_user_ids, user)
        # where("user_id In (:followed_user_ids) OR user_id = :user_id ",followed_user_ids: followed_user_ids, user_id: user)
        # 更高效的内置方法
        where("user_id in (#{followed_user_ids}) Or user_id = :user_id ", user_id: user.id)
    end
end
