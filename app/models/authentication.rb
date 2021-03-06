class Authentication < ActiveRecord::Base
  belongs_to :person
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.new_from_auth_hash(auth_hash)
    new(:provider => auth_hash['provider'],
          :uid => auth_hash['uid'],
          :token => (auth_hash['credentials']['token'] if auth_hash['credentials']))
  end

  def self.find_from_auth_hash(auth_hash)
    find_by_provider_and_uid( auth_hash['provider'], auth_hash['uid'])
  end

  def self.email_from_auth_hash(auth_hash)
    auth_hash && auth_hash['info'] && auth_hash['info']['email'] && auth_hash['info']['email'].to_s.downcase.strip
  end

end
