class DomainsController < ApplicationController
  require 'csv'
  # GET /domains
  # GET /domains.xml
  def index
    @domains_count = Domain.all.count
    @domains = Domain.list(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @domains }
    end
  end

  # GET /domains/1
  # GET /domains/1.xml
  def show
    @domain = Domain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @domain }
    end
  end

  # GET /domains/new
  # GET /domains/new.xml
  def new
    @domain = Domain.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @domain }
    end
  end

  # GET /domains/1/edit
  def edit
    @domain = Domain.find(params[:id])
  end

  # POST /domains
  # POST /domains.xml
  def create
    @domain = Domain.new(params[:domain])

    respond_to do |format|
      if @domain.save
        format.html { redirect_to(@domain, :notice => 'Domain was successfully created.') }
        format.xml  { render :xml => @domain, :status => :created, :location => @domain }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /domains/1
  # PUT /domains/1.xml
  def update
    @domain = Domain.find(params[:id])

    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        format.html { redirect_to(@domain, :notice => 'Domain was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.xml
  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to(domains_url) }
      format.xml  { head :ok }
    end
  end
  
  def upload
      begin
        @parsed_file=CSV::Reader.parse(params[:form][:file], "\t")
        @parsed_file.each{|record|
          new_dom = Domain.where(:hostname=> record[0]).first || Domain.new
          new_dom.hostname = record[0]
          new_dom.pagerank = record[1].to_i
          new_dom.domainage = record[2] unless record[2] == "\N"
          if new_dom.valid?
            new_dom.save!
          else
            flash[:notice] = "#{record[0]} is not added" 
          end
          }
        redirect_to(:action => "index", flash[:notice] => 'Domains was successfully uploaded.')
      rescue 
        render :action => "upload" 
  end
 end 
 
 def search
   begin
     mysearch = params[:form][:search] 
  rescue
     mysearch = session[:search]
  end
  @domains = Domain.search( mysearch, params[:page])
  session[:search] = mysearch
  render :action => "index" 
 end
 
 def autocomplete
  @domains = Domain.where('hostname like ?', "%#{params[:q]}%").all()
  respond_to do |format|
    format.json {render :json => @domains}
    format.html {render :layout => false}
    format.xml  { render :xml => @domains }
  end
 end
 
  
  
end
