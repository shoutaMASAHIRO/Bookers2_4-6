class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  validates :title, presence: true 
  validates :body, presence: true, length: {maximum: 200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(method, word)
    case method
    when "perfect"
      where(title: word)
    when "forward"
      where("title LIKE ?", "#{word}%")
    when "backward"
      where("title LIKE ?", "%#{word}")
    when "partial"
      where("title LIKE ?", "%#{word}%")
    end
  end

  def self.search_for(word, method)
    case method
    when 'perfect'
      where(title: word)
    when 'forward'
      where('title LIKE ?', "#{word}%")
    when 'backward'
      where('title LIKE ?', "%#{word}")
    when 'partial'
      where('title LIKE ?', "%#{word}%")
    end
  end
end
