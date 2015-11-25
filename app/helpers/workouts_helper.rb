module WorkoutsHelper

  # TODO spec
  def workout_summary_panel_style(workout)
    return 'panel-info' if workout.done?
    return 'panel-primary' if workout.today?
    return 'panel-warning' if (workout.late? && !workout.skipped?)
    return 'panel-default skipped-workout' if workout.skipped?
    return 'panel-default'
  end

  # TODO spec
  def workout_kind_image_tag(workout)
    image_tag("workout_#{workout.kind}.png", alt: workout.kind, height: 18)
  end

  # TODO spec
  def seconds_to_time(seconds)
    return if seconds.blank?
    Time.at(seconds.to_i).utc.strftime("%H:%M:%S")
  end

  # TODO spec
  def strava_activity_description(activity)
    date = Time.zone.parse(activity[:start_date]).to_date
    image = activity_kind_image(activity)
    "#{image} #{I18n.l date, format: :calendar} #{activity[:name]} <small>(##{activity[:id]})</small>".html_safe
  end

  private

  def activity_kind_image(activity)
    kind = case activity[:type]
    when 'Run'
      'running'
    when 'Swim'
      'swimming'
    else
      'cycling'
    end
    image_tag("workout_#{kind}.png", alt: kind, height: 18)
  end

end
