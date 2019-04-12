module AppointmentHelper
  def side_nav_item_active_class(step, current_step)
    step_index = Appointment::Steps::ALL.index(step)
    current_step_index = Appointment::Steps::ALL.index(current_step)

    if step_index < current_step_index
      'active'
    elsif step_index == current_step_index
      'current'
    else
      ''
    end
  end
end
