class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :emails, dependent: :destroy

  belongs_to :account

  has_many :notifications, dependent: :destroy

  accepts_nested_attributes_for :account

  after_create_commit :generate_alias

  def generate_alias
    email_alias = "#{email.split('@')[0]}-#{id[0...4]}"
    update_column(:email_alias, email_alias)
  end
end
