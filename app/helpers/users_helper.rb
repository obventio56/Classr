module UsersHelper
  def functionality_path(user)
    case user.functionality_type
      when 'principal'
        return school_path(Principal.find(user.functionality_id).school_id)
      else
        root_path
    end
  end
  def new_functionality_path(user)
    case user.functionality_type
      when 'teacher'
        return :controller => 'teachers', :action => 'new', :user_id => user.id
      when 'counselor'
        return :controller => 'counselors', :action => 'new', :user_id => user.id
      when 'student'
        return :controller => 'students', :action => 'new', :user_id => user.id
      else
        return root_path
    end
  end
  def create_functionality_path(user)
    logger.info user.functionality_type
    case user.functionality_type
      when 'teacher'
        return :controller => 'teachers', :action => 'create', :user_id => user.id
      when 'counselor'
        return :controller => 'counselors', :action => 'create', :user_id => user.id
      when 'student'
        return :controller => 'students', :action => 'create', :user_id => user.id
      else
        logger.info 'redirected to root'
        return root_path
    end
  end

end
