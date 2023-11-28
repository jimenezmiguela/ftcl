class BillsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

  # %i[ ] # Non-interpolated Array of symbols, separated by whitespace
  # %w(foo bar) is a shortcut for ["foo", "bar"]. Meaning it's a notation to write an array of strings separated by spaces instead of commas and without quotes around them.

  before_action :set_bill, only: %i[ show edit update destroy ]
  # layout 'bill_layout'

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
    # byebug
    if @bill.save
      flash.notice = "The bill record was created successfully."
      redirect_to @bill

    else
      flash.now.alert = @bill.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    @bill.update(bill_params)
    if   flash.notice = "The bill record was updated successfully."
      redirect_to @bill

    else
      flash.now.alert = @bill.errors.full_messages.to_sentence
      render :edit
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
  params.require(:bill).permit(:measure, :subject, :author, :status, :summary, :vote, :appropriation, :fiscal_committee, :local_program, :high_priority, :category)
end

def catch_not_found(e)
  Rails.logger.debug("We had a not found exception.")
  flash.alert = e.to_s
  redirect_to bill_path
end

end
