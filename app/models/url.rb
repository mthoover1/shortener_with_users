class Url < ActiveRecord::Base
  before_save :shorten_url

  validates :original_url, presence: true
  validate :valid_url


  def clicked
    update_column(:click_count, self.click_count + 1)
  end


  private

  def shorten_url
    short = generate_short
    while Url.find_by_short_url(short)
      short = generate_short
    end
    self.short_url = short
  end

  def generate_short
    SecureRandom.hex(3)
  end

  def valid_url
    unless self.original_url =~ URI.regexp
      self.errors.add(:url, "Your url is not valid")
    end
  end
end
