enable :sessions

get '/' do
  if session[:user_id]
    redirect to('/welcome_back')
  else
  erb :index
  end
end

post '/sign_up' do 

@user = User.create(params[:post])
session[:user_id] = @user.id
erb :welcome_back
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/create_event' do

  erb :create_event

end

get '/welcome_back' do
  @user = User.find(session[:user_id])
  erb :welcome_back
end

get '/delete_event' do
  erb :delete_event
end

post '/delete_event' do
  @user = User.find(session[:user_id])
  @event = @user.created_events.find_by_name(params[:delete_this])
  @event.destroy
  redirect to('welcome_back')
end

post '/create_event' do
  @event =Event.create(name: params[:name], location: params[:location], starts_at: params[:starts_at], ends_at: params[:ends_at], user_id: params[:user_id])
  return "Name: #{params[:name]}<br/>Location: #{params[:location]}
  <a href='/edit_event/#{@event.id}'>Edit this</a><br/><br/>"
end

get '/edit_event/:event_id' do
  @this_event = Event.find(params[:event_id])
  erb :edit_event
end

post '/edit_event' do
  @this_event = Event.find(params[:event_id])
  @this_event.update_attributes(name: params[:name], location: params[:location], starts_at: params[:starts_at], ends_at: params[:ends_at])
  redirect to('/welcome_back')
end

post '/login' do
 @email = params[:email]
 @user = User.find_by_email(@email)

 if @user
   if @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to "/welcome_back"
 else
    redirect to('/')
  end
end
end
