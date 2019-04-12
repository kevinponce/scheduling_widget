class AppointmentsController < ApplicationController
  layout 'appointment'

  include AppointmentHelper

  def index
    @step_sym = Appointment::Steps::SERVICES
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.create(appointment_params)
    redirect_to appointment_step_path(@appointment, Appointment::Steps::OFFICES)
  end

  private

  def appointment_params
    params.require(:appointment).permit(:cpt_codes_id)
  end
end
