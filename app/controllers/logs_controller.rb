class LogsController < ApplicationController
  before_action :set_log, only: [:show, :update, :destroy]

  # GET /logs
  # GET /logs.json
  def index
    @logs = Log
    .order(start_time: :desc)
    .limit(100)
    .offset(params[:offset])

    render json: @logs
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
    render json: @log
  end

  # POST /logs
  # POST /logs.json
  def create
    @log = Log.new(log_params)

    if @log.save
      render json: @log, status: :created, location: @log
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1
  # PATCH/PUT /logs/1.json
  def update
    @log = Log.find(params[:id])

    if @log.update(log_params)
      head :no_content
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log.destroy

    head :no_content
  end

  private

    def set_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:log_type_id, :start_time, :end_time, :data)
    end
end
