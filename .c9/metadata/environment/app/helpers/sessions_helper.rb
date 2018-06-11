<<<<<<< HEAD
{"filter":false,"title":"sessions_helper.rb","tooltip":"/app/helpers/sessions_helper.rb","undoManager":{"mark":13,"position":13,"stack":[[{"start":{"row":3,"column":31},"end":{"row":4,"column":0},"action":"insert","lines":["",""],"id":112},{"start":{"row":4,"column":0},"end":{"row":4,"column":4},"action":"insert","lines":["    "]}],[{"start":{"row":4,"column":4},"end":{"row":4,"column":35},"action":"insert","lines":["session[:user_role] = user.role"],"id":113}],[{"start":{"row":18,"column":28},"end":{"row":19,"column":0},"action":"insert","lines":["",""],"id":114},{"start":{"row":19,"column":0},"end":{"row":19,"column":4},"action":"insert","lines":["    "]}],[{"start":{"row":19,"column":4},"end":{"row":19,"column":30},"action":"insert","lines":["session.delete(:user_role)"],"id":115}],[{"start":{"row":19,"column":30},"end":{"row":19,"column":32},"action":"insert","lines":["  "],"id":116}],[{"start":{"row":19,"column":32},"end":{"row":19,"column":34},"action":"insert","lines":["  "],"id":117}],[{"start":{"row":21,"column":5},"end":{"row":22,"column":0},"action":"insert","lines":["",""],"id":118},{"start":{"row":22,"column":0},"end":{"row":22,"column":2},"action":"insert","lines":["  "]},{"start":{"row":22,"column":2},"end":{"row":23,"column":0},"action":"insert","lines":["",""]},{"start":{"row":23,"column":0},"end":{"row":23,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":23,"column":2},"end":{"row":24,"column":0},"action":"insert","lines":["",""],"id":122},{"start":{"row":24,"column":0},"end":{"row":24,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":23,"column":2},"end":{"row":63,"column":5},"action":"insert","lines":["def current_user?(user)","      user == current_user","  end","  ","  # Redirects to stored location (or to the default).","  def redirect_back_or(default)","      redirect_to(session[:forwarding_url] || default)","      session.delete(:forwarding_url)","  end","  ","  # Stores the URL trying to be accessed.","  def store_location","      session[:forwarding_url] = request.original_url if request.get?","  end","  ","  # Confirms a logged-in user.","  def logged_in_user","    unless logged_in?","      store_location","      flash[:danger] = \"Please log in.\"","      redirect_to login_url","    end","  end","  ","  # Confirms the correct user.","  def correct_user","    # @user = User.find(session[:user_id])","    unless (isAdmin? || isSuperAdmin?)","      if params[:id] == nil","        flash[:danger] = \"You're not valid to perform such operations. Please login as Admin or SuperAdmin to move on.\"","        redirect_to login_url","        return","      end","      @user = User.find(params[:id])","      unless current_user?(@user)","        flash[:danger] = \"You cannot view or edit other user's info.\"","        redirect_to current_user","        return","      end","    end","  end"],"id":126}],[{"start":{"row":4,"column":2},"end":{"row":5,"column":2},"action":"remove","lines":["  session[:user_role] = user.role","  "],"id":127,"ignore":true},{"start":{"row":18,"column":4},"end":{"row":63,"column":2},"action":"remove","lines":["session.delete(:user_role)    ","    @current_user = nil","  end","  ","  def current_user?(user)","      user == current_user","  end","  ","  # Redirects to stored location (or to the default).","  def redirect_back_or(default)","      redirect_to(session[:forwarding_url] || default)","      session.delete(:forwarding_url)","  end","  ","  # Stores the URL trying to be accessed.","  def store_location","      session[:forwarding_url] = request.original_url if request.get?","  end","  ","  # Confirms a logged-in user.","  def logged_in_user","    unless logged_in?","      store_location","      flash[:danger] = \"Please log in.\"","      redirect_to login_url","    end","  end","  ","  # Confirms the correct user.","  def correct_user","    # @user = User.find(session[:user_id])","    unless (isAdmin? || isSuperAdmin?)","      if params[:id] == nil","        flash[:danger] = \"You're not valid to perform such operations. Please login as Admin or SuperAdmin to move on.\"","        redirect_to login_url","        return","      end","      @user = User.find(params[:id])","      unless current_user?(@user)","        flash[:danger] = \"You cannot view or edit other user's info.\"","        redirect_to current_user","        return","      end","    end","  end","  "]},{"start":{"row":18,"column":4},"end":{"row":19,"column":5},"action":"insert","lines":["@current_user = nil","  end"]}],[{"start":{"row":4,"column":2},"end":{"row":5,"column":2},"action":"insert","lines":["  session[:user_role] = user.role","  "],"id":128,"ignore":true},{"start":{"row":19,"column":4},"end":{"row":20,"column":5},"action":"remove","lines":["@current_user = nil","  end"]},{"start":{"row":19,"column":4},"end":{"row":64,"column":2},"action":"insert","lines":["session.delete(:user_role)    ","    @current_user = nil","  end","  ","  def current_user?(user)","      user == current_user","  end","  ","  # Redirects to stored location (or to the default).","  def redirect_back_or(default)","      redirect_to(session[:forwarding_url] || default)","      session.delete(:forwarding_url)","  end","  ","  # Stores the URL trying to be accessed.","  def store_location","      session[:forwarding_url] = request.original_url if request.get?","  end","  ","  # Confirms a logged-in user.","  def logged_in_user","    unless logged_in?","      store_location","      flash[:danger] = \"Please log in.\"","      redirect_to login_url","    end","  end","  ","  # Confirms the correct user.","  def correct_user","    # @user = User.find(session[:user_id])","    unless (isAdmin? || isSuperAdmin?)","      if params[:id] == nil","        flash[:danger] = \"You're not valid to perform such operations. Please login as Admin or SuperAdmin to move on.\"","        redirect_to login_url","        return","      end","      @user = User.find(params[:id])","      unless current_user?(@user)","        flash[:danger] = \"You cannot view or edit other user's info.\"","        redirect_to current_user","        return","      end","    end","  end","  "]}],[{"start":{"row":64,"column":2},"end":{"row":66,"column":5},"action":"insert","lines":["def isCustomer?","    session[:user_role] == 'Customer'","  end"],"id":129}],[{"start":{"row":49,"column":42},"end":{"row":50,"column":38},"action":"remove","lines":["","    unless (isAdmin? || isSuperAdmin?)"],"id":133}],[{"start":{"row":61,"column":6},"end":{"row":61,"column":7},"action":"remove","lines":["d"],"id":134},{"start":{"row":61,"column":5},"end":{"row":61,"column":6},"action":"remove","lines":["n"]},{"start":{"row":61,"column":4},"end":{"row":61,"column":5},"action":"remove","lines":["e"]},{"start":{"row":61,"column":2},"end":{"row":61,"column":4},"action":"remove","lines":["  "]},{"start":{"row":61,"column":0},"end":{"row":61,"column":2},"action":"remove","lines":["  "]},{"start":{"row":60,"column":9},"end":{"row":61,"column":0},"action":"remove","lines":["",""]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":7,"column":3},"end":{"row":7,"column":9},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":135,"mode":"ace/mode/ruby"}},"timestamp":1527176211585,"hash":"fa119f2c1cab2c0468401461aea556175c82d0d6"}
=======
{"filter":false,"title":"sessions_helper.rb","tooltip":"/app/helpers/sessions_helper.rb","undoManager":{"mark":16,"position":16,"stack":[[{"start":{"row":4,"column":2},"end":{"row":5,"column":2},"action":"insert","lines":["  session[:user_role] = user.role","  "],"id":3,"ignore":true},{"start":{"row":19,"column":4},"end":{"row":20,"column":5},"action":"remove","lines":["@current_user = nil","  end"]},{"start":{"row":19,"column":4},"end":{"row":64,"column":2},"action":"insert","lines":["session.delete(:user_role)    ","    @current_user = nil","  end","  ","  def current_user?(user)","      user == current_user","  end","  ","  # Redirects to stored location (or to the default).","  def redirect_back_or(default)","      redirect_to(session[:forwarding_url] || default)","      session.delete(:forwarding_url)","  end","  ","  # Stores the URL trying to be accessed.","  def store_location","      session[:forwarding_url] = request.original_url if request.get?","  end","  ","  # Confirms a logged-in user.","  def logged_in_user","    unless logged_in?","      store_location","      flash[:danger] = \"Please log in.\"","      redirect_to login_url","    end","  end","  ","  # Confirms the correct user.","  def correct_user","    # @user = User.find(session[:user_id])","    unless (isAdmin? || isSuperAdmin?)","      if params[:id] == nil","        flash[:danger] = \"You're not valid to perform such operations. Please login as Admin or SuperAdmin to move on.\"","        redirect_to login_url","        return","      end","      @user = User.find(params[:id])","      unless current_user?(@user)","        flash[:danger] = \"You cannot view or edit other user's info.\"","        redirect_to current_user","        return","      end","    end","  end","  "]}],[{"start":{"row":46,"column":2},"end":{"row":47,"column":0},"action":"insert","lines":["",""],"id":4},{"start":{"row":47,"column":0},"end":{"row":47,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":47,"column":2},"end":{"row":47,"column":3},"action":"insert","lines":["d"],"id":5},{"start":{"row":47,"column":3},"end":{"row":47,"column":4},"action":"insert","lines":["e"]},{"start":{"row":47,"column":4},"end":{"row":47,"column":5},"action":"insert","lines":["f"]}],[{"start":{"row":47,"column":5},"end":{"row":47,"column":6},"action":"insert","lines":[" "],"id":6},{"start":{"row":47,"column":6},"end":{"row":47,"column":7},"action":"insert","lines":["c"]},{"start":{"row":47,"column":7},"end":{"row":47,"column":8},"action":"insert","lines":["o"]},{"start":{"row":47,"column":8},"end":{"row":47,"column":9},"action":"insert","lines":["r"]},{"start":{"row":47,"column":9},"end":{"row":47,"column":10},"action":"insert","lines":["r"]},{"start":{"row":47,"column":10},"end":{"row":47,"column":11},"action":"insert","lines":["e"]}],[{"start":{"row":47,"column":6},"end":{"row":47,"column":11},"action":"remove","lines":["corre"],"id":7},{"start":{"row":47,"column":6},"end":{"row":48,"column":2},"action":"insert","lines":["correct_user","  "]}],[{"start":{"row":48,"column":0},"end":{"row":48,"column":2},"action":"remove","lines":["  "],"id":8},{"start":{"row":47,"column":18},"end":{"row":48,"column":0},"action":"remove","lines":["",""]}],[{"start":{"row":47,"column":18},"end":{"row":47,"column":19},"action":"insert","lines":["?"],"id":9}],[{"start":{"row":47,"column":19},"end":{"row":47,"column":21},"action":"insert","lines":["()"],"id":10}],[{"start":{"row":47,"column":20},"end":{"row":47,"column":21},"action":"insert","lines":["u"],"id":11},{"start":{"row":47,"column":21},"end":{"row":47,"column":22},"action":"insert","lines":["s"]},{"start":{"row":47,"column":22},"end":{"row":47,"column":23},"action":"insert","lines":["e"]},{"start":{"row":47,"column":23},"end":{"row":47,"column":24},"action":"insert","lines":["r"]}],[{"start":{"row":47,"column":25},"end":{"row":48,"column":0},"action":"insert","lines":["",""],"id":12},{"start":{"row":48,"column":0},"end":{"row":48,"column":4},"action":"insert","lines":["    "]}],[{"start":{"row":48,"column":4},"end":{"row":48,"column":5},"action":"insert","lines":["u"],"id":13},{"start":{"row":48,"column":5},"end":{"row":48,"column":6},"action":"insert","lines":["s"]},{"start":{"row":48,"column":6},"end":{"row":48,"column":7},"action":"insert","lines":["e"]},{"start":{"row":48,"column":7},"end":{"row":48,"column":8},"action":"insert","lines":["r"]},{"start":{"row":48,"column":8},"end":{"row":48,"column":9},"action":"insert","lines":["="]},{"start":{"row":48,"column":9},"end":{"row":48,"column":10},"action":"insert","lines":["="]}],[{"start":{"row":48,"column":8},"end":{"row":48,"column":9},"action":"insert","lines":[" "],"id":14}],[{"start":{"row":48,"column":11},"end":{"row":48,"column":12},"action":"insert","lines":[" "],"id":15},{"start":{"row":48,"column":12},"end":{"row":48,"column":13},"action":"insert","lines":["c"]},{"start":{"row":48,"column":13},"end":{"row":48,"column":14},"action":"insert","lines":["u"]},{"start":{"row":48,"column":14},"end":{"row":48,"column":15},"action":"insert","lines":["r"]}],[{"start":{"row":48,"column":12},"end":{"row":48,"column":15},"action":"remove","lines":["cur"],"id":16},{"start":{"row":48,"column":12},"end":{"row":49,"column":4},"action":"insert","lines":["current_user","    "]}],[{"start":{"row":49,"column":2},"end":{"row":49,"column":4},"action":"remove","lines":["  "],"id":17}],[{"start":{"row":49,"column":2},"end":{"row":49,"column":3},"action":"insert","lines":["e"],"id":18},{"start":{"row":49,"column":3},"end":{"row":49,"column":4},"action":"insert","lines":["n"]},{"start":{"row":49,"column":4},"end":{"row":49,"column":5},"action":"insert","lines":["d"]}],[{"start":{"row":49,"column":2},"end":{"row":49,"column":5},"action":"remove","lines":["end"],"id":19},{"start":{"row":49,"column":2},"end":{"row":49,"column":5},"action":"insert","lines":["end"]}],[{"start":{"row":49,"column":5},"end":{"row":50,"column":0},"action":"insert","lines":["",""],"id":20},{"start":{"row":50,"column":0},"end":{"row":50,"column":2},"action":"insert","lines":["  "]}]]},"ace":{"folds":[],"scrolltop":559,"scrollleft":0,"selection":{"start":{"row":49,"column":2},"end":{"row":49,"column":5},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1526427397099,"hash":"4ec6edfd2851b60a21791733843694c3bfd94e72"}
>>>>>>> markers_googlemaps
