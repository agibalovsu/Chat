class Message < ApplicationRecord
	belongs_to :group

	after_create_commit { broadcast_prepend_to :messagess }
  after_update_commit { broadcast_replace_to "message_#{id}" }
	validates :title, presence: true
end
