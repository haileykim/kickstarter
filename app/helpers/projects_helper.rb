module ProjectsHelper

  def pledge_end_format(project)
  	if project.expired?
  		content_tag(:span, "Expired", class: "label label-danger")
  	else
  		distance_of_time_in_words(Time.now, project.pledging_ends_on)
  	end
  end

  def pledge_result(project)
  	if project.success?
  	  '100%'
  	else
  	  number_to_percentage(project.pledge_percentage, precision:1)
  	end
  end

end
