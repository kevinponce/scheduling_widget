class Appointments::StepsController < ApplicationController
  layout 'appointment'

  include AppointmentHelper
  include Wicked::Wizard
  steps *Appointment::Steps::ALL

  before_action :set_step

  def show
    @appointment = Appointment.find(params[:appointment_id])
    render_wizard
  end

  def update
    @appointment = Appointment.find(params[:appointment_id])
    @appointment.step = 'active' if step == Appointment::Steps::ALL.last
    @appointment.update(appointment_params(step))
    render_wizard @appointment
  end

  private

  def appointment_params(step)
    permitted_attributes = case step.to_sym
                           when Appointment::Steps::OFFICES
                             [:office_id]
                           when Appointment::Steps::DATE_AND_TIME
                             [:start_time]
                           end

    params.require(:appointment).permit(permitted_attributes)
  end

  def set_step
    @step_sym = step.to_sym
  end
end
