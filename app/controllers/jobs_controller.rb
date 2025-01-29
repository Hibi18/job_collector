class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]

  def index
    @jobs = Job.all
  
    # キーワード検索（職種）
    if params[:search].present?
      @jobs = @jobs.where('title LIKE ?', "%#{params[:search]}%")
    end
  
    # 勤務地検索
    if params[:location].present?
      @jobs = @jobs.where(location: params[:location])
    end
  
    # 給与範囲検索
    if params[:min_salary].present?
      @jobs = @jobs.where("salary >= ?", params[:min_salary].to_i * 1_000_000)
    end
    if params[:max_salary].present?
      @jobs = @jobs.where("salary <= ?", params[:max_salary].to_i * 1_000_000)
    end

    @jobs = @jobs.page(params[:page]).per(10) # 1ページあたり10件表示

  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy!

    respond_to do |format|
      format.html { redirect_to jobs_path, status: :see_other, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :location, :salary, :company)
    end
end
