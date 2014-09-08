class Pic
  require 'securerandom'
  REPO_BASE = "#{Rails.root}/public"
  
  #upload picture for user as specified in parameters
  def self.upload(pic, user)
    file_name = get_rand_name
    
    file_name_with_ext = "#{file_name}.#{get_ext(pic.original_filename)}"
    
    relative_path = "/pics/#{user.id}/#{file_name_with_ext}"
    #if the folder does not exists, create the folder
    folder = "#{Pic::REPO_BASE}/pics/#{user.id}"
    unless File.exists? folder
      FileUtils.mkdir folder
    end
    
    
    File.open("#{Pic::REPO_BASE}#{relative_path}", "wb+") do |f|
      f.write(pic.read)
    end
    return relative_path 
  end
  
  

  def self.get_rand_name
    return SecureRandom.hex(20)
  end
  
  def self.get_ext file_name
    rindex = file_name.rindex(".")
    if rindex
      file_name[(rindex+1)..-1]
    end
  end
    
end