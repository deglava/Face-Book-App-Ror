class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end


  def password=(new_password)
    @password = Password.create(new_password)
  end

  EMAIL_REGEX =  /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :f_name, :presence => true, length: {minimum: 2}
  validates :l_name, :presence => true, length: {minimum: 2}
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create
  validates :birthday, :presence => true
  validates :gender, :presence => true
end

