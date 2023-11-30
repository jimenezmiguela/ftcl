class BillsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

  before_action :set_bill, only: %i[ show edit update destroy ]

  def index
    @bills=Bill.all
  end

  def show
    set_bill
  end

  def new
    @bill=Bill.new
  end

  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully created." }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    @bill.update(bill_params)

    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully updated." }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
  end

  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
  end
end

private
def set_bill
  @bill = Bill.find(params[:id])
end

def bill_params
  params.require(:bill).permit(:user_id, :measure, :subject, :author, :status, :summary, :vote, :appropriation, :fiscal_committee, :local_program, :high_priority, :category)
end

def catch_not_found(e)
  Rails.logger.debug("We had a not found exception.")
  flash.alert = e.to_s
  redirect_to bill_path
end

end
