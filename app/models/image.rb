class Image < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :album

  has_attached_file :image, styles: { large: "1400x1400", medium: "900x900", thumb: "450x450"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.search(search)
    # if search is not empty
    if search
      self.where("title LIKE ?", "%#{search}%")
    # if search is empty return all
    else
      self.all
    end
  end
end
