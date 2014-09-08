class TbAPI < Grape::API
  prefix :api
  version 'v1', using: :header, vendor: 'micro'
  format :json

  resource :user do 

    desc "sign up new user
          sample request: http://domain:port/api/user/signup?email=testuser5@gmail.com&password=testuser&name=testuser
         "
    params do
      requires :email, type: String, desc: "User email which will be used as unique login"
      requires :password, type: String, desc: "User password"
      requires :name, type: String, desc: "User name which will be shown on travel buddy"
    end
    get :signup do
      user = User.new :email=>params[:email], :password=>params[:password], :name=>params[:name]
      if user.save
        return {
          "id" => user.id,
            "email"=>user.email,
            "password" => user.password,
            "name" => user.name,
            "utype" => user.utype,
            "journals" => user.journals
          }
      else
        return user.errors
      end 
    end
  
    desc "signin travel buddy
    sample request: http://domain:port/api/user/signin?email=testuser5@gmail.com&password=testuser
    "
    params do
      requires :email, type: String, desc: "Email or uid from SNS."
      requires :password, type: String, desc: "Travel buddy user password."
    end
    get :signin do
      user = User.authenticate params[:email], params[:password]
      if user
        return {
            "id" => user.id,
            "email"=>user.email,
            "password" => user.password,
            "name" => user.name,
            "utype" => user.utype,
            "journals" => user.journals
          }
      else
        return "error"=>"Invalid credential"
      end
    end
  end


  resource :journal do 

    desc "create new journal
    sample request: http://domain:port/api/journal/create_journal?email=testuser@gmail.com&password=testuser&title=test title&start_time=2014-08-06 15:05:52
    "
    params do
      requires :email, type: String, desc: "User email which will be used as unique login"
      requires :password, type: String, desc: "User password"
      requires :title, type: String, desc: "Journal title, such as 'Trip to Boston'"
      optional :note, type: String, desc: "Journal note, an optional text to describe the journal, such as 'I will go to Boston this Sunday, yeah!'"
      requires :start_time, type: Time, desc: "Journal start time"
      optional :end_time, type: Time, desc: "Journal finish time. It is optional when create new Journal"
    end
    
    get 'create_journal' do
      user = User.authenticate params[:email], params[:password]
      if user
        journal = Journal.create user_id:user.id, title:params[:title], note:params[:note], start_time:params[:start_time], end_time:params[:end_time] 
        return journal
      else
        return {:error=>'Invalid credential'}
      end
    end
  
    desc "get journal information
    sample request: http://domain:port/api/journal?email=testuser@gmail.com&password=testuser&id=3
    "
    params do
      requires :email, type: String, desc: "User email which will be used as unique login"
      requires :password, type: String, desc: "User password"
      requires :id, type: Integer, desc: "Journal id"
    end
    get do
      user = User.authenticate params[:email], params[:password]
      if user
        begin
          journal = Journal.find params[:id]
          return {
            "title"=>journal.title,
            "note" => journal.note,
            "start_time" => journal.start_time,
            "end_time" => journal.end_time,
            "created_at" => journal.created_at,
            "updated_at" => journal.updated_at,
            "checkins" => journal.checkins
          }
        rescue
          return {:error=>'Invalid journal id'}
        end
      else
        return {:error=>'Invalid credential'} 
      end
    end
  end

  resource :checkin do 

    desc "create new checkin
         sample request: http://domain:port/api/checkin/create_checkin?email=testuser@gmail.com&password=testuser&journal_id=3&title=test title&checkin_time=2014-08-06 15:05:52
         "
    params do
      requires :email, type: String, desc: "User email which will be used as unique login"
      requires :password, type: String, desc: "User password"
      requires :journal_id, type: Integer, desc: "Journal id"
      requires :title, type: String, desc: "Journal title, such as 'Trip to Boston'"
      optional :note, type: String, desc: "Journal note, an optional text to describe the journal, such as 'I will go to Boston this Sunday, yeah!'"
      requires :checkin_time, type: Time, desc: "Checkin time"
      optional :longitude, type: String, desc: "Checkin longitude"
      optional :latitude, type: String, desc: "Checkin latitude"
      optional :poi, type: String, desc: "checkin POI"
    end
    
    get 'create_checkin' do
      user = User.authenticate params[:email], params[:password]
      if user
        begin
          journal = Journal.find params[:journal_id]
          checkin = Checkin.create journal_id:params[:journal_id], title:params[:title], note:params[:note], checkin_time:params[:checkin_time], longitude:params[:logitude], latitude:params[:latitude], poi:params[:poi]
          return {:status=>"OK"}
        rescue
          return {:error=>"Invalid journal id #{params[:journal_id]}"}    
        end
      else
        return {:error=>'Invalid credential'}
      end
    end
  
  end
  
  resource :pic do
    desc "upload picture"
    params do
      requires :email, type: String, desc: "User email which will be used as unique login"
      requires :password, type: String, desc: "User password"
      requires :pic, desc: "the picture to be uploaded"
    end
    post 'upload' do
      user = User.authenticate params[:email], params[:password]
      if user
        pic = ActionDispatch::Http::UploadedFile.new(params[:pic])
        return  :url => request.base_url + Pic.upload(pic, user)
      else
        return {:error=>'Invalid credential'}
      end

    end
  end  

end
