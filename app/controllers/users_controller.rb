class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
     @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Welcome! User was successfully created."
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if (params[:plan_id] != nil)
      if (@user.plans.count != 0)
        @user.plans.delete(@user.plans.all.first.id)
        @user.plans << Plan.find_by(id:params[:plan_id])
      else
        @user.plans << Plan.find_by(id:params[:plan_id])
      end
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user.destroy
    if (User.find(params[:id])==current_user)
        User.find(params[:id]).destroy
        flash[:success] = "User deleted"
    end
    redirect_to users_url

  end


  def add_plan
      @user=current_user
      if @user.plans.find_by(id:params.fetch("plan").fetch("name")).nil?
          @user.plans << Plan.find_by(id:params.fetch("plan").fetch("name"))
      end
      respond_to do |format|
          format.js
      end
  end

  def remove_plan
      @user=current_user
      plan=@user.plans.find_by(id:params.fetch("plan_id"))
      unless plan.nil?
          @user.plans.delete(plan)
      end
      respond_to do |format|
          format.js
      end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :contact_id, :password, :password_confirmation, :picture, :plan_name)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to logs_path
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
