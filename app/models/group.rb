class Group < ApplicationRecord
  after_create_commit { broadcast_prepend_to :groups }
  after_update_commit { broadcast_replace_to "group_#{id}" }
  validates :title, presence: true
end

