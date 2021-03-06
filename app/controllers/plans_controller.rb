class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    unless current_user.nil?
        @plan.users << current_user
    end
    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calculate
      @plan=set_plan
      copay=@plan.copays.find_by(treatment_id:params.fetch("treatment").fetch("name"))
      @patient_pay=@plan.calculate(params[:price].to_f,params[:deductible].to_f,params[:network],copay)
      session[:answer] = @patient_pay
      session[:note]=copay.note
      respond_to do |format|
          format.js
      end
      # respond_to do |format|
      #   format.js {
      #     render json: {
      #       content: (render_to_string partial: 'result', layout: false )
      #     }
      #   }
      # end
      # redirect_to calculate_path
  end

  def showcalc
    render :partial => "showcalc"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
        params.require(:plan).permit(:name, :category, :company_id, :in_deductible, :out_deductible, :out_of_pocket_max, :inpatient_copay, :outpatient_copay)
    end
end
