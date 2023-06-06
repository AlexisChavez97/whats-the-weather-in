# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :weather_reports, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
