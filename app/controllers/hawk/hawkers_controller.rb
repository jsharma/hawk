require_dependency "hawk/application_controller"
module Hawk
  class HawkersController < ApplicationController
    before_filter :find_hawker, :only => [:show, :edit,:create_update_xpath,:destroy]

    def index
      @hawkers = Hawker.rev_order_by_created.paginate(:page => params[:page], :per_page => 20)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @hawkers }
      end
    end

    def new
      @hawker = Hawker.new
    end

    def create
      @hawker = Hawker.new(params[:hawker])
      if @hawker.save
        flash[:notice] = 'Hawker was successfully created.'
        redirect_to @hawker
      else
        render action: "new" 
      end
    end

    def show #Using same page for show and edit.
      @page_content = page(@hawker.url)
      rescue Exception=> e
        Rails.logger.info "Error:: #{e}"
        redirect_to hawkers_path
    end

    def edit
      @page_content = page(@hawker.url)
      rescue Exception=> e
        Rails.logger.info "Error:: #{e}"
        redirect_to hawkers_path
    end

    def create_update_xpath
      flash[:notice] = "Hawker successfully updated." if @hawker.create_update_xpath(params[:xpath])
      redirect_to edit_hawker_path(@hawker)
    end

    def destroy
      flash[:notice] = "Hawker successfully deleted." if !@hawker.blank? && @hawker.destroy
      redirect_to hawkers_url
    end

    def delete_xpath
      @xpath = Hawk::Xpath.where(id: params[:id]).first
      render :text =>  (!@xpath.blank? && @xpath.destroy) ? "Xpath deleted" : "Unable to delete. Please refresh page and try again."
    end

  private
    def page(url)
      begin
        html = `curl #{url}`
        html = "No content available for such site" if html.blank?
        uri = URI.parse(url.gsub(' ', '').split('?').first)
        @url = "#{uri.scheme}://#{uri.host}/"
        html
      rescue Exception=> e
        Rails.logger.info "Error:: #{e}"
        return "Something went wrong."
      end
    end

    def find_hawker
      @hawker = Hawker.where(id: params[:id]).first
    end
  end
end
