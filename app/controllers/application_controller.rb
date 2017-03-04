#all methods available for entire app
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #prevent user from visiting a page without logging in
  # if no user in session, redirect to root route
  def require_login
    if session[:donor_id]
      # binding.pry
      redirect_to '/' if session[:donor_id] == nil
    end
    if session[:charityRep_id]
      redirect to '/' if session[:charityRep_id] == nil
    end
  end

  #confirm if current user is the user who completes various actions in the app
  #if the users don't match, redirect to root route
  def require_correct_user
    if session[:donor_id]
      user = Donor.find(params[:id])
    end
    if session[:charityRep_id]
      user =  CharityRep.find(params[:id])
      # binding.pry - adds a breakpoint to debug in console
    end
    redirect_to "/" if current_user != user || current_user == nil
  end


#initialize various flash error messages
def initialize_donorRegErrors_flash
  if !flash[:donor_reg_errors]
    flash[:donor_reg_errors] = []
  end
end

def initialize_charityRepRegErrors_flash
  if !flash[:charityRep_reg_errors]
    flash[:charityRep_reg_errors] = []
  end
end

def initialize_loginErrors_flash
  if !flash[:login_errors]
     flash[:login_errors] = []
   end
end

def initialize_donationErrors_flash
  if !flash[:donation_errors]
    flash[:donation_errors] = []
  end
end

#set current user. Finds user with session[:id] in db
  def current_user
    if session[:donor_id]
      return Donor.find(session[:donor_id])
    end
    if session[:charityRep_id]
      return CharityRep.find(session[:charityRep_id])
    end
  end

  helper_method :current_user
end
