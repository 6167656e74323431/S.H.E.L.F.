class Book < ApplicationRecord
  validates :title, presence: true
  validates :shelf, presence: true, if: (Proc.new do |b|
    return_val = true
    return_val = false if b.shelf.length != 2
    return_val = false unless b.shelf[0] =~ /[[:alpha:]]/
    return_val = false unless b.shelf[1] =~ /[[:digit:]]/

    errors.add(:shelf, "must be of format [letter][digit]") unless return_val
  end)
end
