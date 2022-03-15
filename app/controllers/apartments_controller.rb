class ApartmentsController < ApplicationController
    before_action :find_apartment, only: %i[show edit update destroy ]
    before_action :get_tenant, only: %i[show]
    

    def index
        @apartments = Apartment.all
    end

    def show 
    end

    def new
        @apartment = Apartment.new
    end

    def create
        @apartment = Apartment.new(apartment_params)
        respond_to do |format|
            if @apartment.save
                format.html { redirect_to @apartment, notice: "Apartment #{@apartment.number} successfully created."}
                format.json { render 'show', status: :created, location: @apartment}
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json  {render json: @listing.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @apartment.update(apartment_params)
                format.html { redirect_to @apartment, notice: "Apartment #{@apartment.number} successfully updated."}
                format.json { render 'show', status: :ok, location: @apartment}
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json  {render json: @listing.errors, status: :unprocessable_entity }
            end
        end

    end

    def destroy 
        @apartment.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: "Apartment #{@apartment.number} was successfully removed from the database." }
            format.json { head :no_content }
        end
    end

    private

    def find_apartment
        @apartment = Apartment.find(params[:id])
    end

    def get_tenant
        # @tenant = Lease.tenant.where(tenant_id )
        
    end

    def apartment_params
        params.require(:apartment).permit(
            :number,
        )
    end
end
