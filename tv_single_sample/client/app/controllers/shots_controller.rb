require 'open-uri'

class ShotsController < ApplicationController
  before_action :set_shot, only: [:show, :edit, :update, :destroy]

  # GET /shots
  # GET /shots.json
  def index
    @shot_shelfs = []
    (1..5).each do |page|
      res = open("http://api.dribbble.com/shots/popular?page=#{page}")
      code, message = res.status # res.status => ["200", "OK"]
      
      if code == '200'
        result = ActiveSupport::JSON.decode res.read
        @shot_shelfs << result["shots"]
      else
        puts "#{code} #{message}"
      end
    end

    render "index.xml.js"
  end

  # GET /shots/1
  # GET /shots/1.json
  def show
  end

  # GET /shots/new
  def new
    @shot = Shot.new
  end

  # GET /shots/1/edit
  def edit
  end

  # POST /shots
  # POST /shots.json
  def create
    @shot = Shot.new(shot_params)

    respond_to do |format|
      if @shot.save
        format.html { redirect_to @shot, notice: 'Shot was successfully created.' }
        format.json { render :show, status: :created, location: @shot }
      else
        format.html { render :new }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shots/1
  # PATCH/PUT /shots/1.json
  def update
    respond_to do |format|
      if @shot.update(shot_params)
        format.html { redirect_to @shot, notice: 'Shot was successfully updated.' }
        format.json { render :show, status: :ok, location: @shot }
      else
        format.html { render :edit }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shots/1
  # DELETE /shots/1.json
  def destroy
    @shot.destroy
    respond_to do |format|
      format.html { redirect_to shots_url, notice: 'Shot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shot
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shot_params
      params[:shot]
    end
end
